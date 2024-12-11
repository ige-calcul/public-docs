(clustertips)=

# General tips

## GUI applications on clusters

Even though calculators are accessed via a text-based SSH connection, you can usually open applications that have a
graphical user interface (GUI) and which are installed on the calculator (for example: `ncview`). In this case, the
application is run remotely on the calculator but the GUI window(s) are opened locally on your own computer. This is
done through a process called _X-forwarding_. To use it, you must have an X-server installed on your own computer. If
your computer is a GNU/Linux system, it should be installed by default. On MacOS, the recommended X-server is XQuartz,
which you can install either by downloading the package file from the [official XQuartz
webpage](https://www.xquartz.org/) or by using brew:

```
brew install --cask xquartz
```

Once an X-server is available on your system, use the `-X` option to activate X-forwarding when connecting to the
calculator:

```
ssh -X username@calculator.address
```

You can now launch GUI applications from the calculator.

```{caution}
For security reasons, `-X` is prefered over `-Y` to activate X-forwarding when connecting to a remote host (`man ssh`
for more information).
```

If you use X-forwarding, you might observe that it stops working after some time, even though the SSH session still
works. This is because most SSH servers are configured by default to drop X-forwarding after some time has passed. You
can deactivate this timeout in the `~/.ssh/config` file on the client side (ie. on your own computer):

```
Host *
     ForwardX11Timeout 0
```
