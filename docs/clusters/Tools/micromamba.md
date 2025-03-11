(mamba)=

# Micromamba

## Download  and Install micromamba
```bash
cd $WORKDIR
curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
./bin/micromamba shell init -s bash  ./micromamba
source ~/.bashrc
```

```{caution}

 WORKDIR should be a large storage, do not use the HOME directory for installation

 On gricad , it could be /bettik/PROJECTS/PROJECT_NAME/USER_NAME

 On ige-clusters, it could be /workdir/TEAM_NAME/USER_NAME or /workdir2/TEAM_NAME/USER_NAME

```


## Create an environment 

```bash
micromamba create -n myenv python=3.10 -c conda-forge
```

## Activate the environment and install a package

```bash
micromamba activate myenv
micromamba install package_name -c conda-forge
```

```{warning}
 In a submission job, you will probably add the following to activate your environment
```

```bash
. $WORKDIR/micromamba/etc/profile.d/micromamba.sh
OR
. $WORKDIR/micromamba/etc/profile.d/mamba.sh
and then 
micromamba activate myenv
```

```{warning}
 On some clusters (for example Dahu), your micromamba process will likely be killed by the system when you try to install environments or packages, because it uses too much memory. In this case, log in to a computation node to perform such tasks.
```

**Example 1:** Create R environment and install R packages

```bash
# Create an environment with python=3.10
micromamba create -n Renv python=3.10 -c conda-forge

# Activate the environment
micromamba activate Renv

# Install R+ netcdf package
micromamba install r r-base r-essentials -c conda-forge
micromamba install r-ncdf4 -c conda-forge
```

**Example 2:** Create a ferret environment 

```bash
# Create an environment with python=3.8 (needed for Gricad clusters to get the display)
micromamba create -n pyferret python=3.8  -c conda-forge pyferret ferret_datasets --yes

# Activate the environment
micromamba activate pyferret
```

```{caution}
Always create an environment for a single tool/application. This way , if you break an environment for a tool, you will still be able to use the others
```

## Clone an environment

Create a yaml file to copy an existing environment:

```bash
micromamba env export -n myenv > myenv.yaml 
```

Create an environment from the yaml file:

```bash
micromamba env create -n myenv-copy  -f  myenv.yaml 
```
## Install a kernel on a jupyter notebook

Once your environment is created it is easy to make it available on a jupyter notebook. 

Install the ipykernel package

```bash
micromamba activate myenv
micromamba install ipykernel  -c conda-forge
```

Then make the environment "myenv" available under the name "My First  Env"

```bash
python -m ipykernel install --name myenv --user --display-name "My First Env"
```

Restart your jupyter notebook and you will be able to choose your environment  **My First Env** among other available environments


