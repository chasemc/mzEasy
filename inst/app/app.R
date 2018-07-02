#-----
# Load required packages
library(shiny)
library(mzR)
library(ggplot2)
library(gridExtra)
library(mzEasy)

#-----
# Get paths
appwd <- getwd()   # Get the path of the app
applibpath <- file.path(dirname(dirname(appwd)), "inst/app/library/packageLibrary") # Get the path for the "packageLibrary" folder

#-----
# Change library path to the "packageLibrary" folder
.libPaths(c("C:/Users/CMC/R/win-library/3.5"))
#applibpath
print(.libPaths())
#-----
# Find location of msconvert.exe
progFiles <- shell(cmd= "ECHO %ProgramFiles%\\ProteoWizard", translate=TRUE, intern=T)
pwizLocation <- findpwiz(userGivenPath = appwd,
                         proteoWizardLocation = progFiles)

#-----
# Setup environment to save plots into
plots <- new.env()

#-----
# Trigger from: https://github.com/daattali/advanced-shiny/tree/master/reactive-trigger
makeReactiveTrigger <- function() {
  rv <- reactiveValues(a = 0)
  list(
    depend = function() {
      rv$a
      invisible()
    },
    trigger = function() {
      rv$a <- isolate(rv$a + 1)
    }
  )
}

#-----
# Define UI
ui <- fluidPage(title = "mzEasy",
                h3("LC-MS/MS File Conversion and Quality Check"),
                # Sidebar with a slider input for number of bins
                sidebarLayout(
                  sidebarPanel(
                    p("Conversions powered by: ",
                      a(href = "http://proteowizard.sourceforge.net/",
                        target = "_blank", "ProteoWizard")),
                    p("Issues may be reported at the ",
                      a(href = "https://github.com/chasemc/mzEASY/issues",
                        target = "_blank", "mzEasy GitHub repository.")),
                    actionButton("rawFolderInput",
                                 label = "Click to select folder where raw files are"),
                    fluidRow(column(12,
                                    verbatimTextOutput("selectedFolderFileNames",
                                                       placeholder = TRUE))),
                    actionButton("outputDirectory",
                                 label = "Click to select where mzXML files should be created"),
                    fluidRow(column(12,
                                    verbatimTextOutput("selectedOutputDirectory",
                                                       placeholder = TRUE))),
                    radioButtons("parallel",
                                 "Choose One:",
                                 list("Not Parallel" =  1,
                                      "Parallel" = 2)),
                    p(strong("Note:"), "The progress bar will not work properly when \"parallel\" is selected. Wait for the files to appear under \"Converted Files\"."),
                    actionButton("convertFiles",
                                 label = "Click to Convert Files"),
                    br(),
                    br(),
                    uiOutput("mzXMLfiles"),
                    radioButtons("downloadType",
                                 choices = c(".eps", ".ps", ".tex", ".pdf", ".jpeg", ".tiff", ".png", ".bmp", ".svg", ".wmf"),
                                 inline = TRUE,
                                 label = "Image Type"),
                    downloadButton("downloadImage",
                                   label = "Download Image"),
                    h3("Warnings:"),
                    br(),
                    uiOutput("errors")
                  ),

                  # Show a plot of the generated distribution
                  mainPanel(
                    uiOutput("ms2Plots")
                  )
                )
)

#-----
# Define server logic
server <- function(input, output, session) {

#-----
# Popup that displays whether msconvert.exe was successfully found
  observeEvent(session,{
    showModal(modalDialog(
      title = "Somewhat important message",
      if(!file.exists(file.path(pwizLocation,"msconvert.exe"))){
        HTML(pwizLocation)
      }else{
        HTML("MSConvert successfully found: <br>", pwizLocation, "<br> <br> Click outside this box to continue.")
      },
      easyClose = TRUE,
      footer = NULL
    ))
  })



# Trigger from: https://github.com/daattali/advanced-shiny/tree/master/reactive-trigger
  myTrigger <- makeReactiveTrigger()

  #---------------------------------------------------------- Select directories
  # Selecting folder that contains raw data
  rawDataFolder <- reactive({
    if(is.null(input$rawFolderInput)){ }else if (input$rawFolderInput > 0){
      choose.dir(default = "", caption = "Select files")
    }
  })

  # Selecting folder that contains mzXML files (already-created or to-be-created)
  selectedDirectory <- reactive({
    if(is.null(input$outputDirectory)){ }else if (input$outputDirectory > 0){
      choose.dir()
    }
  })

  #---------------------------------------------------------- Display chosen directories

  # List files within the chosen raw-file directory
  rawData <- reactive ({
    if(is.null(rawDataFolder())){"No Folder Selected"}else{
      list.files(rawDataFolder(), recursive = FALSE)}
  })
  # Render text to display choices chosen
  output$selectedFolderFileNames <- renderText({
    if(is.null(rawDataFolder())){"No Folder Selected"}else{
      paste0(rawData(), "\n")} # Creates user feedback about which raw data folders were chosen.  Individual folders displayed on a new line "\n"
  })

  # Display chosen directory that (will) contain mzXML files
  output$selectedOutputDirectory <- renderText({
    if(is.null(selectedDirectory())){"No Folder Selected"}else{selectedDirectory()}})


  # Display radio selectors for selecting which mzXML file to display
  output$mzXMLfiles <- renderUI({
    myTrigger$depend()
    if(is.null(selectedDirectory())){ }else{
      mzXMLFilesPath <- gsub("\\\\", "/", list.files(selectedDirectory(), pattern=".mzXML", full.names = TRUE))
      if(length(mzXMLFilesPath) > 0){
        radioButtons("radio", choices = mzXMLFilesPath,label = "Converted Files:")
      }else{ p("")}
    }
  })

  #---------------------------------------------------------- File Conversion
  # Convert raw to mzXML

  observeEvent(input$convertFiles, {
    appwd <- getwd()   # Get the parent directory of the app

    zz <- convertRawDataCommands(pathToRawData = rawDataFolder(),
                                 whereFilesCreated = selectedDirectory(),
                                 msConvertFolderLocation = pwizLocation)
    lengthProgress <- length(zz) # For the progress bar segments
    withProgress(message = 'Conversion in progress',
                 detail = 'This may take a while...', value = 0, {
                   if(input$parallel == 2){
                     try(numCores <- parallel::detectCores()) # How many cores are on the system
                     numCores <- parallel::makeCluster(numCores - 1) #Setup cluster
                     parallel::parSapply(numCores, zz, function(x) system(command = as.character(x))) # Sapply through,
                     # zz is a list of one-file conversion command-line commands
                     parallel::stopCluster(numCores)
                   }else{
                     for(i in zz){
                       incProgress(1 / lengthProgress)
                       system(command = as.character(i))
                     }
                   }
                 })
    myTrigger$trigger()
  })

  #---------------------------------------------------------- Read mzXML

  readmzXML <- reactive({
    req(input$radio) # Don't run if input$radio doesn't exist
    mzR::openMSfile(file = input$radio)  # Open connection to mzXML file
  })

  #----------------------------------------------------------

  ticMS1 <- reactive({
    list(TIC = mzXMLHeader()$totIonCurrent[mzXMLHeader()$msLevel == 1]) # Get TIC data from the mzXML file
  })

  mzXMLHeader <- reactive({
    a <- mzR::header(readmzXML()) # Get mzR header data from selected mzXML file
    a$basePeakIntensity[which(a$basePeakIntensity == 0)] <- 1
    a
  })

  observeEvent(input$radio, {
    output$errors <- renderUI("")
    if(!any(mzXMLHeader()$msLevel == 1)){ # If no MS1 scans present display warning...
      output$errors <- renderUI(paste(bquote(NO ~ MS[1] ~ datafound))) # Create and display error
    }
    if(!any(mzXMLHeader()$msLevel == 2)){   # If no MS2 scans present display warning...
      output$errors <- renderUI(HTML(paste0("No MS", tags$sup(2)," data found."))) # Create and display error
    }
  })

  observeEvent(input$radio, {
    # Check spectra MS levels
    if(!any(mzXMLHeader()$msLevel == 2) & !any(mzXMLHeader()$msLevel == 1)){  # If neither MS2 or++ MS1 files are present
    }else if(!any(mzXMLHeader()$msLevel == 2)){ # If no MS2 scans exist...
      output$ms2Plots <- renderUI({
        column(12,
               plotOutput("distPlot0")
        )})
    }else if(!any(mzXMLHeader()$msLevel == 1)){ # If no MS1 scans exist...
      output$ms2Plots <- renderUI({
        column(12,
               plotOutput("plot1"),
               plotOutput("plot2"),
               plotOutput("plot3")
        )})
    }else{
      output$ms2Plots <- renderUI({  # If MS1 and MS2 exist...
        column(12,
               plotOutput("distPlot0"),
               plotOutput("plot1"),
               plotOutput("plot2"),
               plotOutput("plot3"),
               plotOutput("plot4")
        )})
    }
  })

  #------------------------- Plots

  output$distPlot0 <-  renderPlot({
    # relInt is for scaling the y axis of the plot
    relInt <- max(mzXMLHeader()[mzXMLHeader()$msLevel == 1, ]$totIonCurrent) / max(mzXMLHeader()[mzXMLHeader()$msLevel == 1, ]$basePeakIntensity)
    plots$p0 <- ggplot(mzXMLHeader()[mzXMLHeader()$msLevel == 1, ]) +
      geom_line(aes(x = retentionTime / 60, # convert to minutes
                    y = totIonCurrent,
                    colour = "TIC")) +
      geom_line(aes(x = retentionTime / 60, # convert to minutes
                    y = -basePeakIntensity * (max(totIonCurrent) / max(basePeakIntensity)),
                    colour = "BPC"))+
      scale_y_continuous(name="TIC (As Positive Spectrum)",
                         sec.axis = sec_axis(~.*-(relInt), name = "BPC (As Negative Spectrum)"))+
      scale_colour_manual(values = c("#1b9e77", "#7570b3"))+
      theme(legend.position = c(0.8, 0.9))+
      labs(y = "TIC",
           x = "Retention Time (min)",
           colour = "")+
      guides(colour = guide_legend(override.aes = list(size = rel(3)), reverse = T))
    plots$p0
  })

  output$plot1 <-  renderPlot({
    plots$p1 <-  ggplot(mzXMLHeader()[mzXMLHeader()$msLevel == 2, ]) +
      geom_point(aes(x = retentionTime / 60, # convert to minutes
                     y = precursorMZ,
                     alpha = basePeakIntensity)) +
      scale_alpha_continuous(range = c(0.1, 1),
                             trans = "log10") +
      xlab("Retention Time (min)") +
      ylab(bquote(Precursor ~ italic(m/z))) +
      labs(alpha = bquote(MS^2 ~ Base ~ Peak ~ Intensity))
    plots$p1
  })

  output$plot2 <-  renderPlot({
    plots$p2 <- ggplot(mzXMLHeader()[mzXMLHeader()$msLevel == 2,]) +
      geom_point(aes(x = retentionTime / 60, # convert to minutes
                     y = peaksCount, alpha = basePeakIntensity,
                     size = precursorMZ)) +
      scale_alpha(range = c(0.1, 1),
                  trans = "log10")+
      scale_size_continuous(range = c(.5, 3.5)) +
      xlab("Retention Time (min)") +
      ylab(bquote(Number ~ of ~ Peaks ~ "in" ~ MS^2 ~ Scan)) +
      labs(alpha = bquote(MS^2 ~ Base ~ Peak ~ Intensity),
           size = bquote(Precursor ~italic(m/z)))
    plots$p2
  })

  output$plot3 <-  renderPlot({
    plots$p3 <- ggplot(mzXMLHeader()[mzXMLHeader()$msLevel == 2, ]) +
      geom_point(aes(x = precursorMZ,
                     y = peaksCount,
                     alpha = basePeakIntensity)) +
      scale_alpha(range = c(0.1, 1),
                  trans = "log10")+
      xlab(bquote(Precursor ~ italic(m/z))) +
      ylab(bquote(Number ~ of ~ Peaks ~ "in" ~ MS^2 ~ Scan)) +
      labs(alpha = bquote(MS^2 ~ Base ~ Peak ~ Intensity))
    plots$p3
  })

  output$downloadImage <- downloadHandler(
    filename = function(){paste0("Output", input$downloadType)},
    content = function(file1){
      # This section creates the layout for the plots to be downloaded
      q0 <- plots$p0 + labs(tag = "A")
      q1 <- plots$p1 + labs(tag = "B")
      q2 <- plots$p2 + labs(tag = "C")
      q3 <- plots$p3 + labs(tag = "D")
      l1 <- gridExtra::grid.arrange(q0)
      l2 <- gridExtra::grid.arrange(q1, q2, nrow = 1)
      l3 <- gridExtra::grid.arrange(q3, nrow = 1)
      ww <- gridExtra::grid.arrange(l1, l2, l3, nrow = 3, heights = c(.9, .9, .9))
      ggplot2::ggsave(file1, plot = ww, width = 38, height = 28, units = "cm")
      if (file.exists(paste0(file1, input$downloadType)))
        file.rename(paste0(file1, input$downloadType), file1)
    }
  )

  #  The following code is necessary to stop the R backend when the user closes the browser window
  session$onSessionEnded(function() {
    stopApp()
    q("no")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
