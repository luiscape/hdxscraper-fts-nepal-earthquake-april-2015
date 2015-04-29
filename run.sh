#!/bin/bash

# Running R from a compiled version.
~/R/bin/Rscript ~/tool/code/scraper.R

source venv/bin/activate
python code/create_datastore.py