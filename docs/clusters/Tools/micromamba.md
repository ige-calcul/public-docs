(mamba)=

# Micromamba

1. Download  and Install micromamba
```bash
cd $WORKDIR
curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
./bin/micromamba shell init -s bash -p $WORKDIR/micromamba
source ~/.bashrc
```

```{warning}
 WORKDIR is a large filesystem, do not use the HOME directory for installation
```

2. Create an environement with python=3.10

```bash
micromamba create -n myenv python=3.10 -c conda-forge
```

3. Activate the environement and install a package

```bash
micromamba activate myenv
micromamba install YOUR_MODULE -c conda-forge
```

>:warning: In a submission job, you will probably add the following to activate your environment

```bash
. $WORKDIR/micromamba/etc/profile.d/micromamba.sh
micromamba activate myenv
```

**Example:** Create R environment and install R packages

```bash
# Create an environement with python=3.10
micromamba create -n Renv python=3.10 -c conda-forge

# Activate the environement
micromamba activate Renv

# Install R+ netcdf package
micromamba install r r-base r-essentials –c conda-forge
micromamba install r-ncdf4 –c conda-forge
```
