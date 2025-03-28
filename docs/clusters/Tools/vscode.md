(vscode)=


# Vscode 


Visual Studio Code (or VSCODE) is a free, cross-platform code editor that integrates many features and allows you to integrate new ones thanks to a large catalog of plugins.

First install Vscode by the following this [link](https://code.visualstudio.com/)

This doc will explain how to Run vscode directly on cluster frontend or a cluster , this is for Gricad, but can be applied to any other cluster

Install the [Remote SSH extension](https://code.visualstudio.com/docs/remote/ssh). Ensure you have set up your `$HOME/.ssh/config` file and ssh keys so you can access the cluster without any password. See [ Gricad SSH-keys ](../Gricad/dahu.md), or [ Ige SSH-keys](../Ige/ige-calcul1.md)  for details.

## Run on the cluster

Open vscode on your local machine, and open a remote window to dahu/ige-calcul1 (vscode should see your local ssh config file and so recognize the 'dahu' or 'calcul1"  host). You will be connected to the frontend, and you should be to open your files/save them and submit a job from  a vscode terminal.

```{note}

For Gricad clusters, you should now connect to dahu-workflow1 or dahu-workflow2 instead of dahu, otherwise it will be **killed**
Make sure to add these hosts in your **$HOME/.ssh/config file**

```


## Run on Gricad cluster node

```{note}
This example is given to connect a dahu node , but it can be used for bigfoot node , or any other node on Gricad
```

If you want to edit or run code interactively in **a running job** on dahu, you must do some additional configuration. You must be using a linux terminal (e.g. mobaxterm/putty) or you can do this using vscode.

Of course all **these steps are not necessary**, you can just open a new terminal once you are connect to dahu with vscode and use oarsub to request the ressource ans continue on the terminal.

The following steps are more adapted to people who are not familiar with terminal-based text editing tools like vi/vim and would like to work in a GUI style, directly from vscode.

**Config ssh-keys on dahu**

```bash
# On dahu frontend
ssh-keygen -t rsa
```

On your workstation, put the ssh key from dahu in a VSCODE folder:

```bash
# On your local machine
mkdir ~/VSCODE
cd ~/VSCODE
scp dahu:~/.ssh/id_rsa .
```

**Run a job on dahu**

Connected to dahu and run an interactive job:

 ```bash
# On dahu frontend
login_agalan@f-dahu:~$ oarsub -k -i .ssh/id_rsa -I -l nodes=1/core=1,walltime=01:00:00 --project sno-elmerice
[FAST] Adding fast resource constraints
[PARALLEL] Small jobs (< 32 cores) restricted to tagged nodes
[ADMISSION RULE] Modify resource description with type constraints
Import job key from file: .ssh/id_rsa
OAR_JOB_ID=21106958
Interactive mode: waiting...
Starting...

Connect to OAR job 21106958 via the node dahu34
```

Now, on your workstation add these lines to `$HOME/.ssh/config` file. **Make sure that the dahu node (here dahu34) matches the one assigned to your OAR job**.

```
Host dahunode
  ProxyCommand ssh dahu -W "dahu34:%p"
  User oar
  Port 6667
  IdentityFile ~/VSCODE/id_rsa
  ForwardAgent no
```

Make sure to change the name of dahu node, each time you start a new connection, depending on the node you get. Here it is dahu34.

On Vscode, for remote access, it will ask you to choose a server name from the config file, choose **dahunode**. If you just need to acces to dahu, just select **dahu** instead of **dahunode**.

### Debuging

In order to check if vscode is able to connect to a node, once you get the node, you can open a terminal from vscode and type "ssh dahunode", you should get the assigned node.
