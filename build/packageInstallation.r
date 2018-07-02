.libPaths("C:/Users/CMC/Documents/GitHub/mzEASYInstaller/inst/app/library/packageLibrary")
libLoc <- "C:/Users/CMC/Documents/GitHub/mzEASYInstaller/inst/app/library/packageLibrary"
mranSnap <- "https://cran.microsoft.com/snapshot/2018-06-30"

install.packages(c("devtools"),
                 repo = mranSnap,
                 lib = libLoc,
                 dependencies = c("Depends",
                                  "Imports",
                                  "LinkingTo"))

devtools::install_github("tidyverse/ggplot2@4caac5f",
                         lib = "C:/Users/CMC/Documents/GitHub/mzEASYInstaller/inst/app/library/packageLibrary",
                         dependencies = c("Depends",
                                          "Imports",
                                          "LinkingTo"))


install.packages(c("shiny", "gridExtra", "svglite", "jsonlite"),
                 repo = mranSnap,
                 lib = libLoc,
                 dependencies = c("Depends",
                                  "Imports",
                                  "LinkingTo"))

## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite("mzR")

