# OpenReproLab

OpenReproLab is a support provided by IGE Calcul to M2 students. The aim is to pool the IGE's best practices around computation, and to put into practice the ideas of Open science and Reproducible research. Students and supervisors are therefore invited to take part in this initiative to co-construct tomorrow's research.

## 2025 session:
Here are some of the features expected in this first round. Everything underneath is subject to potential change.

### What we can provide
- a cloud computing interface based on local resources and services
- several presentations, open to all but directed at the selected students, about Open Science and Reproducible Research, and the various tools and methods to put them into practice at IGE
- support throughout the course: weekly Thursday afternoon slot for discussion and debugging
- preservation of datasets and codes produced during internships.

### For whom ?
- M2 students with a computationally-oriented subject and intermediate needs in terms of computing and storage resources, ex : data exploration/analysis or light software development.
- 10 students maximum

The selected internship are the following :

|   Name of supervisor           |     Name of student          | Title of internship |
|--------------------------------|------------------------------|---------------------|
|       Ruth Price               |                              | CMIP and observational analysis of natural Arctic aerosol processes |
|       Charles Amory            |                              | Évolution de la neige en période de fonte : modélisation et observation au Col du Lautaret |
|       Jordi Bolibar            |                              | Inversions of glacier ice dynamics using physics-informed machine learning |
| Gael Durand/Cyrille Mosbeux    |                              | ISMIP6 et instabilité des calottes marines |
|       Didier Voisin            |                              | CO2 and water atmosphere - surface exchanges in a mountain site |
|       Amaury Dehecq            |                              | Exploiting US spy satellites images to monitor changes in Earth's surface since 1960 |
|       Thierry Penduff          |                              | Etude probabiliste des vagues de chaleur marines |
|       Helene Angot             |                              | Evaluation de la capacité d'absorption de mercure de la forêt amazonienne |
|       Gerhard Krinner          |                              | Distribution spatiale de la neige et de la glace de mer en fonction du niveau de réchauffement global |
| Didier Voisin/Thierry Pellarin |                              | Intercomparaison de modélisations hydrologiques pour une tête de bassin versant alpine, vers une quantification de la vulnérabilité de la ressource en eau des alpages|


### Benefices expected
- for students
  - technical support for computing
  - datascience good practices, IGE compatible

- for supervisors
  - better reproducibility of results
  - long-term storing of datasets and codes
 
- for the lab
  - potential PhD students trained in Open Science
  - co-construction of common practices (student - supervisor - platform - lab)
 
- for science
  - increased visibility and accessibility of deliverables (data, codes, etc.)
 
### Timeline
- January 21-22 : communication to CAPS and e-mail to all-IGE: call for candidates (=supervisors)
- February 18: selection of candidates
- every Thursday starting March 6 until July 31: training session on a tool or method + open slot for discussion and debugging 1pm-4pm
- end of July: Repro-Hackathon and election of the most reproducible intership

### Program of the training sessions
- Details : https://github.com/IGE-OpenReproLab2025/training-sessions-material

### The rules we set for ourselves
- about selection of internships
  - internships aligned with platform themes (computing, open science, etc.)
  - internships compatible with available computing resources (gpu, hpc, etc.)
  - interns from IGE Computing Platform members given priority
  - first-come, first-served rule
  - CoPil IGE Calcul can express a preference for distributing the increase in workload

- no management of trainees, the supervisor remains responsible
- reliable but not unbreakable technical infrastructure, trainees must have a plan B

### Cloud computing interface
- Deployment of a JupyterHub/Lab associated with GRICAD resources mobilized by the NOVA service
- For each user: 1 to 8 CPUs and up to 32 GB RAM guaranteed (expandable according to needs and timing), 100GB individual storage + NFS mounting of a 50 TB SUMMER (shared with the lab) space for medium-term back-up
- Accessible from anywhere via an address such as https://openreprolab-ige.osug.fr and authentication via GitHub/GitLab
- Preloaded Pangeo-type computing environment + customization options 
- Persistent workdir and git workflow  
- Option to switch to GRICAD (more ressources) possible during the course of the internship

##  List of people for Support

|   Name                    |      Building                  |
|---------------------------|------------------------------|
|       Jennie       |          OSUG/MCP              |
|       Ian           |          OSUG-B                |
|       Alban           |          OSUG-B                |
|       Jordi           |          MCP                |
|       Amaury          |         Glacio              |
| Mykael | OSUG/MCP/Glacio |

## Useful links
- JupyterHub Cloud Computing Platform: https://openreprolab-ige.osug.fr
- OpenReproLab 2025 GitHub Organization and all its repositories: https://github.com/IGE-OpenReproLab2025
