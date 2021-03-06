#!/bin/bash

# Rebuild and deploy CodeIgniter4 user guide

UPSTREAM=https://github.com/bcit-ci/CodeIgniter4.git

# Prepare the nested repo clone folder
cd user_guide_src
rm -rf build/*
mkdir build/html

# Get ready for git
cd build/html
git init
git remote add origin $UPSTREAM
git fetch origin gh-pages
git checkout gh-pages
git reset --hard origin/gh-pages
rm -r *

# Make the new user guide
cd ../..
make html

# All done?
if [ $# -lt 1 ]; then
  exit 0
fi

# Optionally update the remote repo
if [ $1 = "deploy" ]; then
  cd build/html
  git add .
  git commit -S -m "Docbot synching"
  git push -f origin gh-pages
fi
