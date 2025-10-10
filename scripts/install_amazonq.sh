#!/bin/bash

# Amazon Q installation script with dependency downloading
# Usage: curl -sSL -H "Cache-Control: no-cache" https://raw.githubusercontent.com/iadcialim/sdd-llm-toolkit/refs/heads/feature/create-installation-scripts/scripts/install_amazonq.sh | bash

set -e

# Download the helper scripts and save them to /tmp
BASE_URL="https://raw.githubusercontent.com/iadcialim/sdd-llm-toolkit/refs/heads/feature/create-installation-scripts/scripts"
TEMP_DIR="/tmp"
CLONE_SCRIPT="$TEMP_DIR/clone_repo.sh"

# Delete if helper script exists
rm -f $CLONE_SCRIPT

# Download the clone script and save to /tmp
curl -sSL -H "Cache-Control: no-cache" "$BASE_URL/clone_repo.sh" > "$CLONE_SCRIPT"
chmod +x $CLONE_SCRIPT

# Before cloning, make sure the repo folder does not exist in /tmp
rm -rf "$TEMP_DIR/sdd-llm-toolkit"

# Source the clone script
source $CLONE_SCRIPT

# Installation for Amazon Q
AMAZONQ_PATH="$HOME/.aws/amazonq"
AMAZONQ_PROMPTS_PATH="$AMAZONQ_PATH/prompts"
mkdir -p "$AMAZONQ_PROMPTS_PATH"

echo "Copying prompts folder to $AMAZONQ_PROMPTS_PATH"
cp prompts/*.md "$AMAZONQ_PROMPTS_PATH/"

SPECIFY_DIR=".specify"
to_exclude="memory"
if [ ! -d "$TARGET_PATH/$SPECIFY_DIR" ]; then
  to_exclude="memory/constitution.md"
fi

echo "Copying .specify folder to $TARGET_PATH but excluding $to_exclude"
rsync -av --exclude="$to_exclude" "$SPECIFY_DIR/" "$TARGET_PATH/$SPECIFY_DIR/"

echo "Copying sdd-toolkit folder to $AMAZONQ_PATH"
cp -r sdd-toolkit "$AMAZONQ_PATH/"

# Cleanup
rm -rf "$TEMP_DIR/sdd-llm-toolkit"
rm -f $CLONE_SCRIPT
cd "$TARGET_PATH"

echo "✅ Amazon Q prompts, .specify directory, and sdd-toolkit installed successfully!"