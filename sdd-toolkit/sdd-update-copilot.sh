#!/usr/bin/env bash
#
# sdd-update-copilot.sh
# Update GitHub Copilot prompts and .specify directory from the SDD toolkit repository
#
# Usage: ./sdd-update-copilot.sh
#

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🔄 Updating GitHub Copilot SDD Toolkit...${NC}"

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}❌ Error: Not in a git repository${NC}"
    exit 1
fi

# Get the project root
PROJECT_ROOT=$(git rev-parse --show-toplevel)
cd "$PROJECT_ROOT"

# Create temporary directory
TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

echo -e "${YELLOW}📥 Cloning latest version from GitHub...${NC}"
cd "$TMP_DIR"
git clone --depth 1 https://github.com/firstcommit730/sdd-llm-toolkit.git

cd "$PROJECT_ROOT"

# Backup existing files if they exist
if [ -d ".github/prompts" ]; then
    echo -e "${YELLOW}📦 Backing up existing prompts...${NC}"
    BACKUP_DIR=".github/prompts.backup.$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    cp -r .github/prompts/* "$BACKUP_DIR/" 2>/dev/null || true
    echo -e "${GREEN}✓ Backup created at: $BACKUP_DIR${NC}"
fi

# Remove old prompt files
echo -e "${YELLOW}🗑️  Removing old prompt files...${NC}"
rm -rf .github/prompts/*.prompt.md 2>/dev/null || true

# Create prompts directory if it doesn't exist
mkdir -p .github/prompts

# Copy new prompts with .prompt.md extension
echo -e "${YELLOW}📝 Copying new prompt files...${NC}"
for file in "$TMP_DIR"/sdd-llm-toolkit/prompts/*.md; do
    if [ -f "$file" ]; then
        filename=$(basename "$file" .md)
        cp "$file" ".github/prompts/${filename}.prompt.md"
        echo -e "${GREEN}  ✓ ${filename}.prompt.md${NC}"
    fi
done

# Update .specify directory (preserve memory folder)
echo -e "${YELLOW}📂 Updating .specify directory...${NC}"

# Backup memory folder if it exists
MEMORY_BACKUP=""
if [ -d ".specify/memory" ]; then
    MEMORY_BACKUP=$(mktemp -d)
    cp -r .specify/memory/* "$MEMORY_BACKUP/" 2>/dev/null || true
    echo -e "${GREEN}  ✓ Preserved .specify/memory/${NC}"
fi

# Remove and update templates and scripts
rm -rf .specify/templates .specify/scripts 2>/dev/null || true
mkdir -p .specify

cp -r "$TMP_DIR"/sdd-llm-toolkit/.specify/templates .specify/
echo -e "${GREEN}  ✓ Updated templates${NC}"

cp -r "$TMP_DIR"/sdd-llm-toolkit/.specify/scripts .specify/
echo -e "${GREEN}  ✓ Updated scripts${NC}"

# Make scripts executable
chmod +x .specify/scripts/bash/*.sh 2>/dev/null || true

# Restore memory folder if it was backed up
if [ -n "$MEMORY_BACKUP" ] && [ -d "$MEMORY_BACKUP" ]; then
    mkdir -p .specify/memory
    cp -r "$MEMORY_BACKUP"/* .specify/memory/ 2>/dev/null || true
    rm -rf "$MEMORY_BACKUP"
fi

# Create reference directory if it doesn't exist
mkdir -p .specify/reference

echo -e "${GREEN}✅ GitHub Copilot SDD Toolkit updated successfully!${NC}"
echo ""
echo -e "${YELLOW}📋 Updated components:${NC}"
echo -e "  • Prompts: .github/prompts/*.prompt.md"
echo -e "  • Templates: .specify/templates/"
echo -e "  • Scripts: .specify/scripts/"
echo -e "  • Preserved: .specify/memory/ (constitution & audits)"
echo ""
echo -e "${YELLOW}💡 Next steps:${NC}"
echo -e "  1. Restart your IDE to reload the prompts"
echo -e "  2. Test with: @constitution"
echo -e "  3. Review changes: git status"
