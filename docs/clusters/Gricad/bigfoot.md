(bigfoot)=


# Bigfoot

In order to connect , you should refer to the dahu page to create the ssh keys , the connection is the same, here are the differences:

 In the file **$HOME/.ssh/config** : 
  
```
Host bigfoot 
ProxyCommand ssh -qX login_gricad@trinity.u-ga.fr nc bigfoot.u-ga.fr 22  
User login_gricad  
GatewayPorts yes
```

```{warning}
replace **login_gricad** with yours
```
  
Next, you need to set the correct rights:  

```
chmod ugo-rwx .ssh/config 
chmod u+rw .ssh/config
```


```{warning}
keep read/write rights only for the user and the private key: id_rsa
```
  
Then, copy the ssh keys  
```
ssh-copy-id login_gricad@trinity.u-ga.fr 
```
 
Enter the agalan passwod  

then 

```
ssh-copy-id bigfoot
```
  
Enter the agalan password  
  
and you should be good for future sessions.  

# Submit a job

You should use OAR to  submit your job


# Make a reservation to avoid waiting in the queue 

In this example the reservation is made for the Grace Hopper Gh200 (only one is available)

```
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

```
chekkim@bigfoot:~$ oarsub -r '2025-01-26 08:00:00' -t container=testres -l /nodes=1/gpu=2,walltime=1:00:00  --project sno-elmerice -p "gpumodel='A100' or gpumodel='V100'"
```

Now check the status of the reservation , if it is running then ok

```
chekkim@bigfoot:~$ oarstat -u
Job id    S User     Duration   System message
--------- - -------- ---------- ------------------------------------------------
2870075   R chekkim     0:07:45 R=72,W=0:59:53,J=R,P=sno-elmerice,T=container=testres|gh
```

# Use the reservation 

Now connect directly to the node and start using the ressources

```
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


