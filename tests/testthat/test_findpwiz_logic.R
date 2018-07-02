context("findpwiz_logic")



findpwiz
  # ------------------
  # Check the logic behind finding pwiz (can't really do the program files part great)

  extData <- system.file("extdata", package="mzEasy")

  a <- findpwiz(userGivenPath = "",
                proteoWizardLocation = file.path(extData,"fakePwizPath", "fakeMSConvert"))
  b <- findpwiz(userGivenPath = "",
                proteoWizardLocation = dirname(a))
  d <- findpwiz(userGivenPath = file.path(extData,"fakePwizPath"),
                proteoWizardLocation = file.path(extData, "chromatogram"))

  ab2 <- file.path(extData,"fakePwizPath", "fakeMSConvert")
  d2 <- "Unable to find msconvert.exe in \"Program Files\" and no location provided in: <br> mzEasy\\www\\Specify_ProteoWizard_Location.txt"

  test_that("findpwiz() logic seems intact", {
    expect_equal(a, ab2)
    expect_equal(b, ab2)
    expect_equal(d, d2)
  })






