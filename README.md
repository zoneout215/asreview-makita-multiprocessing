# ASReview Makita Multiprocessing
![PyPI - License](https://img.shields.io/pypi/l/asreview-makita)

This repository is devoted for a use case demonstration of ASReview Makita with multiprocessing approach.
It contains two examples of parallelisation: `bareMetal` and `Kubernetes`. 

## Table of Contents
* `bareMetal` folder contains an example of Makita parallelisation without  Kubernetes and Docker using GNU package on bare CPUs
* `data` contains the mesurements results of the conducted analysis
* `kubernetes` folder contains an example of Makita parallelisation with Kubernetes and Docker
* `.gitignore` contains the list of files and folders, which are ignored by git
* `analysis-notebook.ipynb` contains metrics computations and figures plotting, which we presented in the analysis 
* `LICENCE` contains the licence of this repository
* `README.md` contains the installation instructions and the description of the repository
* `requirements.txt` contains the list of python packages required for the project



## 0\. Prerequisites
This project was implemented and tested maily on SURF Cloud with Linux OS, so the workflow, which is described below, suits this platform.
They can be easily adapted to other UNIX-like systems, but it is not guaranteed that they will work on Windows without major changes.
Hence, we recommend to use Linux OS for this project reproduction.
This project depends on Python 3.7 or later (python.org/download), and on the following software:

| Software                    | Name and version           |
|-----------------------------|----------------------------|
| Operating System            | Linux Ubuntu (version 20.04) |
| CPU configuration           | 16 core - 64 GB RAM        |
| Cloud host                  | [SURF Cloud](https://www.surf.nl)             |
| Container software          | [Docker](https://kubernetes.io/%20minikube) (version 24.0.0)    |
| Orchestration software      | [Kuberenretes, Minikube](https://kubernetes.io/%20minikube) (version: 1.30.1) |
| Active learning software    | [ASReview](https://asreview.nl/download/) (version 1.2)     |
| Template generator          | [Makita](https://github.com/asreview/asreview-makita) (version 0.6.3)     |
| Message broker              | [RabbitMQ](https://www.rabbitmq.com) (version 3.12.0)  |
| Parallelisation Package     | [GNU parallel](https://www.gnu.org/software/parallel/) (version 20230522)    |

## 1\. Installation on SURF
### 1.1\. Create a workspace with "Ubuntu 20.04 (SUDO enabled)".

### 1.2\. ASReview and other python packages installation:
```python
pip install -r requirements.txt
```

### 1.3\.  GNU installation:
```bash
wget https://ftp.gnu.org/gnu/parallel/parallel-20230522.tar.bz2
tar -xjf parallel-20230522.tar.bz2
cd parallel-20230522
./configure
make
sudo make install
```

### 1.4\. Install docker following [the official documentation](https://docs.docker.com/engine/install/ubuntu/).

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

### 1.5\. Add your user to the docker group:
```bash
sudo usermod -aG docker $USER
```

### 1.6\. Go to [Docker Website](https://www.docker.com) and make an account. Run this: 

``` bash
docker login
``` 
>Note
>Sometimes when you install packages on Linux you need to run `sudo reboot` to reboot your system,
>so it can use new packages.
Log out and log in again. Test that you can run `docker run hello-world`.

### 1.7\. Download minikube and install it.

```bash
curl -LO https://storage.googleapis.com/minikube/releases/v1.30.1/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb
```

### 1.8\. Install `kubectl` following the [official documentation](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management)

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://dl.k8s.io/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

### 1.9\. Install bash completions using the following command:
```bash
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null

```
Log out and log in after installing bash completions.

## License 
This repository is licensed under the MIT License