Note: This has largely been replaced with: https://github.com/chasemc/mzPlotter
### Summary

An increase in access to liquid chromatography-mass spectrometry (LC-MS/MS) and advanced algorithms (often cloud-based) has led to a surge in users whose time is often better spent with advanced analyses than converting and evaluating their raw data.  However, conversion of raw spectra to open access formats and ensuring data is of good quality are necessary steps for proper use in later analyses. Unfortunately, users unfamiliar with conversion software often miss needed settings or are unsure how to proceeed, adding a barrier of entry to the use of more advanced analysis pipelines.

mzEasy provides a simple interface with MSConvert [@Chambers2012] to convert raw MS files to the "mzXML" open access format [@Pedrioli2004]. As it utilizes Proteowizard's MSConvert, it is capable of converting raw data from such vendors as AB SCIEX, Agilent, Bruker, and ThermoFisher, and some limited Waters' data. The auto-generated overview plots allow for easy inspection of the converted files and feedback of whether the conversion was succesful, including the option to save graphs as a pre-assembled manuscript image. Importantly, mzEasy doesn't require (or have options for) adjusting/selecting any settings other than to select which image format to save plots. For more advanced processing options another software such as MZmine 2 [@Pluskal2010] should be used.

mzEasy is auto-configured to convert vendor files to mzXML with the basic settings required for analyses such as Global Natural Products Social molecular networking (GNPS) [@Wang2016] and is meant for anyone uneasy with using MSConvertGUI. 



It is also designed for users that want access to parallelized MSConvert and/or a simple way to generate quality control plots that are pre-arranged for easy publication/sharing.

**Features:**

 - Available for download as a Windows executable for easy installation. 
 - Interfaces with MSConvert for conversion of raw mass spectrometry data.
 - Provides the option to run conversion in parallel (# of cores minus one).
 - Creates graphs to assess, broadly, the quality of an LC-MS/MS file. Including:
     - Total Ion Current (TIC) and Base Peak Current (BIC)
     - Precursor *m/z* vs. retention time
     - Number of MS^2^ peaks per scan vs. retention time and precursor mass
     - Number of MS^2^ peaks per scan vs. precursor *m/z*
 - Allows export of graphs as a pre-assembled figure, in multiple image formats.
 - Automatic updates for future improvements.

**Availability:**

 - Download Windows installer: [chasemc.github.io/mzEasy](https://chasemc.github.io/mzEasy/)
 - Source code: [github.com/chasemc/mzEasy](https://github.com/chasemc/mzEasy) 

**Software Requirements:**

 - Windows operating system
 - ProteoWizard ([proteowizard.sourceforge.net](http://proteowizard.sourceforge.net))


mzEasy was written in R [@baseR2018] and utilizes Shiny [@shiny2018], RInno [@RInno2018], mzR [@Chambers2012], and ggplot2 [@gg2009].


![A screenshot of the mzEasy user interface](https://github.com/chasemc/mzEasy/raw/master/paper/Capture.PNG)


![Example of an exported, auto-assembled figure](https://github.com/chasemc/mzEasy/raw/master/paper/Output.png)

# References







## Setup:
The setup below should be fairly painless even though it looks long. The length is my trying to be more thorough in instruction and include details for those that might have less experience working with Windows.


|                              |                              |
| ---------------------------- | ---------------------------- |
| After downloading mzEasy, double-click the installer. Accept the mzEasy license agreement | <img src= "www/tutorial/mzEasy/1.PNG"  width=500 />  |
|Accept RInno license agreement (the software that created the .exe installer) |   <img src= "www/tutorial/mzEasy/2.PNG"  width=500 /> |
| Click "Next" |  <img src= "www/tutorial/mzEasy/3.PNG"  width=500 /> |
| Remember where you install mzEasy, you may need that information later (Defaults to "Documents"). Click "Next" | <img src= "www/tutorial/mzEasy/4.PNG"  width=500 /> |
| Click "Next"   | <img src= "www/tutorial/mzEasy/5.PNG"  width=500 /> |
| Click "Next"   | <img src= "www/tutorial/mzEasy/6.PNG"  width=500 /> |
| Click "Finish" | <img src= "www/tutorial/mzEasy/7.PNG"  width=500 /> |


___
## Installing Proteowizard
#### If you want to use mzEasy to convert files, you will need to install ProteoWizard.

If you have already installed ProteoWizard, mzEasy will try to find it for you and you likely won't have to do anything else. If mzEasy is unable to find it, try adding its location to "~mzEasy/Specify_ProteoWizard_Location.txt", as shown later in the this document.


- You can download the ProteoWizard Installer from here:  [http://proteowizard.sourceforge.net/download.html](http://proteowizard.sourceforge.net/download.html)


- Note: If you experience that mzEasy/MSConvert can't convert files, you may need to install: [Microsoft .NET Framework 4.0](https://www.microsoft.com/en-us/download/details.aspx?id=17851)


|                              |                              |
| ---------------------------- | ---------------------------- |
| Double-click the downloaded ".msi" file to begin installion. (Or right-click, then left-click "Install") |  <img src= "www/tutorial/pwiz/0.PNG"  width=500 /> |
| Click "Run"                  | <img src= "www/tutorial/pwiz/1.PNG"  width=500 /> |
| Click "Next" | <img src= "www/tutorial/pwiz/2.PNG"  width=500 /> |
| You will then be shown this screen: | <img src= "www/tutorial/pwiz/5.PNG"  width=500 /> |

<br> <br>
Copy the installation location and paste it somewhere in case mzEasy cannot find ProteoWizard the first time it's run.
<br> <br>



|                              |                              |
| ---------------------------- | ---------------------------- |
| Click "Next". | <img src= "www/tutorial/pwiz/5.PNG"  width=500 /> |
| Click "Next" | <img src= "www/tutorial/pwiz/6.PNG"  width=500 /> |
| Click "Install" | <img src= "www/tutorial/pwiz/7.PNG"  width=500 /> |

<br> <br>

#### If mzEasy can't find MSConvert:

|                              |                              |
| ---------------------------- | ---------------------------- |
| Go to the mzEasy folder and inside you will see a file "Specify_ProteoWizard_Location.txt".  | <img src= "www/tutorial/pwiz/10.PNG"  width=500 /> |
| Open the file   | <img src= "www/tutorial/pwiz/4.PNG"  width=500 /> |
| Copy the location ProteWizard was installed to (left side of image). Paste this into "Specify_ProteoWizard_Location.txt" document (right side of image). Save "Specify_ProteoWizard_Location.txt" and close it.| <img src= "www/tutorial/pwiz/12.PNG"  width=500 /> |

Try running mzEasy again. If the problem presists, you can file an issue here: [github.com/chasemc/mzEASY/issues] (https://github.com/chasemc/mzEASY/issues)


### Using mzEasy

Instructions for how to use mzEasy are displayed within the app:

<img src= "www/tutorial/mzEasy_screenshot.PNG"  width=900 />



