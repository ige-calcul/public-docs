# TGCC

## Introduction

The [TGCC (très grand centre de calcul)](https://www-hpc.cea.fr/en/TGCC.html) is managed by [GENCI](https://www.genci.fr/en) (grand équipementier national de calcul intensif) and is one of the three national-scale computing centers, along with IDRIS and CINES.

The main sources of information for TGCC are:

 - The [eDARI website](https://www.edari.fr/) for everything related to computing resource allocations and account creation. In particular, check out its [documentation page](https://www.edari.fr/documentation/index.php/Documentation_compl%C3%A8te). Note that DARI stands for demande d'attribution de ressources informatiques.

 - The [TGCC technical documentation](https://www-hpc.cea.fr/tgcc-public/en/html/tgcc-public.html), which can also be accessed via the command `machine.info` once you are logged into TGCC.

## Getting an account

TGCC user accounts must be associated to one or more existing projects that received a resource allocation. Most likely, when you arrive at IGE, you will join an existing project instead of applying for a new allocation. You will then have to fill out a form to ask to join this project (detailed instructions can be found [here](https://www.edari.fr/documentation/index.php/Documentation_compl%C3%A8te#ModalitesAccesCalculateurs)). Reach out to IGE's IT department to help you fill out the form and to sign it (their approval and signature are mandatory).

When you fill this form, you will be asked to provide one or more IP address(es). Once your account is created, you will be able to log into TGCC only from these registered addresses. The most convenient is to give TGCC the IP address of an IGE server that can be accessed via SSH, and set up a proxy jump so that your connexion to TGCC is established via this server. In order to configure the proxy jump on GNU/Linux or MacOS, add something like this to your `~/.ssh/config` (modify as needed):

```
Host IGE
     HostName address_of_the_IGE_server
     User your_IGE_user_name

Host TGCC
     ProxyJump IGE
     HostName address_of_the_TGCC_server
     User your_TGCC_user_name
```

You can then connect to TGCC with the command:

```
ssh TGCC
```
