## Connection to the server

Before using slurm, make sure that your are able to connect to the server

```
ssh   your_agalan_login@ige-calcul1.u-ga.fr
```

If you want to connect without using a password and from outside the lab, add these 4 lines to the file $HOME/.ssh/config (create it if you don't have it)

```
Host calcul1
ProxyCommand ssh -qX   your_agalan_login@ige-ssh.u-ga.fr nc -w 60  ige-calcul1.u-ga.fr  22
User  your_agalan_login
GatewayPorts yes
```
then you should  create and copy your ssh keys to the server
```
ssh-keygen -t rsa (tape Enter twice without providing a password)
ssh-copy-id  your_agalan_login@ige-ssh.u-ga.fr
ssh-copy-id calcul1
```
Now, you should be able to connect without any password
```
ssh calcul1
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
