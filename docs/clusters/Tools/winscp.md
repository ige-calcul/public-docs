
# Winscp

## Download/upload files to the cluster

```{note}
Here we are using mantis-cargo to get data from Gricad cluster, but you can use it for any other clusters like ige-calcul{1,2,3,4}

The example of mantis is a direct connection
The ige-calcu1 connection uses a ssh tunnel through ige-ssh proxy
```

You can download the last version from  ![ here ](https://winscp.net/eng/download.php) 

Then follow the next steps:

![](./images/winscp0.PNG)

![](./images/wscp1.PNG)


## Mantis Config


![](./images/winscp1.PNG)

![](./images/winscp2.PNG)


## Ige calcul1 Config


![](./images/wscp2.PNG)
```{note}
In order to connect to ige-calcul1, you need to set-up a ssh tunnel ige-ssh

```
![](./images/wscp3.PNG)

```{caution}
Make sure to change the username **chekkim** by your agalan login
```


## Load the ssh key 

![](./images/wscp21.PNG)

![](./images/wscp22.PNG)

```{note}
At this step make sure you have already generated a key to connect to the cluster.

If not: Open a windows powershell  and type the command (do not give a password for the passphrase, just ENTER twice)

 ssh-keygen.exe -t rsa  

Load to winscp the private key:  **id_rsa** (and not id_rsa.pub) which is in the .ssh folder
```

![](./images/winscp5.PNG)

```{note}
This will load the ssh key and convert it in a ppk format 
```

![](./images/wscp23.PNG)

```{note}
Make sure to select **All files**  to be able to see the private ssh key to load
```

![](./images/wscp24.PNG)

```{note}
Make sure to select the private key, on windows it says **FILE** as it is not recongnized
Once the key is loaded , you can convert it: click on **Save private key** and give it a new name
Example here: old name : id_rsa  and the new name is : id_rsa_winscp.ppk
```


![](./images/winscp6.PNG)

```{note}
For ige-cacul1, add the same key to the tunnel config
```
![](./images/wscp4.PNG)

## Save and connect

Now you should save your configuration and give it a name otherwise everything will be lost

![](./images/wscp5.PNG)

You can now connect and tranfer your files

![](./images/wscp6.PNG)

