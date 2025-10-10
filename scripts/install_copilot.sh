#!/bin/bash

# Amazon Q installation script with dependency downloading
# Usage: curl -sSL -H "Cache-Control: no-cache" https://raw.githubusercontent.com/iadcialim/sdd-llm-toolkit/refs/heads/feature/create-installation-scripts/scripts/install_copilot.sh | bash

set -e

# Download the helper scripts and save them to /tmp
BASE_URL="https://raw.githubusercontent.com/iadcialim/sdd-llm-toolkit/refs/heads/feature/create-installation-scripts/scripts"
TEMP_DIR="/tmp"
CLONE_SCRIPT="$TEMP_DIR/clone_repo.sh"

# Delete if helper scripts exists
rm -f $CLONE_SCRIPT

curl -sSL -H "Cache-Control: no-cache" "$BASE_URL/clone_repo.sh" > "$CLONE_SCRIPT"
chmod +x $CLONE_SCRIPT

# Before cloning, make sure the repo folder does not exist in /tmp
rm -rf "$TEMP_DIR/sdd-llm-toolkit"

# Source the clone script
source "$CLONE_SCRIPT"

# Installation for Github Copilot
COPILOT_PROMPTS_PATH="$TARGET_PATH/.github/prompts"
mkdir -p $COPILOT_PROMPTS_PATH

echo "Copying prompts folder to $COPILOT_PROMPTS_PATH"
for file in $SDD_LLM_TOOLKIT_PATH/prompts/*.md; do \
  cp "$file" $COPILOT_PROMPTS_PATH/"$(basename "$file" .md).prompt.md"; \
done

SPECIFY_DIR=".specify"
to_exclude="memory"
if [ ! -d "$TARGET_PATH/$SPECIFY_DIR" ]; then
  to_exclude="memory/constitution.md"
fi

echo "Copying .specify folder to $TARGET_PATH but excluding $to_exclude"
rsync -av --exclude="$to_exclude" "$SPECIFY_DIR/" "$TARGET_PATH/$SPECIFY_DIR/"

echo "Copying sdd-toolkit folder to $TARGET_PATH"
cp -r sdd-toolkit "$TARGET_PATH/"

# Cleanup
rm -rf $SDD_LLM_TOOLKIT_PATH
rm -f $CLONE_SCRIPT
cd "$TARGET_PATH"

echo "✅ GitHub Copilot prompts, .specify directory, and sdd-toolkit installed successfully!"
