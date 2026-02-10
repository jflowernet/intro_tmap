# Introduction to `tmap`

This workshop will provide you with an introduction to making maps in R using the R package `tmap`. `tmap` is a relatively simple, but powerful, map making package.

## Prerequisites 

Apart from `tmap`, we will use the `terra` package for loading and manipulating spatial data, and the `rnaturalearth` package to get some country polygons. All packages can be loaded using the following code: `r install.packages(c("terra", "tmap", "rnaturalearth"))`

You will also need to have the data within this repository. You can do one of the following depending on how comfortable you are with Github:

- [Fork this repository](https://github.com/jflowernet/intro_tmap/fork). This will create your own copy of this repository which has all the data and code. More details on how to fork [here](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo)
- Download the data to somewhere on your computer that you will be able to access during the workshop. The data are in a zip file [here](https://github.com/jflowernet/intro_tmap/raw/main/data/data.zip). Once you have downloaded the data, unzip it, and make sure you know the path to the folder with all the data, e.g. "Documents/workshop_data/", so you can load the data during the workshop.

The workshop website link is on the right hand side of this page and can also be accessed [here](https://jflowernet.github.io/intro_tmap/)
