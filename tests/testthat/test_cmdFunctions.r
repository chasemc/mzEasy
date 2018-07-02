context("convertRawDataCommands")


# ------------------
# Check building the cmd call

extData <- system.file("extdata", package="mzEasy")

commands <- convertRawDataCommands(pathToRawData = file.path(extData, "chromatogram"),
                                   whereFilesCreated = file.path(extData, "test"),
                                   msConvertFolderLocation = findpwiz(userGivenPath = "", proteoWizardLocation = file.path(extData,"fakePwizPath", "fakeMSConvert")))

commands <- strsplit(commands[[1]], "\\\"")[[1]]

test_that("MSConvert commands are in correct order", {
  expect_equal(commands[[1]], "")
  expect_equal(commands[[2]],  file.path(extData,"fakePwizPath", "fakeMSConvert", "msconvert.exe"))
  expect_equal(commands[[3]], " ")
  expect_equal(commands[[4]], file.path(extData, "chromatogram", "Example_Chromatogram.mzXML"))
  expect_equal(commands[[5]], " --filter peakPicking true 1- --mzXML --32 -o " )
  expect_equal(commands[[6]], file.path(extData, "test"))
  expect_equal(commands[[7]], " --outfile Example_Chromatogram.mzXML.mzXML --ignoreUnknownInstrumentError")
  expect_equal(length(commands), 7)
  })


# ------------------
# Check the actual conversion (requires pwiz to actually be installed on computer)

extData <- system.file("extdata", package="mzEasy")

progFiles <- shell(cmd= "ECHO %ProgramFiles%\\ProteoWizard", translate=TRUE, intern=T)
pwizLocation <- mzEasy::findpwiz(userGivenPath = "",
                         proteoWizardLocation = progFiles)



commands <- convertRawDataCommands(pathToRawData = file.path(extData, "chromatogram"),
                                   whereFilesCreated = file.path(extData, "test"),
                                   msConvertFolderLocation = pwizLocation)


system(command = as.character(commands[[1]]))

testExist <- file.exists(file.path(extData, "test", "Example_Chromatogram.mzXML.mzXML" ))


test_that("MSConvert converted file", {
  expect_equal(testExist, TRUE)
})



