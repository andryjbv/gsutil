#!/bin/sh
# Common Setup, DO NOT MODIFY
cd /app
set -e

###############################################
# PROJECT DEPENDENCIES AND CONFIGURATION
###############################################
# Install project dependencies
pip install --no-cache-dir -U pip
pip install --no-cache-dir .

# Configure environment variables
export LANG=C.UTF-8
export LC_ALL=C.UTF-8

###############################################
# BUILD
###############################################
echo "================= 0909 BUILD START 0909 ================="
# No additional build steps required

echo "================= 0909 BUILD END 0909 ================="
