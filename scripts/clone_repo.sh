#!/bin/bash
# This is utility script to clone the sdd-llm-toolkit repo to a temp directory

# This is the path where this script is being executed
# This is usually the project root directory where the user wants to install this ssd-llm-toolkit
TARGET_PATH="$(pwd)"

SDD_LLM_TOOLKIT="sdd-llm-toolkit"
TEMP_DIR="/tmp"
SDD_LLM_TOOLKIT_PATH=$TEMP_DIR/$SDD_LLM_TOOLKIT

# Clone repository to the temp directory
cd $TEMP_DIR
echo "Cloning repository to $SDD_LLM_TOOLKIT_PATH"
git clone --depth 1 https://github.com/firstcommit730/$SDD_LLM_TOOLKIT.git
cd $SDD_LLM_TOOLKIT

# Export variables for use by calling script
export TARGET_PATH
export SDD_LLM_TOOLKIT
export TEMP_DIR
export SDD_LLM_TOOLKIT_PATH