
 # ASReview Makita Multiprocessing
 This repository is devoted for a use case demonstration of ASReview Makita with multiprocessing approach.

 * `bareMetal` folder contains an example of Makita parallelisation without  Kubernetes and Docker using GNU package on bare CPUs
 * `kubernetes` folder contains an example of Makita parallelisation with Kubernetes and Docker
 * `analysis-notebook.ipynb` contains metrics computations and figures plotting, which we presented in the analysis 
 * 
 * `LICENCE`


## Installation

This project depends on Python 3.7 or later (python.org/download), [ASReview](https://asreview.nl/download/) and [GNU parallel](https://www.gnu.org/software/parallel/) package. Install the following dependencies to run the simulation and analysis in this project.

ASReview installation:
```python
pip install asreview asreview-insights asreview-datatools
```
GNU installation (make sure to change the NUMBER from the installed file):
```bash
wget https://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2
tar -xjf parallel-latest.tar.bz2
cd parallel-NUMBER
./configure
make
sudo make install
```