# SDD Toolkit - Update Scripts

Automated update scripts for the Specification Driven Development (SDD) toolkit.

## Installation

For initial installation instructions with copy-paste commands, see [INSTALL.md](../INSTALL.md).

## Update Scripts

### GitHub Copilot

Update existing installation to the latest version:

```bash
./sdd-update-copilot.sh
```

Or run directly from GitHub:

```bash
curl -sSL https://raw.githubusercontent.com/firstcommit730/sdd-llm-toolkit/main/sdd-toolkit/sdd-update-copilot.sh | bash
```

**What it does:**

- Creates timestamped backup of existing prompts
- Clones latest version from GitHub
- Updates all prompt files
- Updates `.specify/templates/` and `.specify/scripts/`
- **Preserves** `.specify/memory/` (your constitution and audits)
- Cleans up temporary files

### Amazon Q Developer

Update existing installation to the latest version:

```bash
./sdd-update-amazonq.sh
```

Or run directly from GitHub:

```bash
curl -sSL https://raw.githubusercontent.com/firstcommit730/sdd-llm-toolkit/main/sdd-toolkit/sdd-update-amazonq.sh | bash
```

**What it does:**

- Creates timestamped backup of existing prompts
- Clones latest version from GitHub
- Updates all prompt files
- Updates `.specify/` directory
- **Preserves** `.specify/memory/` (your constitution and audits)
- Cleans up temporary files

## Features

All scripts include:

✅ **Automatic backups** - Creates timestamped backups before updating
✅ **Preservation of work** - Keeps your constitution and audit history
✅ **Colorized output** - Clear visual feedback during execution
✅ **Error handling** - Exits on errors with helpful messages
✅ **Cleanup** - Automatically removes temporary files
✅ **Verification** - Provides next steps and verification commands

## Requirements

- macOS, Linux, or WSL environment
- `bash` or `zsh` shell
- `git` installed
- Internet connection
- For Copilot: Must be run from within a git repository

## Troubleshooting

**Permission denied:**

```bash
chmod +x sdd-toolkit/*.sh
```

**Not in a git repository (Copilot updates only):**

- Ensure you're running the script from within a git repository
- Initialize a git repo: `git init`

**Network errors:**

- Check your internet connection
- Verify GitHub is accessible: `ping github.com`

**Script not found when using curl:**

- Ensure the URL is correct
- Try downloading the script first and run locally

## Directory Structure

After installation, you'll have:

```
# For GitHub Copilot (project-local)
.github/prompts/          # Prompt files with .prompt.md extension
.specify/
  ├── memory/             # Constitution and audit logs (preserved on update)
  ├── reference/          # Domain context files
  ├── scripts/bash/       # Helper scripts
  └── templates/          # Markdown templates

# For Amazon Q Developer (global)
~/.aws/amazonq/prompts/   # Prompt files
~/.aws/amazonq/.specify/  # Same structure as above
```

## Support

For issues, questions, or contributions:

- Repository: https://github.com/firstcommit730/sdd-llm-toolkit
- Issues: https://github.com/firstcommit730/sdd-llm-toolkit/issues
