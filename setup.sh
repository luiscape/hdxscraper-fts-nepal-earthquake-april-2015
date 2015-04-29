#!/bin/bash

# Simple script to downlaod and
# set-up the SW folder with the necessary
# scripts.

# Compiling R.3.1.3
cd ~
wget 'http://cran.r-project.org/src/base/R-3/R-3.2.0.tar.gz'
tar -xvf R-3.2.0.tar.gz
mv R-3.2.0 R
cd R
./configure
make

# Creating Python's virtual env and dependencies
cd ~
virtualenv venv
source venv/bin/activate
pip install -r tool/requirements.txt

# Cleaning-up
rm R-3.2.0.tar.gz