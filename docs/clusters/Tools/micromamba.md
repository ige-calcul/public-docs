(mamba)=

# Micromamba

1. Download  and Install micromamba
   
```
cd $WORKDIR
curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
./bin/micromamba shell init -s bash -p $WORKDIR/micromamba
source ~/.bashrc
```

```{warning}
 $WORKDIR is a large filesystem, do not use the $HOME directory for installation
```

2. Create an environment with python=3.10

   
```
micromamba create -n myenv python=3.10 -c conda-forge
```


3. Activate the environment and Install a package

   
```
micromamba activate myenv

micromamba install YOUR_MODULE -c conda-forge
```


```{warning}
In a submission job, you will probably add the following to activate your account
```

```
. $WORKDIR/micromamba/etc/profile.d/micromamba.sh
micromamba activate myenv

```

**Example:** Create R environment and install R packages


- Create an environment with python=3.10
        ```micromamba create -n Renv python=3.10 -c conda-forge```
- Activate the environment
        ```micromamba activate Renv```
- Install  R+  netcdf package
        ```micromamba install r  r-base  r-essentials –c conda-forge
        micromamba install r-ncdf4 –c conda-forge```
 
