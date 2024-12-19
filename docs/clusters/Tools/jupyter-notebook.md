# Create  jupyter environment and run using python 3.10

```
 micromamba create --name jupyter python=3.10 -c conda-forge
 micromamba activate jupyter
 micromamba install jupyter
 jupyter notebook --generate-config
```

In:  $HOME/.jupyter/jupyter_notebook_config.py
Add these two lines:

```
c.NotebookApp.open_browser = False
c.NotebookApp.ip = '0.0.0.0
```

# Connecting to the compute node from dahu

 Once on dahu, reserve resources in interactive mode

```
[f-dahu /home/chekkim ]$ oarsub -I -l nodes=1/core=1,walltime=01:00:00 --project elmerice
[PARALLEL] Small jobs (< 32 cores) restricted to tagged nodes
[FAST] Adding fast resource constraints
[ADMISSION RULE] Modify resource description with type constraints
OAR_JOB_ID=14860483
Interactive mode: waiting...
Starting...

Connect to OAR job 14860483 via the node dahu120
```

Now activate the environement and run jupyter notebook 

```
[dahu120 /home/chekkim ]$ micromamba activate jupyter

(jupyter) [dahu120 /home/chekkim ]$ jupyter notebook
[I 15:26:59.781 NotebookApp] Serving notebooks from local directory: /home/chekkim
[I 15:26:59.782 NotebookApp] Jupyter Notebook 6.2.0 is running at:
[I 15:26:59.782 NotebookApp] http://dahu120:8888/?token=7cf2f5e1573407ea2b9a99b311d8ae3250bc0eec8530e1e2
[I 15:26:59.782 NotebookApp] or http://127.0.0.1:8888/?token=7cf2f5e1573407ea2b9a99b311d8ae3250bc0eec8530e1e2
[I 15:26:59.782 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 15:26:59.790 NotebookApp]

    To access the notebook, open this file in a browser:
        file:///home/chekkim/.local/share/jupyter/runtime/nbserver-266494-open.html
    Or copy and paste one of these URLs:
        http://dahu120:8888/?token=7cf2f5e1573407ea2b9a99b311d8ae3250bc0eec8530e1e2
     or http://127.0.0.1:8888/?token=7cf2f5e1573407ea2b9a99b311d8ae3250bc0eec8530e1e2
[I 15:28:39.390 NotebookApp] 302 GET /?token=7cf2f5e1573407ea2b9a99b311d8ae3250bc0eec8530e1e2 (129.88.197.54) 0.530000ms
```

On your local terminal, type the following command to create a connection between the dahu120 compute node and your computer

```
chekkim@DESKTOP-EAJKALM:~$ ssh -fNL 8888:dahu120:8888 dahu
```

Then open in a browser (firefox/chrome or other) the link indicated when executing the “jupyter notebook” command on the dahu120 node, i.e. 

```
http://127.0.0.1:8888/?token=7cf2f5e1573407ea2b9a99b311d8ae3250bc0eec8530e1e2
```

You should now  be able to access the notebook as if you were directly on the compute server. 
```{caution}
If the default port 8888 is already in use, use  another port (8889):  you can specify it in the jupiter command (-port XXXX ) or by adding it to the $HOME/.jupyter/jupyter_notebook_config.py file
```


`````{admonition} Install jupyterlab
:class: tip
```
micromamba  install  jupyterlab -c conda-forge
```
Then replace in the browser tree by lab
`````

`````{admonition} Show personal kernel
:class: tip
```
python -m ipykernel install --user --name jupyter --display-name “Python 3.10 (Jupyter)”
```
You will be able to select this kernel  **Python 3.10 (Jupyter)** on your web browser
`````

