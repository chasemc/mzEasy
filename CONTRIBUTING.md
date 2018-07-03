# Contributing

First of all, thanks for looking into contributing!


### What do I need to know to help?

mzEasy is primarily written in R, but does use a minimal amount of system calls for sending commands to msconvert.exe

If you would like to contribute but aren't comfortable with R, that's ok! You can always submit a pull request for fixing/updating or making the documentation more clear. That misght be issues you have found, but you can also check unresolved [Documentation Issues](https://github.com/chasemc/mzEasy/labels/Documentation).

If you are interested in making a code contribution I would suggest that you be comfortable with 
  - At the minimal: R

mzEasy also leverages the use of these R packages

  - mzR: For parsing mzXML files
  - ggplot2 (GitHub version: 4caac5f): For the creation of the plots
  - gridExtra: For plot arrangement when saving
  - RInno: For creating the executable

### How do I make a contribution?

- Find an issue that you are interested in addressing or a feature that you would like to add.
- Fork the mzEasy repository to your local GitHub. This means that you will have a copy of the repository under your-GitHub-username/mzEasy
- Clone the repository to your local machine using git clone https://github.com/github-username/mzEasy.git
- Create a new branch for your fix using git checkout -b branch-name-here
- Make the appropriate changes for the issue you are trying to address or the feature that you want to add.
- Use git add insert-paths-of-changed-files-here to add the file contents of the changed files to the "snapshot" git uses to manage the state of the project, also known as the index.
- Use git commit -m "Insert a short message of the changes made here" to store the contents of the index with a descriptive message.
- Push the changes to the remote repository using git push origin branch-name-here.
- Submit a pull request to the upstream repository.
- Title the pull request with a short description of the changes made and the issue or bug number associated with your change. For example, you can title an issue like so "Added more log outputting to resolve #4352".
- In the description of the pull request, explain the changes that you made, any issues you think exist with the pull request you made, and any questions you have for the maintainer. It's OK if your pull request is not perfect (no pull request is), the reviewer will be able to help you fix any problems and improve it!
Wait for the pull request to be reviewed by a maintainer.
- Make changes to the pull request if the reviewing maintainer recommends them.
- Celebrate your success after your pull request is merged!

### Where can I go for help?
If you need help, feel free to open an issue [here](https://github.com/chasemc/mzEasy/issues) or email directly at gmail: chasec288 

### What does the Code of Conduct mean for me?
Our Code of Conduct means that you are responsible for treating everyone on the project with respect and courtesy regardless of their identity. If you are the victim of any inappropriate behavior or comments as described in our Code of Conduct, we are here for you and will do the best to ensure that the abuser is reprimanded appropriately, per our code. Please refer to the [Code of Conduct](https://github.com/chasemc/mzEasy/blob/master/CODE_OF_CONDUCT.md) for more information.


Note: This contributions file was modified from [this template](https://opensource.com/life/16/3/contributor-guidelines-template-and-tips), written by Safia Abdalla 
