
# Enable Windows Subsystem for Linux

```
Type in the research bar: Turn Windows features
```

![](./images/wsl4.png)

Or for Windows french version 
```
Type in the research bar: Activer fonctionalités Windows
```

![](./images/wsl1.png)

![](./images/wsl2.png)

```
-  Reboot
-  Install ubuntu  version 22 or later  , from Microsoft/Windows store and then run the ubuntu application
```


```{caution}
If you are not able to see theses feature, you need to enable developer mode . To do this on Windows 
```

```
-  Go to Settings > Update & Security > For Developers > Developer Mode.
-  Search directly in the search bar of windows “Developer mode”

```
![](./images/wsl3.png)


# Using the graphical interface 

By default, ubuntu installation does not support graphical modules. To access graphics under Windows

Download:

https://sourceforge.net/projects/vcxsrv/files/latest/download

then, once installed, run Xlaunch

![](./images/xlaunch.png)
 
then launch ubuntu on your personal machine and place this line in your $HOME/.bashrc terminal

```
export LIBGL_ALWAYS_INDIRECT=1
export DISPLAY=localhost:0.0
```

then

```
source .bashrc
```

PS: the .bashrc is not visible just with the ls command, you need to use ls -a

Try  now running an xterm locally to test first:

```
sudo apt-get update

sudo apt-get install xterm

xterm
```

Once X11 is up and running, connect with ssh -X 

ssh -X dahu (ssh -X bigfoot)

The connection is made taking into account the display export, i.e. if you launch a graphical interface directly on dahu/bigfoot or the nodes, it should be displayed on the personal computer.



