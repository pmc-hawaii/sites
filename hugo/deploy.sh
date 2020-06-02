#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

set HUGO_ENV=production

# Build the project with ananke theme.
hugo -D

# Copy published docs to root level where Github pages read at https://pmc-hawaii.github.io/.
cp -rf public/* ..

# delete the published folder
# rm -rf docs

# Add changes from hugo folder and the root folder to git.
git add ..

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master