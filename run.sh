#!/bin/bash

# Config
HDX_API="XXX"
FILE_PATH="tool/data/temp.csv"

# Running R from a compiled version.
~/R/bin/Rscript ~/tool/code/scraper.R

source venv/bin/activate
python tool/code/create_datastore.py $HDX_API $FILE_PATH