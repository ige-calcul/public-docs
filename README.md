# IGE Scientific Computation Ressources

This repo contains the sources of [IGE Computing jupyter book](https://ige-calcul.github.io/public-docs/docs/index.html)

## Organization

In sub-repo docs, you will find a collection of markdown files and jupyter notebooks that are organized in chapters and sections described in the _toc.yml file

## Contribute

To contribute to this jupyter book a procedure inspired by collaborative software development workflows is described below.

To make it easier, we chose to simplify this workflow, especially for the beginning of writing the documentation which involves the creation of separate pages.

You are now able to modify directly one or multiple files in the main branch, the jupyter book will then be automatically modified, look for the green flag in the Actions tab.

To avoid conflicts arising from two people modifying the same file at the same time, we suggest that you warn the IGE-calcul team that you are about to contribute to the book by sending a mail (it will also show to the other member that some people are working on the documentation !)

A descriptive comment on what you did and why is still strongly recommended when commiting a change.

Follow the original procedure described just below if you want a review of your work by someone else.

### Stricter procedure to contribute 

To contribute to the jupyter book or propose corrections, you should do the following steps :
  - set up an issue describing the contribution/correction and assign it to yourself or someone else
 
If you are the one making the modifications, two solutions :
  - either you do it online : you create a branch, modify the files in it
  - either you do it locally (for bigger modifications or reorganization) :
     -  clone the repo locally ```git@github.com:ige-calcul/public-docs.git```
     -  make sure you create your branch from the latest main branch: \
       `git checkout main` \
       `git pull`
     -  create a new branch from main : ```git checkout -b issue_test main```
     -  do your modifications
     -  push your modifications online : ```git push --set-upstream origin issue_test```

Then, in both cases, initiate a pull request from your branch and assign a reviewer

The convention is that the branch name should be issueXX_keyword to link it to the issue 

## Build 

The local build of the jupyter book is possible and recommanded to check the output of your modification, in your local repo :
   - install the libraries : ```pip install -r requirements.txt``` (to be done just once)
   - build the book : ```jupyter-book build .```
   - open _build/html/index.html in a browser
