context("findpwiz_FindMSConvert")

# ------------------
# Check that findpwiz() is able to find msconvert
progFiles <- shell(cmd = "ECHO %ProgramFiles%\\ProteoWizard", translate=TRUE, intern=T)

a <- findpwiz(userGivenPath = "", proteoWizardLocation = progFiles)
b <- file.exists(a)

test_that("findpwiz() was able to find msconvert.exe", {
  expect_equal(b, TRUE)
})






