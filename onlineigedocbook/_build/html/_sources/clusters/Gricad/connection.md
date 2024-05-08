## Connect to Gricad clusters

More details about Griccad infrastructure are available here:

**https://gricad-doc.univ-grenoble-alpes.fr/hpc/**

**Get your account on Gricad**

If you have an **agalan** login/password

https://perseus.univ-grenoble-alpes.fr/create-account/portal-agalan

if not, create an external account with the email from your institution (private email @gmail/@yahoo are not allowed)

https://perseus.univ-grenoble-alpes.fr/create-account/form

Once you created your account, you should receive an email from perseus that asks you to validate your account with a **KEY** provided in the email

Connect again to perseus and enter the provided **KEY** et it should be ok.

It should take 1 day to get your account activated. If you nee a rapid accesss, feel free to contact **mondher.chekki@XXXXX**

  ```mermaid
graph TD;
A[f-dahu] --> B(dahu33);
A --> C(........);
A --> D(dahu192);
A --> E(dahu-fat1);
A --> F(............);
A --> G(dahu-fat4);
A --> H(dahu-visu);
```

**Create an ssh key**
```
ssh-keygen -t rsa
```

Type **Enter** twice WITHOUT ENTERING ANY PASSWORD and you should have two keys in **$HOME/.ssh**

a private key: id_rsa
a public key : id_rsa.pub

**Create config file**


Then create the **$HOME/.ssh/config** file on your computer , in which you must enter the bastion and server information for the connection.

replace login_gricad with yours

For Dahu server:

  ```
Host dahu
ProxyCommand ssh -qX login_gricad@trinity.u-ga.fr nc 129.88.197.54 22
User login_gricad
GatewayPorts yes
```


Next, you need to set the correct rights:

**chmod ugo-rwx .ssh/config**
**chmod u+rw .ssh/config**

keep read/write rights only for the user and the private key: id_rsa

Then, copy the ssh keys
 ```
ssh-copy-id login_gricad@trinity.u-ga.fr
  ```

Enter the agalan passwod

then
 ```
ssh-copy-id dahu
```

Enter the agalan password

and you should be good for future sessions.

Now, to connect, just type
 ```
ssh dahu
```
