# Multprocessing the ARFI Simulation study with Kubernetes and Docker

## Description
This part of the project provides the showcase of the parallelisation of ARFI Makita Template using Kubernetes and Docker from this [repository](https://github.com/abelsiqueira/asreview-cloud) developed by [Abel Siquera](https://github.com/abelsiqueira) and [Sergei Romanov](https://github.com/zoneout215). 
Therer more indepth description of the implementation and explanation of the components can be found.

See [asreview/asreview-makita#templates](https://github.com/asreview/asreview-makita#templates) for template rules and formats. The template is described as: ARFI 'All Relevant, Fixed Irrelevant'.

## Data

The performance on the following datasets is evaluated:

- data/van_de_Schoot_2018.csv

## 1\. Preparing Kubernetes for Simulation run
### 1.1\. Start minikube and install RabbitMQ

We need to install and run RabbitMQ on Kubernetes.
Run the following commands takes from [RabbitMQ Cluster Operator](https://www.rabbitmq.com/kubernetes/operator/quickstart-operator.html), and then the `rabbitmq.yml` service.

The `--cpus` argument is the number of CPUs you want to dedicate to minikube. The `--memory` argument is how much RAM overall the arcitecture has.
For `K8s_test1` those arguments must not be specified, when you want to acuire the same `K8s_test1` results just proceed without specifing them.

```bash
minikube start --cpus 16 --memory 60000
kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
```
> **Note**  
>If you want to start the minikube clusters with different parameters you should run, and start again from (2.1):
>```
>minikube stop
>minikube delete
>```


### 1.2\.  Start RabbitMQ configuration by running this: 
```bash
kubectl apply -f rabbitmq.yml
```

### 1.3\.  Create a volume
The volume is necessary to hold the `data`, `scripts`, and the `output`.
Change the `YOURUSER` to your docker user and run the commands:
```bash
minikube ssh -- sudo mkdir -p /mnt/asreview-storage
kubectl apply -f volume.yml
```

### 1.4\.  Prepare the tasker script and Docker image
Change the `YOURUSER` to your docker user and run the commands:
```bash
docker build -t YOURUSER/tasker -f tasker.Dockerfile .
docker push YOURUSER/tasker
```

> **Note**
> * The default tasker assumes that a data folder exists with your data.
> Make sure to provide the `van_de_Schoot_2018.csv` in `data` folder.
> * This command will push the image to Docker. You will need to create an account an login in your terminal with `docker login`.

### 1.5\.  Prepare the worker script and Docker image

```bash
docker build -t YOURUSER/worker -f worker.Dockerfile .
docker push YOURUSER/worker
```

## 2. Running the simulations
The file `worker.yml` contains the configuration of the deployment of the workers. So in order to vary allocation of CPU, RAM and the number of Workers you should alter the file of `worker.yml` in the following parts of the code: 

* Change `replicas` in range betweem `1` to `14` to reproduce varing of CPUs allocation.
* Change `memory` between `1024Mi` and `2048Mi` to reproduce varing of RAM allocation.

> **Note**  
> Setting `replicas` to `16` will work, but it will not speed up the simulations, because 2 CPUs will be taken by RabbitMQ and Tasker components. 


### 2.1\. Running the workers

Change the `image` to reflect the path to the image that you pushed.

Run with

```bash
kubectl apply -f worker.yml
```

Check that the workers are running with the following:

```bash
kubectl get pods
```

You should see some `asreview-worker-FULL-NAME` pods with "Running" status after a while.
Follow the logs of a single pod with

```bash
kubectl logs asreview-worker-FULL-NAME -f
```

You should see something like

```plaintext
Logging as ...
[*] Waiting for messages. CTRL+C to exit
```

## 2.2\. Running the tasker

Similarly, the `tasker.yml` allows you to run the tasker as a Kubernetes job.
Change the `image`, and optionally add a `ttlSecondsAfterFinished` to auto delete the task - I prefer to keep it until I review the log.
Run

```bash
kubectl apply -f tasker.yml
```

## 2.3\. Collecting the computation time

To output the computation time from Tasker run this command and collect the Duration time and store it. In our case time mesurements from the conducted analysis are stored in the parent directory of this repositrory in `data/experiment_resutls.csv`.

```bash 
kubectl get jobs tasker
```

## 3\. Repeating the process 

To restart the process with the same Minikube and RAM settings, but just with different amount of workers 

### 3.1\. Clear the volume component with this command:
```bash
minikube ssh -- sudo rm -rf /mnt/asreview-storage/*
```

### 3.2\. Delete the tasker with this command:
```bash
kubectl delete -f tasker.yml
```

### 3.3\. Clear the RabbitMQ queue with this command:
```bash
kubectl exec rabbitmq-server-0 -- rabbitmqctl delete_queue asreview_queue
```

Come back to the (2.1), alter either `replicas` or `memory` in `worker.yml` and start again.
If you want to restart with default Minkube settings go back to (2.1), but you do not need to build Docker images again, so you can skip (1.4) and (1.5)
