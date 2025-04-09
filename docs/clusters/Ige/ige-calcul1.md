(igecal1)=

# IGE clusters


IGE computing servers are  ige-calcul[1-4]:{ ige-calcul1, ige-calcul2, ige-calcul3, ige-calcul4}

You can replace calcul1 by calcul2,3,4 in the following documentation depending on the cluster your choose

### Features of the clusters




|          | ige-calcul1     | ige-calcul2   |  ige-calcul3    | ige-calcul4       |
| ---------|:---------------:|:-------------:|:--------------:|:------------------:|
| CPU      | 2 CPU 24c (48c) |2 CPU 18c (36c)|2 CPU 28c (56c) | 2 CPU 16c (32c)    |
| Total CPU avec HT  | 96          |72             |112             | 64                 |
| RAM      |  256 Go         |  512 Go       |  768 Go        | 256 Go             |
| GPU      | NVIDIA A40 (46G)     |   NO     | NVIDIA RTX 6000 (24G)| 2 NVIDIA RTX A4500 (2x20G) |


## Connection to the server

Before using slurm, make sure that you are able to connect to the server:

```
ssh your_agalan_login@ige-calcul1.u-ga.fr
```

If you want to connect without using a password and from outside the lab, add these 4 lines to the file $HOME/.ssh/config (create it if you don't have it):

```
Host calcul1
  ProxyCommand ssh -qX your_agalan_login@ige-ssh.u-ga.fr nc -w 60 ige-calcul1.u-ga.fr 22
  User your_agalan_login
  GatewayPorts yes
```

then you should create and copy your ssh keys to the server:

```bash
ssh-keygen -t rsa (tape Enter twice without providing a password)
ssh-copy-id your_agalan_login@ige-ssh.u-ga.fr
ssh-copy-id calcul1
```

Now, you should be able to connect without any password:

```bash
ssh calcul1
```

```{note}
Once connected to the cluster , you will need to manage your files and your codes.
If you are not familair with editors like vim, emacs , nano, you can use [VScode](../../clusters/Tools/vscode.md)
```

Then you should ask for a storage space and a slurm account.

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

Please send an email to `mondher.chekki@uXXXX-gYYYY-aZZZZ.fr asking for storage under /workdir and /worldir2 and a slurm account by providing the name of your team and the space you need (1G,10G,100G,1TB).


## Available softwares

```
- NCO
- CDO
- FERRET
- NCVIEW
- QGIS
- MATLAB (through modules,i.e: module load matlab)
```

## Slurm: Submit a job on the cluster

Slurm is an open-source workload manager/scheduler for the Discovery cluster. Slurm is basically the intermediary between the Login nodes and compute nodes.

Hence, the Slurm scheduler is the gateway for the users on the login nodes to submit work/jobs to the compute nodes for processing.

The [official documentation for slurm](https://slurm.schedmd.com/quickstart.html).



## Slurm useful Commands

| Command  | Syntax        | Description   |
| ---------|:-------------:|:-------------:|
| sbatch   | `sbatch JOBSCRIPT`                  | Submit a batch script to Slurm for processing. |
| squeue   | `squeue -u`                         | Show information about your job(s) in the queue. The command when run without the -u flag, shows a list of your job(s) and all other jobs in the queue. |
| srun     | `srun  -n $NBTASKS $EXE`            | Run jobs interactively  on the cluster |
| srun     | `srun  --mpi=pmix -n $NBTASKS $EXE` | Run MPI jobs on the cluster |
| scancel  | `scancel JOBID`                     | End or cancel a queued job. |
| sacct    | `sacct -j JOBID`                    | Show information about current and previous jobs (cf 5. Job Accounting for example) |
| scontrol | `scontrol show job JOBID`           | Show more details about a running job |
| sinfo    | `sinfo`                             | Get information about the resources on available nodes that make up the HPC cluster |
| seff     | `seff JOBID`                        | Provides statistics related to the efficiency of resource usage by the completed job.


## Available working directories

There are 2 working directories available on the clusters
```bash
/workdir   (only on ige-calcul1)
/workdir2  (available on all clusters: SUMMER STORAGE)
```

##  Running jupyter notebooks on the clusters

 If you just need to connect to the cluster and run jupyter notebook or a code, you can do it by using the jupyterhub
 By connecting , it will automatically submit a job with the ressources you asked and open a jupyterlab for you
 You can also access the vscode via the browser automatically. This vscode is running at the same time of your job and using the same ressources.
 Please refer to this doc [How to run jupyter notebooks on Ige clusters](../../clusters/Tools/jupyterhub.md)

## Running python code on the clusters 

We recommend that you use [micromamba](https://mamba.readthedocs.io/en/latest/user_guide/micromamba.html) instead of conda/miniconda.

Micromamba is just faster then conda !

Check [here](../../clusters/Tools/micromamba.md) how to set up your python environement with micromamba.


## Job submission example

Consider you have a script in one of the programming languages such as Python, MatLab, C, Fortran , or Java. How would you execute it using Slurm?

The following section explains a step by step process to creating and submitting a simple job. Also, the SBATCH script is created and used for the execution of a python script or fortran code.

1. Prepare your data/code/script

Copy your files to the server with rsync:

```bash
rsync -rav  YOUR_DIRECTORY  calcul1:/workdir/your_slurm_account/your_agalan_login/
```

Then write your python script or compile your fortran code.

**Example of Hello World in MPI `hello_mpi.f90`**

```fortran
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

Compile the code using mpif90:

```bash
mpif90 -o hello_mpi  hello_mpi.f90
```

Now you have an executable hello_mpi that you can run using slurm.

2. Create your submission job

A job consists in two parts: **resource requests** and **job steps**.

* **Resource requests** consist in a number of CPUs, computing expected duration, amounts of RAM or disk space, etc.
* **Job steps** describe tasks that must be done, software which must be run.

The typical way of creating a job is to write a submission script. A submission script is a shell script. If they are prefixed with SBATCH, are understood by Slurm as parameters describing resource requests and other submissions options. You can get the complete list of parameters from the sbatch manpage man sbatch or sbatch -h.

In this example, `job.sh` contains ressources request (lines starting with #SBATCH) and the run of the previous generated executable.

```bash
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

`job.sh` request 4 cores for 1 hour, along with 4000 MB of RAM, in the default queue.

```{caution}
The account is important in order to get statisticis about the number of CPU hours consumed within the account: _make sure to be part of an acccount before submitting any jobs_
```

When started, the job would run the hello_mpi program using 4 cores in parallel. To run the `job.sh` script use `sbatch` command and `squeue` to see the state of the job:

```bash
chekkim@ige-calcul1:~$ sbatch job.sh
Submitted batch job 51
chekkim@ige-calcul1:~$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
                51    calcul helloMPI  chekkim  R       0:02      1 ige-calcul1
```
##  Gpu support

To use gpus in a job , add the following in your submission file

```bash
#SBATCH --gres=gpu:1
```
or for 2 gpus 

```bash
#SBATCH --gres=gpu:2
```


## Use the interactive mode


For interactive mode you should use the srun or salloc commands.

The most common way is to use the **srun** followed by **--pty bash -i**. Then you can run any program you need.

```bash
srun --nodes=1  --ntasks=4  --mem=40000 --time=01:00:00 --pty bash -i
```

to use gpu add the  --gres=gpu command

```bash
srun --nodes=1 --gres=gpu:1 --ntasks=4  --mem=40000 --time=01:00:00 --pty bash -i
```
or to use 2 gpus

```bash
srun --nodes=1 --gres=gpu:2 --ntasks=4  --mem=40000 --time=01:00:00 --pty bash -i
```

If you use  **srun** followed by **your program** (without running the previous command) it will allocate the ressource, run the program and exit.

An equivalent to the `job.sh` will be :

  - Run mpi hello example with 4 cores

```bash
srun --mpi=pmix -n 4 -N 1 --account=cryodyn --mem=4000 --time=01:00:00 hello_mpi
```

==> This will run and exit once it is done

or

```bash
srun --mpi=pmix -n 4 -N 1 --account=cryodyn --mem=4000 --time=01:00:00 --pty bash -i
and then
srun --mpi=pmix -n 4 ./hello_mpi
```

==> This will keep the ressources even when the program is done


  - Run Qgis with 8 threads (graphic interface) and 4000 MB of RAM 

```bash
srun --mpi=pmix -n 1 -c 8 -N 1 --account=cryodyn --mem=4000 --time=01:00:00 qgis
or
srun --mpi=pmix -n 1 -c 8 -N 1 --account=cryodyn --mem=4000 --time=01:00:00 --pty bash -i
and then  
qgis
```

  - Run Jupiter notebook with 4 threads

```bash
srun --mpi=pmix -n 1 -c 4 -N 1 --account=cryodyn --mem=4000 --time=01:00:00 jupyter notebook
```

  - Run matlab  with 4 threads

```bash
module load matlab/R2022b
srun --mpi=pmix -n 1 -c 4 -N 1 --account=cryodyn --mem=4000 --time=01:00:00 matlab  -nodisplay -nosplash -nodesktop  -r "MATLAB_command"
# or
srun --mpi=pmix -n 1 -c 4 -N 1 --account=cryodyn --mem=4000 --time=01:00:00 matlab  -nodisplay -nosplash -nodesktop  -batch "MATLAB_command"
# or
srun --mpi=pmix -n 1 -c 4 -N 1 --account=cryodyn --mem=4000 --time=01:00:00 matlab  -nodisplay -nosplash -nodesktop < test.m
```

  - Example of job_matlab.sh :

```bash
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

## Run on Matlab
module load matlab/R2022b
srun --mpi=pmix -n 1 -c 4 -N 1  matlab -nodisplay -nosplash -nodesktop  -r "MATLAB_command"
# or
srun --mpi=pmix -n 1 -c 4 -N 1  matlab -nodisplay -nosplash -nodesktop  -batch "MATLAB_command"
# or
srun --mpi=pmix -n 1 -c 4 -N 1  matlab  -nodisplay -nosplash -nodesktop < test.m
```

## How to check the  available ressources

```{caution}

If your job is pending, you need to wait for the ressources or adapt you submission file
You can get the available memory/cpus on the cluster with the squeue command

```
```
[ige-calcul1  /home/chekkim ]$    sinfo -NO "CPUs:8,CPUsState:16,Memory:9,AllocMem:10,Gres:14,GresUsed:24,NodeList:50"
```
|CPUS        |  CPUS(A/I/O/T)    |  MEMORY   |   ALLOCMEM | GRES     |   GRES_USED   |   NODELIST|
|------------|:-----------------:|:---------:|:----------:|:--------:|:-------------:|:-------------:|
|96          |  48/48/0/96       |  240000   |   225920   |  gpu:1   |       gpu:1   |   ige-calcul1 |


**CPUS(A I T):**:

A:  Allocated (Used)   I:   Idle (free)   T:   Total (Total)

Available Memory= MEMORY  - ALLOCMEM

If your job is slow, you should check the CPU_LOAD and make sure it is equivalent to the number of Allocated CPUS.
For this example , the CPU_LOAD is 101 and the allocated is 0, on ige-calcul3, which means that there are some programs running on the background and they are not using SLURM and this is not **NORMAL** 

```
chekkim@ige-calcul3:~$ sinfo  -o "%20N   %10O %10c  %15C"
```

| NODELIST   |     CPU_LOAD  |      CPUS    |      **CPUS(A I T)**  | 
|------------|:-------------:|:------------:|:---------------------:|
|ige-calcul3 |       101.33  |      112     |          0 112 112    | 


## Code efficiency on the cluster

Once the job is finished you can get direct statistics using the seff command (for more statistics , refer to the accounting section below)
Here is the outputs for another job , more memory consuming (we asked in this job for 20000 MB ~~ 19.53 GB)

```bash
[ige-calcul1  /home/chekkim ]$    seff 501759
Job ID: 501759
Cluster: ige-calcul1
User/Group: chekkim/ige-cryodyn
State: COMPLETED (exit code 0)
Nodes: 1
Cores per node: 2
CPU Utilized: 00:01:16
CPU Efficiency: 49.35% of 00:02:34 core-walltime
Job Wall-clock time: 00:01:17
Memory Utilized: 16.00 GB
Memory Efficiency: 81.94% of 19.53 GB (19.53 GB/node)
```

```{warning}
In case you ask for less memory , for this case let's say 10G , you will get the following message:
srun: error: ige-calcul1: task 0: Out Of Memory
srun: launch/slurm: _step_signal: Terminating StepId=501757.0
slurmstepd-ige-calcul1: error: Detected 1 oom-kill event(s) in StepId=501757.0. Some of your processes may have been killed by the cgroup out-of-memory handler.
```


## Job Accounting

You can get near-realtime information about your running program (memory consumption, etc.) with the sstat command:

```bash
sstat -j JOBID
```

It is possible to get informations and statistics  about you job after they are finished using the **sacct/sreport** command (**sacct -e** for more help):

```bash
chekkim@ige-calcul1:~$ sacct  -j 51  --format="Account,JobID,JobName,NodeList,CPUTime,elapsed,MaxRSS,State%20"
   Account        JobID    JobName        NodeList    CPUTime     MaxRSS                State
---------- ------------ ---------- --------------- ---------- ---------- --------------------
   cryodyn 51             helloMPI     ige-calcul1   00:00:20                       COMPLETED
   cryodyn 51.batch          batch     ige-calcul1   00:00:20       132K            COMPLETED
   cryodyn 51.0          hello_mpi     ige-calcul1   00:00:12      3564K            COMPLETED


**MaxRSS: Maximum RAM used by the job, you can also get the MAximum RAM used by a given task
```


