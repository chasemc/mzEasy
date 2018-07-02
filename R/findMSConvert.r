#' @title findpwiz
#' @export
#' @rdname findpwiz
#' @param userGivenPath directory that contains "Specify_ProteoWizard_Location.txt"
#' @param proteoWizardLocation directory that contains msconvert.exe
#' @return filepath of the folder containing msconvert.exe

findpwiz <- function(userGivenPath, proteoWizardLocation){

msconvertLocation <- list.files(proteoWizardLocation, recursive = TRUE, pattern = "msconvert.exe", full.names = TRUE)

if(length(msconvertLocation) >= 1){ # If length is 1 or greater then msconvert.exe was found (or multiple installations), return one
  msconvertLocation <- dirname(msconvertLocation[[1]])
}
# Check if msconvert was found. If not, look for path provided by user.
if(length(msconvertLocation) == 0){
  msconvertLocation <- readLines(file.path(userGivenPath,"Specify_ProteoWizard_Location.txt"))
  if (length(msconvertLocation) == 0){  # Empty file check
    msconvertLocation <- "Unable to find msconvert.exe in \"Program Files\" and no location provided in: <br> mzEasy\\www\\Specify_ProteoWizard_Location.txt"
  }else{
    # Ensure consistent "/" "\"
    msconvertLocation <- gsub("\\\\\\\\", "\\\\", msconvertLocation)
    msconvertLocation <- gsub("/", "\\\\", msconvertLocation)
    if(dir.exists(msconvertLocation)){
      msconvertLocation <- list.files(msconvertLocation, recursive = TRUE, pattern = "msconvert.exe", full.names = TRUE)
      if(length(msconvertLocation) >= 1){
        msconvertLocation <- dirname(msconvertLocation[[1]])
      }else{
        msconvertLocation <- "Unable to find msconvert.exe in \"Program Files\" and did not find msconvert.exe within location provided in: <br> mzEasy\\www\\Specify_ProteoWizard_Location.txt"
      }
    }else{
      msconvertLocation <- "Unable to find msconvert.exe in \"Program Files\" and did not find msconvert.exe within location provided in: <br> mzEasy\\www\\Specify_ProteoWizard_Location.txt"
    }
  }
}

return(msconvertLocation)

}
