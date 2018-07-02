# devtools::install_github("ficonsulting/RInno@2a980b9")


library("RInno")


mzEasyPath <- "C:/Users/CMC/Documents/GitHub/mzEASY"


setwd(file.path(mzEasyPath, "build/Create_Executable/inst/app"))



filesToInclude <- list.files("www", full.names = T, recursive = TRUE)
filesToInclude <- list.files("library", full.names = T, recursive = TRUE)
filesToInclude <- list.files("example_data", full.names = T, recursive = TRUE)

create_app(
  app_name    = "mzEASY",
  dir_out     = "wizard",
  files       = filesToInclude,
  include_R   = TRUE,   # Download R and install it with your app, if necessary
  R_version   = "3.5.0",  # Specified version to include of R
  privilege   = "none", # Admin only installation
  default_dir = "userdocs",
# app_icon   = "icon.ico",
# setup_icon = "install.ico",
  compression = "bzip",
  #info_after = "infoafter.txt",
  #info_before = "infobefore.txt",
  license_file = "License.txt",
  app_version = "0.0.1",
  app_repo_url = "https://github.com/chasemc/mzEASY")

compile_iss()



