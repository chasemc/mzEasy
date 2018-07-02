#' @title convertRawDataCommands
#' @export
#' @description This function returns a list of cmd.exe calls to msconvert.exe. Note: doesn't make the calls, just the text to do so.
#' @rdname convertRawDataCommands
#' @param pathToRawData directory that contains raw LC-MS/MS data
#' @param whereFilesCreated directory that will contain the new mzXML files
#' @param msConvertFolderLocation directory that contains msconvert.exe
#' @return List of cmd.exe calls, each element is a single LC-MS/MS file to be converted

convertRawDataCommands <- function(pathToRawData, whereFilesCreated, msConvertFolderLocation){

# Get filepaths of raw data files
rawFiles <- list.files(pathToRawData, recursive = FALSE, full.names = TRUE)
# Get the raw data file names
fileNames <- basename(rawFiles)
# Create a list of cmd line calls to run MSConvert on the selected raw data files
lapply(seq_along(fileNames), function(x){
  paste0(shQuote(file.path(msConvertFolderLocation, "msconvert.exe")), " ",
         shQuote(rawFiles[[x]]),
         " --filter peakPicking true 1- --mzXML --32 -o ",
         shQuote(whereFilesCreated),
         " --outfile ",
         paste0(fileNames[[x]],".mzXML", " --ignoreUnknownInstrumentError")
  )
})

}
