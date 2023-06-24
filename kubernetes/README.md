
# 1\. Installation on SURF

### 1.1\. Create a workspace with "Ubuntu 20.04 (SUDO enabled)".

### 1.2\. Install docker following [the official documentation](https://docs.docker.com/engine/install/ubuntu/).
At the time of writing, the commands are:

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### 1.3\. Add your user to the docker group:

```bash
sudo usermod -aG docker $USER
```

### 1.4\. Go to [Docker Website](https://www.docker.com) and make an account. Run this: 

``` bash
docker login
``` 
>Note
>Sometimes when you install packages on Linux you need to run `sudo reboot` to reboot your system,
>so it can use new packages.
Log out and log in again. Test that you can run `docker run hello-world`.

### 1.5\. Download minikube and install it.

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb
```

### 1.6\. Install `kubectl` following the [official documentation](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management)

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://dl.k8s.io/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

### 1.7\. install bash completions using

```bash
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
```

Log out and log in after installing bash completions.

# 2\. Preparation of Kubernetes for Simulation run
### 2.1\. Start minikube and install RabbitMQ

We need to install and run RabbitMQ on Kubernetes.
Run the following commands takes from [RabbitMQ Cluster Operator](https://www.rabbitmq.com/kubernetes/operator/quickstart-operator.html), and then the `rabbitmq.yml` service.

The `--cpus` argument is the number of CPUs you want to dedicate to minikube. The `--memory` argument is how much RAM overall the arcitecture has.
For `K8s_test1` those arguments must not be specified, when you want to acuire the same `K8s_test1` results just proceed without specifing them.

```bash
minikube start --cpus 16 --memory 60000
kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
```
>Note
>If you want to start the minikube clusters with different parameters you should run, and start again from (2.1):

>```
>minikube stop
>minikube delete
>```


### 2.2\.  Start RabbitMQ configuration by running this: 
```bash
kubectl apply -f rabbitmq.yml
```

### 2.3\.  Create a volume
The volume is necessary to hold the `data`, `scripts`, and the `output`.
Change the `YOURUSER` to your docker user and run the commands:
```bash
minikube ssh -- sudo mkdir -p /mnt/asreview-storage
kubectl apply -f volume.yml
```

### 2.4\.  Prepare the tasker script and Docker image
Change the `YOURUSER` to your docker user and run the commands:
```bash
docker build -t YOURUSER/tasker -f tasker.Dockerfile .
docker push YOURUSER/tasker
```

> **Note**
> * The default tasker assumes that a data folder exists with your data.
> Make sure to provide the `van_de_Schoot_2018.csv` in `data` folder.

> * This command will push the image to Docker. You will need to create an account an login in your terminal with `docker login`.

### 2.5\.  Prepare the worker script and Docker image

```bash
docker build -t YOURUSER/worker -f worker.Dockerfile .
docker push YOURUSER/worker
```

## 3. Running the simulations
The file `worker.yml` contains the configuration of the deployment of the workers. So in order to vary allocation of CPU, RAM and the number of Workers you should alter the file of `worker.yml` in the following parts of the code: 

* Change `replicas` in range betweem `1` to `14` to reproduce varing of CPUs allocation.
* Change `memory` between `1024Mi` and `2048Mi` to reproduce varing of RAM allocation.

>Note
> Setting `replicas` to `16` will work, but it will not speed up the simulations, because 2 CPUs will be taken by RabbitMQ and Tasker components. 


### 3.1\. Running the workers

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

## 3.2\. Running the tasker

Similarly, the `tasker.yml` allows you to run the tasker as a Kubernetes job.
Change the `image`, and optionally add a `ttlSecondsAfterFinished` to auto delete the task - I prefer to keep it until I review the log.
Run

```bash
kubectl apply -f tasker.yml
```

## 3.3\. Collecting the computation time

To output the computation time from Tasker run this command and collect the Duration time and store it. In our case time mesurements from the conducted analysis are stored in the parent directory of this repositrory in `data/experiment_resutls.csv`.

```bash 
kubectl get jobs tasker
```

## 4\. Repeating the process 

To restart the process with the same Minikube and RAM settings, but just with different amount of workers 

### 4.1\. Clear the volume component with this command:
```bash
minikube ssh -- sudo rm -rf /mnt/asreview-storage/*
```

### 4.2\. Delete the tasker with this command:
```bash
kubectl delete -f tasker.yml
```

### 4.3\. Clear the RabbitMQ queue with this command:
```bash
kubectl exec rabbitmq-server-0 -- rabbitmqctl delete_queue asreview_queue
```

Come back to the (3.1), alter either `replicas` or `memory` in `worker.yml` and start again.
If you want to restart with default Minkube settings go back to (2.1), but you do not need to build Docker images again, so you can skip (2.4) and (2.5)

