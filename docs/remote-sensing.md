# Remote Sensing
This page summarizes the remote sensing activities conducted within the IGE (Institute for Environmental Geosciences) and in connection with the ige-calcul platform. These activities primarily focus on studying glacier dynamics in the polar ice sheets of Antarctica and Greenland, as well as in glaciated mountain ranges around the world (e.g., Himalayas, Alps, etc.).

One of the main activities involves quantifying glacier flow velocities using image correlation techniques, based on data from ESA satellites (Sentinel-1/2), NASA satellites (Landsat-1 to 9), and high-resolution sensors (aerial imagery, Pléiades, SPOT). Within the framework of projects in close collaboration with ESA, CNES, and LabEx, IGE produced the first high-resolution map of glacier flow worldwide. These data are made available through the CES Glacier via the CNES Theia platform at [https://www.theia-land.fr/ceslist/ces-glaciers/](https://www.theia-land.fr/ceslist/ces-glaciers/) and at [https://entrepot.recherche.data.gouv.fr/dataverse/glacier-velocity](https://entrepot.recherche.data.gouv.fr/dataverse/glacier-velocity). Members of IGE have developed inversion algorithms to analyze these highly heterogeneous temporal and spatial datasets, stored at https://github.com/ticoi/ticoi.

Another aspect of remote sensing activities focuses on measuring changes in glacier and polar ice sheet thickness using altimetry data and photogrammetry techniques. Python packages for analyzing geospatial data and digital elevation models are actively developed at IGE and are available at [https://xdem.readthedocs.io/en/stable/](https://xdem.readthedocs.io/en/stable/) and [https://geoutils.readthedocs.io/en/stable/](https://geoutils.readthedocs.io/en/stable/).

Finally, the remote sensing team develops algorithms for image segmentation and classification to monitor changes in the physical characteristics of glaciated objects. Features of interest include crevasses and fractures forming on glacier surfaces and beneath ice shelves, rift zones, as well as glacier boundaries in mountainous regions.

##  People involved

|   Name       |  Position         |  Team            |  Building          | What                                                 |
| -------------|:-----------------:|:----------------:|:------------------:|:----------------------------------------------------:|
| F. Brun      | Researcher        | C2H              |    Glacio          | Pléiades/SPOT DEM processing, photogrammetry |
| A. Dehecq    | Researcher        | Cryodyn          |    Glacio          | Elevation change, photogrammetry, historical spy imagery, dev. of xdem and geoutils |
| R. Millan    | Researcher        | Cryodyn          |    MCP             | Ice velocity processing, basal melting rates, crevasses mapping |
| A. Rabatel   | Researcher        | Cryodyn          |    Glacio          | Ice velocity processing of moutain glaciers, Snow line altitude delineation |
| K. Shahateet | Post-doc          | Cryodyn          |    MCP             | Ice shelf damage using deep learning, SAR |
| L. Charrier  | Post-doc          | Cryodyn          |    Glacio          | Inversion of time series of surface flow velocities |
| L. Gimenes   | Engineer          | Cryodyn          |    OSUG-B          | Ice shelf basal melting rates |
| N. Lioret    | Engineer          | Cryodyn          |    Glacio          | Ice velocity processing with Pléiades imagery, and time serie inversion |
 
