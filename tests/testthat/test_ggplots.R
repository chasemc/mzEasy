# context("ggplots")
#
#
# extData <- system.file("extdata", package="mzEasy")
#
#
#
# test_that("findpwiz() logic seems intact", {
#   expect_equal(a, ab2)
#   expect_equal(b, ab2)
#   expect_equal(d, d2)
# }
#
#
#
#
#
#
# output$distPlot0 <-  renderPlot({
#   # relInt is for scaling the y axis of the plot
#   relInt <- max(mzXMLHeader()[mzXMLHeader()$msLevel == 1, ]$totIonCurrent) / max(mzXMLHeader()[mzXMLHeader()$msLevel == 1, ]$basePeakIntensity)
#   plots$p0 <- ggplot(mzXMLHeader()[mzXMLHeader()$msLevel == 1, ]) +
#     geom_line(aes(x = retentionTime / 60, # convert to minutes
#                   y = totIonCurrent,
#                   colour = "TIC")) +
#     geom_line(aes(x = retentionTime / 60, # convert to minutes
#                   y = -basePeakIntensity * (max(totIonCurrent) / max(basePeakIntensity)),
#                   colour = "BPC"))+
#     scale_y_continuous(name="TIC (As Positive Spectrum)",
#                        sec.axis = sec_axis(~.*-(relInt), name = "BPC (As Negative Spectrum)"))+
#     scale_colour_manual(values = c("#1b9e77", "#7570b3"))+
#     theme(legend.position = c(0.8, 0.9))+
#     labs(y = "TIC",
#          x = "Retention Time (min)",
#          colour = "")+
#     guides(colour = guide_legend(override.aes = list(size = rel(3)), reverse = T))
#   plots$p0
# })
#
# output$plot1 <-  renderPlot({
#   plots$p1 <-  ggplot(mzXMLHeader()[mzXMLHeader()$msLevel == 2, ]) +
#     geom_point(aes(x = retentionTime / 60, # convert to minutes
#                    y = precursorMZ,
#                    alpha = basePeakIntensity)) +
#     scale_alpha_continuous(range = c(0.1, 1),
#                            trans = "log10") +
#     xlab("Retention Time (min)") +
#     ylab(bquote(Precursor ~ italic(m/z))) +
#     labs(alpha = bquote(MS^2 ~ Base ~ Peak ~ Intensity))
#   plots$p1
# })
#
# output$plot2 <-  renderPlot({
#   plots$p2 <- ggplot(mzXMLHeader()[mzXMLHeader()$msLevel == 2,]) +
#     geom_point(aes(x = retentionTime / 60, # convert to minutes
#                    y = peaksCount, alpha = basePeakIntensity,
#                    size = precursorMZ)) +
#     scale_alpha(range = c(0.1, 1),
#                 trans = "log10")+
#     scale_size_continuous(range = c(.5, 3.5)) +
#     xlab("Retention Time (min)") +
#     ylab(bquote(Number ~ of ~ Peaks ~ "in" ~ MS^2 ~ Scan)) +
#     labs(alpha = bquote(MS^2 ~ Base ~ Peak ~ Intensity),
#          size = bquote(Precursor ~italic(m/z)))
#   plots$p2
# })
#
# output$plot3 <-  renderPlot({
#   plots$p3 <- ggplot(mzXMLHeader()[mzXMLHeader()$msLevel == 2, ]) +
#     geom_point(aes(x = precursorMZ,
#                    y = peaksCount,
#                    alpha = basePeakIntensity)) +
#     scale_alpha(range = c(0.1, 1),
#                 trans = "log10")+
#     xlab(bquote(Precursor ~ italic(m/z))) +
#     ylab(bquote(Number ~ of ~ Peaks ~ "in" ~ MS^2 ~ Scan)) +
#     labs(alpha = bquote(MS^2 ~ Base ~ Peak ~ Intensity))
#   plots$p3
# })
#
# output$downloadImage <- downloadHandler(
#   filename = function(){paste0("Output", input$downloadType)},
#   content = function(file1){
#     # This section creates the layout for the plots to be downloaded
#     q0 <- plots$p0 + labs(tag = "A")
#     q1 <- plots$p1 + labs(tag = "B")
#     q2 <- plots$p2 + labs(tag = "C")
#     q3 <- plots$p3 + labs(tag = "D")
#     l1 <- gridExtra::grid.arrange(q0)
#     l2 <- gridExtra::grid.arrange(q1, q2, nrow = 1)
#     l3 <- gridExtra::grid.arrange(q3, nrow = 1)
#     ww <- gridExtra::grid.arrange(l1, l2, l3, nrow = 3, heights = c(.9, .9, .9))
#     ggplot2::ggsave(file1, plot = ww, width = 38, height = 28, units = "cm")
#     if (file.exists(paste0(file1, input$downloadType)))
#       file.rename(paste0(file1, input$downloadType), file1)
#   }
