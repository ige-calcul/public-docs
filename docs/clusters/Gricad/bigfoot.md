# Bigfoot



# Make a reservation 

In this example the reservation is made for the Grace Hopper Gh200 (only one is available)

```{bash}
chekkim@bigfoot:~$ oarsub -r '2025-01-20 10:40:00' -t container=testres -l /nodes=1/gpu=1,walltime=1:00:00  --project sno-elmerice -t gh
[ADMISSION RULE] Adding gpubrand=nvidia constraint by default
[ADMISSION RULE] Use -t amd if you want to use AMD GPUs
[ADMISSION RULE] Adding Grace Hopper constraint
[ADMISSION RULE] Modify resource description with type constraints
OAR_JOB_ID=2870075
Reservation mode: waiting validation...
Reservation valid --> OK
```

If you need to reserve more gpus at once, try A100 ou V100 models and share between users
chekkim@bigfoot:~$ oarsub -r '2025-01-26 08:00:00' -t container=testres -l /nodes=1/gpu=2,walltime=1:00:00  --project sno-elmerice -p "gpumodel='A100' or gpumodel='V100'"



Now check the status of the reservation , if it is running then ok

```{bash}
chekkim@bigfoot:~$ oarstat -u
Job id    S User     Duration   System message
--------- - -------- ---------- ------------------------------------------------
2870075   R chekkim     0:07:45 R=72,W=0:59:53,J=R,P=sno-elmerice,T=container=testres|gh
```


# Use the reservation 
Now connect directly to the node and start using the ressources

```{bash}
chekkim@bigfoot:~$ oarsub -I -t inner=2870075   -l /gpu=1,walltime=00:05:00 --project sno-elmerice -t gh
[ADMISSION RULE] Adding gpubrand=nvidia constraint by default
[ADMISSION RULE] Use -t amd if you want to use AMD GPUs
[ADMISSION RULE] Adding Grace Hopper constraint
[ADMISSION RULE] Modify resource description with type constraints
OAR_JOB_ID=2870114
Interactive mode: waiting...
Starting...
Connect to OAR job 2870114 via the node bigfoot-gh1
oarsh: Using systemd
chekkim@bigfoot-gh1:~$
```

```{notes}
Any member of the project (here sno-elmerice ) can connect to the ressources using the JOBID (-t inner=JOBID)
```


