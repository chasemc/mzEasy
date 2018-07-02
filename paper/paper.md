---
title: 'mzEasy'
tags:
  - Mass Spectrometry
  - LC-MS/MS
  - Liquid Chromatography
  - File Conversion
  - Quality Check
authors:
 - name: Chase M Clark
   orcid: 0000-0001-6439-9397
   affiliation: "1"
affiliations:
 - name: University of Illinois at Chicago
   index: 1
date: 02 July 2018
bibliography: paper.bib
---

### Summary

An increase in access to liquid chromatography-mass spectrometry (LC-MS/MS) and advanced algorithms (often cloud-based) has led to a surge in users whose time is often better spent with advanced analyses than converting and evaluating, holistically, their raw data.  However, conversion of raw spectra to open access formats and ensuring data is of good quality are necessary steps for proper use in later analyses. Unfortunately, users unfamiliar with conversion software often miss needed settings or are unsure how to proceeed, adding a barrier of entry to the use of more advanced analysis pipelines.

mzEasy provides a simple interface with MSConvert [@Chambers2012] to convert raw MS files to the "mzXML" open access format [@Pedrioli2004] and auto-generate quality control graphs (with an option to save graphs as a pre-assembled manuscript image). Importantly, mzEasy doesn't require (or have options for) adjusting/selecting any settings other than what image format to save plots as.  

mzEasy is auto-configured to convert vendor files to mzXML with settings required for analyses such as GNPS [@Wang2016] and is meant for anyone uneasy with using MSConvertGUI.  It is also designed for users that want access to parallelized MSConvert and/or a simple way to generate quality control plots that are pre-arranged for easy publication/sharing.

**Features:**

 - Available for download as a Windows executable for easy installation. 
 - Interfaces with MSConvert for conversion of raw mass spectrometry data.
 - Provides the option to run conversion in parallel (# of cores minus one).
 - Creates graphs to assess, broadly, the quality of an LC-MS/MS file.
 - Allows export of graphs as pre-assembled figure, in multiple image formats.
 - Automatic updates for future improvements.

**Availability:**

 - Download from: [chasemc.github.io/mzEasy](https://chasemc.github.io/mzEasy/)
 - Source code available at: [github.com/chasemc/mzEasy](https://github.com/chasemc/mzEasy) 

**Software Requirements:**

 - Windows operating system
 - ProteoWizard ([proteowizard.sourceforge.net](http://proteowizard.sourceforge.net))


mzEasy was written in R [@baseR2018] and utilizes Shiny [@shiny2018], RInno [@RInno2018], mzR [@Chambers2012], and ggplot2 [@gg2009].

# References

