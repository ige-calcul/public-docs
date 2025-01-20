(mamba)=

# Micromamba

1. Download  and Install micromamba
```bash
cd $WORKDIR
curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
./bin/micromamba shell init -s bash  ./micromamba
source ~/.bashrc
```

```{warning}
 WORKDIR is a large filesystem, do not use the HOME directory for installation
```

2. Create an environment with python=3.10

```bash
micromamba create -n myenv python=3.10 -c conda-forge
```

3. Activate the environment and install a package

```bash
micromamba activate myenv
micromamba install package_name -c conda-forge
```

```{warning}
 In a submission job, you will probably add the following to activate your environment
```

```bash
. $WORKDIR/micromamba/etc/profile.d/micromamba.sh
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

