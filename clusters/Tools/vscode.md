
## Use vscode to run directly on a dahu or  dahu node

Prior to this, you need first to set up the config file and the ssh keys so you can have acces to dahu without any password
cf [SSH-keys](https://github.com/IGE-numerique/ige-calcul/blob/main/schedulers/oar/dahu.md)

**on dahu**

If you run vscode from you home directory, it has access to the config file so it sees the dahu config, just select dahu. You will be connected to dahu front node, and you should be to open your files/save them and submit a job from vscode terminal

**on dahu node**

Once you get the ressource on dahu, you will probably need to run your python code or R code interactively, either you are using a linux terminal(mobaxterm/putty) or you can do this using vscode specially if you have a windows machine

Of course all **these steps are not necessary**, you can just open a new terminal once you are connect to dahu  with vscode and use oarsub to request the ressource ans continue on the terminal

The following steps are more adapted to people who are not familiar with linux editing text as vi/vim and would like to work in a windows style, directly from vscode


**Config ssh-keys on dahu**

```
ssh-keygen -t rsa
```
 
On your workstation:
 
Put the ssh key from dahu  in a  VSCODE folder

```
mkdir VSCODE; cd VSCODE ; scp dahu:~/.ssh/id_rsa .
```
 
 
**Run job**
 
 
You are now connected to Dahu and you need to run a job:

 ```
login_agalan@f-dahu:~$ oarsub -k  -i .ssh/id_rsa  -I -l nodes=1/core=1,walltime=01:00:00 --project sno-elmerice
[FAST] Adding fast resource constraints
[PARALLEL] Small jobs (< 32 cores) restricted to tagged nodes
[ADMISSION RULE] Modify resource description with type constraints
Import job key from file: .ssh/id_rsa
OAR_JOB_ID=21106958
Interactive mode: waiting...
Starting...

Connect to OAR job 21106958 via the node dahu34
```
 
On your  workstation:

Add these lines to $HOME/.ssh/config file. Here make sure that the dahu node (**dahu34**) is the one assigned by OAR

```
Host dahunode                                                                                                                 
ProxyCommand  ssh  dahu -W "dahu34:%p"                                                                                 
User oar                                                                                                                      
Port 6667                                                                                                                     
IdentityFile ~/VSCODE/id_rsa                                                                                                  
ForwardAgent no 
 ````
 
Make sure to change the name of node, each time you start a new connection , depending on the node you get, here it is dahu34

On Vscode, for remote access, it will ask you to choose a server name from the config file, choose **dahunode**
If you just need to acces to dahu, just select **dahu** instead of **dahunode**

**Debuging issue:**

In order to check if vscode is able to connect to a node , once you get the node, you can open a terminal from vscode and type "ssh dahunode", you should get the assigned node
