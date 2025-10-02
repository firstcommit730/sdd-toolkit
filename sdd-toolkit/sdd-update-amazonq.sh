#!/usr/bin/env bash
#
# sdd-update-amazonq.sh
# Update Amazon Q Developer prompts and .specify directory from the SDD toolkit repository
#
# Usage: ./sdd-update-amazonq.sh
#

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🔄 Updating Amazon Q Developer SDD Toolkit...${NC}"

# Create temporary directory
TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

echo -e "${YELLOW}📥 Cloning latest version from GitHub...${NC}"
cd "$TMP_DIR"
git clone --depth 1 https://github.com/firstcommit730/sdd-llm-toolkit.git

# Create Amazon Q prompts directory if it doesn't exist
AMAZONQ_DIR="$HOME/.aws/amazonq"
mkdir -p "$AMAZONQ_DIR/prompts"

# Backup existing files if they exist
if [ "$(ls -A $AMAZONQ_DIR/prompts 2>/dev/null)" ]; then
    echo -e "${YELLOW}📦 Backing up existing prompts...${NC}"
    BACKUP_DIR="$AMAZONQ_DIR/prompts.backup.$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    cp -r "$AMAZONQ_DIR/prompts"/* "$BACKUP_DIR/" 2>/dev/null || true
    echo -e "${GREEN}✓ Backup created at: $BACKUP_DIR${NC}"
fi

# Remove old prompt files
echo -e "${YELLOW}🗑️  Removing old prompt files...${NC}"
rm -rf "$AMAZONQ_DIR/prompts"/*.md 2>/dev/null || true

# Copy new prompts
echo -e "${YELLOW}📝 Copying new prompt files...${NC}"
for file in "$TMP_DIR"/sdd-llm-toolkit/prompts/*.md; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        cp "$file" "$AMAZONQ_DIR/prompts/$filename"
        echo -e "${GREEN}  ✓ ${filename}${NC}"
    fi
done

# Update .specify directory (preserve memory folder)
echo -e "${YELLOW}📂 Updating .specify directory...${NC}"

# Backup memory folder if it exists
MEMORY_BACKUP=""
if [ -d "$AMAZONQ_DIR/.specify/memory" ]; then
    MEMORY_BACKUP=$(mktemp -d)
    cp -r "$AMAZONQ_DIR/.specify/memory"/* "$MEMORY_BACKUP/" 2>/dev/null || true
    echo -e "${GREEN}  ✓ Preserved .specify/memory/${NC}"
fi

# Remove and update .specify directory
rm -rf "$AMAZONQ_DIR/.specify" 2>/dev/null || true
cp -r "$TMP_DIR"/sdd-llm-toolkit/.specify "$AMAZONQ_DIR/"
echo -e "${GREEN}  ✓ Updated .specify directory${NC}"

# Make scripts executable
chmod +x "$AMAZONQ_DIR/.specify/scripts/bash"/*.sh 2>/dev/null || true

# Restore memory folder if it was backed up
if [ -n "$MEMORY_BACKUP" ] && [ -d "$MEMORY_BACKUP" ]; then
    mkdir -p "$AMAZONQ_DIR/.specify/memory"
    cp -r "$MEMORY_BACKUP"/* "$AMAZONQ_DIR/.specify/memory"/ 2>/dev/null || true
    rm -rf "$MEMORY_BACKUP"
fi

# Create reference directory if it doesn't exist
mkdir -p "$AMAZONQ_DIR/.specify/reference"

echo -e "${GREEN}✅ Amazon Q Developer SDD Toolkit updated successfully!${NC}"
echo ""
echo -e "${YELLOW}📋 Updated components:${NC}"
echo -e "  • Prompts: ~/.aws/amazonq/prompts/*.md"
echo -e "  • Templates: ~/.aws/amazonq/.specify/templates/"
echo -e "  • Scripts: ~/.aws/amazonq/.specify/scripts/"
echo -e "  • Preserved: ~/.aws/amazonq/.specify/memory/ (constitution & audits)"
echo ""
echo -e "${YELLOW}💡 Next steps:${NC}"
echo -e "  1. Restart your IDE to reload the prompts"
echo -e "  2. Test with: @constitution"
echo -e "  3. Verify installation: ls -la ~/.aws/amazonq/prompts/"
