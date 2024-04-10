## Slurm

Slurm is an open-source workload manager/scheduler for the Discovery cluster. Slurm is basically the intermediary between the Login nodes and compute nodes. Hence, the Slurm scheduler is the gateway for the users on the login nodes to submit work/jobs to the compute nodes for processing.


__https://slurm.schedmd.com/quickstart.html__


## Connection to the server

Before using slurm, make sure that your are able to connect to the server

```
ssh   your_agalan_login@ige-calcul1.u-ga.fr
```

Then you should ask for a storage space and a slurm account

Available slurm accounts are:
```
cryodyn
meom
phyrev
hmcis
hydrimz
c2h
ecrins
ice3
chianti
```
Please send and email to `mondher.chekki@uXXXX-gYYYY-aZZZZ.fr OR ige-support@uXXXX-gYYYY-aZZZZ.fr, asking for storage under /workdir and a slurm account by providing the name of your team and the space you need (1G,10G,100G,1TB)

## Available softwares

```
- NCO
- CDO
- FERRET
- NCVIEW
- QGIS

```
## Commands


| Command  | Syntax | Description |
| ------------- |:-------------:|:-------------:|
|    sbatch   |sbatch JOBSCRIPT      |Submit a batch script to Slurm for processing.      |
|    squeue  | squeue -u      |Show information about your job(s) in the queue. The command when run without the -u flag, shows a list of your job(s) and all other jobs in the queue.      |
| srun       | srun  -n $NBTASKS $EXE    |  Run jobs interactively  on the cluster    |
| srun       | srun  --mpi=pmix -n $NBTASKS $EXE    |  Run MPI jobs on the cluster    |
| scancel       |  scancel JOBID    | End or cancel a queued job.     |
| sacct       |  sacct -j JOBID     | Show information about current and previous jobs.      |
| scontrol   | scontrol show job JOBID    | Show more details about a running job |
| sinfo      |  sinfo    | Get information about the resources on available nodes that make up the HPC cluster      |


## Job submission example 

Consider you have a script in one of the programming languages such as Python, MatLab, C, Fortran , or Java. How would you execute it using Slurm?

The below section explains a step by step process to creating and submitting a simple job. Also, the SBATCH script is created and used for the execution of a python script or fortran code.

1. Prepare your code/script

Write your python script or compile your fortran code 

**Example of Hello World in MPI `hello_mpi.f90`**

```
PROGRAM hello_world_mpi
include 'mpif.h'

integer process_Rank, size_Of_Cluster, ierror, tag
CHARACTER(256) PNAME
INTEGER RESULTLEN

call MPI_INIT(ierror)
call MPI_COMM_SIZE(MPI_COMM_WORLD, size_Of_Cluster, ierror)
call MPI_COMM_RANK(MPI_COMM_WORLD, process_Rank, ierror)
call MPI_GET_PROCESSOR_NAME( PNAME, RESULTLEN, ierror)

print *, 'Hello World from process: ', process_Rank, 'of ', size_Of_Cluster
print *, 'Hello World from process: ', PNAME(1:RESULTLEN)

call MPI_FINALIZE(ierror)
END PROGRAM
```

Compile the code using mpif90
```
mpif90 -o hello_mpi  hello_mpi.f90
```
Now you have an executable hello_mpi that you can run using slurm

2. Create your submission job

A job consists in two parts: **resource requests** and **job steps**.

**Resource requests** consist in a number of CPUs, computing expected duration, amounts of RAM or disk space, etc.
**Job steps** describe tasks that must be done, software which must be run.

The typical way of creating a job is to write a submission script. A submission script is a shell script. If they are prefixed with SBATCH, are understood by Slurm as parameters describing resource requests and other submissions options. You can get the complete list of parameters from the sbatch manpage man sbatch or sbatch -h.

In this example, `job.sh` contains ressources request (lines starting with #SBATCH) and the run of the previous generated executable.

```
#!/bin/bash
#SBATCH -J helloMPI 

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --account=cryodyn

#SBATCH --mem=4000

#SBATCH --time=01:00:00
#SBATCH --output helloMPI.%j.output
#SBATCH --error  helloMPI.%j.error


cd /workdir/$USER/

## Run an MPI program

srun  --mpi=pmix -N 1  -n  4 ./hello_mpi


## Run a python script 
#  python script.py

```

job.sh request 4 cores for 1 hour, along with 4000 MB of RAM, in the default queue. 
The account is important in order to get statisticis about the number of CPU hours consumed within the account:
_make sure to be part of an acccount before submitting any jobs_

When started, the job would run the hello_mpi program using 4 cores in parallel. 
To run the `job.sh` script use sbatch command and squeue to see the state of the job

```
chekkim@ige-calcul1:~$ sbatch job.sh
Submitted batch job 51
chekkim@ige-calcul1:~$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
                51    calcul helloMPI  chekkim  R       0:02      1 ige-calcul1
```
3. Interactive mode


For interactive mode  you should use the srun/salloc commands 
An equivalent to the `job.sh` should be

```
Run mpi hello example with 4 cores

srun --mpi=pmix -n 4 -N 1 --account=cryodyn --mem=4000 --time=01:00:00 hello_mpi

Run Qgis with 8 threads (graphic interface)

srun --mpi=pmix -n 1 -c 8 -N 1 --account=cryodyn --mem=4000 --time=01:00:00 qgis

Run Jupiter notebook with 4 threads

srun --mpi=pmix -n 1 -c 4 -N 1 --account=cryodyn --mem=4000 --time=01:00:00 jupyter notebook

Run matlab  with 4 threads

module load matlab/R2022b
srun --mpi=pmix -n 1 -c 4 -N 1 --account=cryodyn --mem=4000 --time=01:00:00 matlab  -nodisplay -nosplash -nodesktop  -r "MATLAB_command"
or
srun --mpi=pmix -n 1 -c 4 -N 1 --account=cryodyn --mem=4000 --time=01:00:00 matlab  -nodisplay -nosplash -nodesktop  -batch "MATLAB_command"
or
srun --mpi=pmix -n 1 -c 4 -N 1 --account=cryodyn --mem=4000 --time=01:00:00 matlab  -nodisplay -nosplash -nodesktop < test.m

```
Example of job_matlab.sh

```
#!/bin/bash
#SBATCH -J matlab

#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --account=cryodyn

#SBATCH --mem=4000

#SBATCH --time=01:00:00
#SBATCH --output matlab.%j.output
#SBATCH --error  matlab.%j.error


cd /workdir/$USER/

## Run an Matlab

module load matlab/R2022b
srun --mpi=pmix -n 1 -c 4 -N 1  matlab -nodisplay -nosplash -nodesktop  -r "MATLAB_command"
or
srun --mpi=pmix -n 1 -c 4 -N 1  matlab -nodisplay -nosplash -nodesktop  -batch "MATLAB_command"
or
srun --mpi=pmix -n 1 -c 4 -N 1  matlab  -nodisplay -nosplash -nodesktop < test.m

```

4.  For Python users

   You should use micromamba instead of conda/miniconda 
   https://mamba.readthedocs.io/en/latest/user_guide/micromamba.html
   Micromamba is just faster then conda
   
```
   # Download micromamba

curl -L micro.mamba.pm/install.sh >install.sh

# Installation de micromamba

bash install.sh

source ~/.bashrc

# Creation d’un environnment avec python=3.10

micromamba create -n myenv python=3.10 -c conda-forge

# Activation de l’environnement

micromamba activate myenv

micromamba install YOUR_MODULE -c conda-forge
```

5. Job Accounting 

Interestingly, you can get near-realtime information about your running program (memory consumption, etc.) with the sstat command

```
sstat -j JOBID
```

It is possible to get informations and statistics  about you job after they are finished using the **sacct/sreport** command (sacct -h for more help)

```
chekkim@ige-calcul1:~$ sacct  -j 51  --format="Account,JobID,JobName,NodeList,CPUTime,MaxRSS,State%20"
   Account        JobID    JobName        NodeList    CPUTime     MaxRSS                State
---------- ------------ ---------- --------------- ---------- ---------- --------------------
   cryodyn 51             helloMPI     ige-calcul1   00:00:20                       COMPLETED
   cryodyn 51.batch          batch     ige-calcul1   00:00:20       132K            COMPLETED
   cryodyn 51.0          hello_mpi     ige-calcul1   00:00:12      3564K            COMPLETED


**MaxRSS: Maximum RAM used by the job, you can also get the MAximum RAM used by a given task
```
