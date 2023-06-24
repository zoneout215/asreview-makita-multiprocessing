
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

# 2\.Preparation of Kubernetes for Simulation run
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

```bash
minikube ssh -- sudo mkdir -p /mnt/asreview-storage
kubectl apply -f volume.yml
```

### 2.4\.  Prepare the tasker script and Docker image

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

* Change `replicas` in range betweem `1` to `14` to reproduce varing of CPUs allocation/
* Change `memory` between `1024Mi` and `2048Mi` to reproduce varing of RAM allocation.

>Note
> Setting `replicas` to `16` will work, but it will not speed up the simulations, because 2 CPUs will be taken by RabbitMQ and Tasker components. 


### 3.1\. Running the workers

Change the `image` to reflect the path to the image that you pushed.
You can select the number of `replicas` to change the number of workers.

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

## Running the tasker

Similarly, the `tasker.yml` allows you to run the tasker as a Kubernetes job.
Change the `image`, and optionally add a `ttlSecondsAfterFinished` to auto delete the task - I prefer to keep it until I review the log.
Run

```bash
kubectl apply -f tasker.yml
```

Similarly, you should see a `tasker` pod, and you can follow its log.

## Copying the output out of the minikube to your machine

You can copy the `output` folder from the volume with

```bash
kubectl cp asreview-worker-FULL-NAME:/app/workdir/output ./output
```

Also, check the `/app/workdir/issues` folder.
It should be empty, because it contains errors while running the simulate code.
If it is not empty, the infringing lines will be shown.

## Deleting and restarting

If you plan to make modifications to the tasker or the worker, they have to be deleted, respectivelly.

The workers keep running after the tasker is done.
They don't know when to stop.
To stop and delete them, run

```bash
kubectl delete -f worker.yml
```

If you did not set a `ttlSecondsAfterFinished` for the tasker, it will keep existing, although not running.
You can delete it the same way as you did the workers, but using `tasker.yml`.

You can then delete the `volume.yml` and the `rabbit.yml`, but if you are running new tests, you don't need to.

Since the volume is mounted in the minikube, you don't lose the data, and you can run the workers again and inspect or copy them out, if you forgot.
You will lose the execution log, though.

If you want to delete everything in the volume as well, you can run

```bash
minikube ssh -- sudo rm -rf /mnt/asreview-storage/*
```

Running everything again is simply a matter of using `kubectl apply` again.
Of course, if you modify the `.sh` or `.py` files, you have to build the corresponding docker image again.

> **Warning**
>
> The default **tasker** deletes the whole workdir folder to make sure that it is clean when it starts.
> If you don't want this behaviour, look for the "rm -rf" line and comment it out or remove it.
> However, if you run into a "Project already exists" error, this is why.
