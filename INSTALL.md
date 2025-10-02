# LLM Specification Driven Development Toolkit - Installation Guide

A vendor-neutral installation guide for setting up SDD prompts with Amazon Q Developer and GitHub Copilot.

## Quick Install

### Amazon Q Developer (Global Installation)

Install prompts and `.specify/` directory globally for Amazon Q Developer. Copy and paste this command:

```bash
mkdir -p ~/.aws/amazonq/prompts && \
cd /tmp && \
git clone --depth 1 https://github.com/firstcommit730/sdd-llm-toolkit.git && \
cp sdd-llm-toolkit/prompts/*.md ~/.aws/amazonq/prompts/ && \
cp -r sdd-llm-toolkit/.specify ~/.aws/amazonq/ && \
rm -rf sdd-llm-toolkit && \
echo "✅ Amazon Q prompts and .specify directory installed successfully!"
```

**What this does:**

- Creates `~/.aws/amazonq/prompts/` directory
- Clones the latest toolkit from GitHub
- Copies all prompt files (`.md`)
- Copies the complete `.specify/` directory structure
- Cleans up temporary files
- Provides confirmation message

### GitHub Copilot (Project-Local Installation)

Install prompts and `.specify/` directory in your current project. Navigate to your project directory first, then copy and paste this command:

```bash
cd /tmp && \
git clone --depth 1 https://github.com/firstcommit730/sdd-llm-toolkit.git && \
cd - && \
mkdir -p .github/prompts && \
for file in /tmp/sdd-llm-toolkit/prompts/*.md; do \
  cp "$file" .github/prompts/"$(basename "$file" .md).prompt.md"; \
done && \
cp -r /tmp/sdd-llm-toolkit/.specify . && \
rm -rf /tmp/sdd-llm-toolkit && \
echo "✅ GitHub Copilot prompts and .specify directory installed successfully!"
```

**What this does:**

- Clones the latest toolkit from GitHub
- Creates `.github/prompts/` directory in your project
- Copies all prompt files with `.prompt.md` extension (Copilot requirement)
- Copies the complete `.specify/` directory structure to your project
- Cleans up temporary files
- Provides confirmation message

## Local Install (From Cloned Repository)

If you've already cloned this repository locally:

### Amazon Q Developer

```bash
mkdir -p ~/.aws/amazonq/prompts && \
cp prompts/*.md ~/.aws/amazonq/prompts/ && \
cp -r .specify ~/.aws/amazonq/ && \
echo "✅ Amazon Q prompts installed successfully!"
```

### GitHub Copilot

**Note:** GitHub Copilot requires prompts to be in the project's `.github/prompts/` directory with `.prompt.md` extension.

```bash
# Create GitHub Copilot prompts directory and copy all prompts
mkdir -p .github/prompts && \
for file in prompts/*.md; do \
  cp "$file" .github/prompts/"$(basename "$file" .md).prompt.md"; \
done && \
echo "✅ GitHub Copilot prompts installed successfully!"
```

## Manual Install

**For Amazon Q Developer:**

```bash
mkdir -p ~/.aws/amazonq/prompts
cp prompts/*.md ~/.aws/amazonq/prompts/
cp -r .specify ~/.aws/amazonq/
```

```bash
mkdir -p .github/prompts && \
for file in prompts/*.md; do \
  cp "$file" .github/prompts/"$(basename "$file" .md).prompt.md"; \
done && \
cp -r .specify . && \
echo "✅ GitHub Copilot prompts installed successfully!"
```

## Verify Installation

**Amazon Q Developer:**

```bash
ls -la ~/.aws/amazonq/prompts/
```

**GitHub Copilot:**

```bash
ls -la .github/prompts/
```

You should see the following prompts: `audit.md`, `constitution.md`, `drift.md`, `implement.md`, `plan.md`, `specify.md`, `tasks.md`

(Note: GitHub Copilot prompts will have `.prompt.md` extension)

## Quick Test

Type `@constitution` in your IDE to test the installation.

## Available Prompts

- `@audit` - Generate compliance audit and TODO list
- `@constitution` - Update project constitution with versioning
- `@drift` - Detect specification drift and validate implementation
- `@specify` - Create feature specifications from descriptions
- `@plan` - Generate implementation plans and design artifacts
- `@tasks` - Create dependency-ordered task breakdowns
- `@implement` - Execute implementation following task plan

## Prerequisites

- Amazon Q Developer or GitHub Copilot extension installed in your IDE
- Project with `.specify/` directory structure
- macOS, Linux, or WSL environment with zsh/bash shell access

## Project Structure

This toolkit requires the following directory structure:

```
.specify/
├── memory/              # Constitution and audit logs
├── reference/           # Domain context files (injected via @specify-reference)
├── scripts/bash/        # Helper scripts
└── templates/           # Markdown templates for prompts
```

The `.specify/` directory is automatically created when you first use the prompts.

## Next Steps

1. Read [PROMPTS_HOWTO.md](./PROMPTS_HOWTO.md) for detailed usage guide
2. Review [PROMPTS_SUMMARY.md](./PROMPTS_SUMMARY.md) for a quick reference
3. Start with: `@constitution` to set up project governance (optional)
4. Then: `@specify <your feature description>` to begin feature development
5. Follow the workflow: specify → plan → tasks → implement → audit

## Troubleshooting

**Prompts not found in Amazon Q:**

- Verify `~/.aws/amazonq/prompts/` directory exists
- Check file permissions: `chmod 644 ~/.aws/amazonq/prompts/*.md`
- Restart your IDE after installation

**Prompts not found in GitHub Copilot:**

- Ensure prompts are in `.github/prompts/` (project-local, not global)
- Verify files have `.prompt.md` extension
- Restart your IDE after installation

**Script errors:**

- Ensure you're in the project root directory
- Make scripts executable: `chmod +x .specify/scripts/bash/*.sh`
- Verify zsh or bash is available: `echo $SHELL`

**Permission denied:**

- Check directory permissions: `ls -la ~/.aws/amazonq/` or `ls -la .github/`
- Ensure you have write access to the target directories

## Uninstallation

**Remove Amazon Q prompts:**

```bash
rm -rf ~/.aws/amazonq/prompts
```

**Remove GitHub Copilot prompts:**

```bash
rm -rf .github/prompts
```

## Updating to Latest Version

### Using Update Scripts (Recommended)

The easiest way to update is using the automated update scripts:

**For GitHub Copilot:**

```bash
curl -sSL https://raw.githubusercontent.com/firstcommit730/sdd-llm-toolkit/main/sdd-toolkit/sdd-update-copilot.sh | bash
```

Or if you have the repository cloned:

```bash
./sdd-toolkit/sdd-update-copilot.sh
```

**For Amazon Q Developer:**

```bash
curl -sSL https://raw.githubusercontent.com/firstcommit730/sdd-llm-toolkit/main/sdd-toolkit/sdd-update-amazonq.sh | bash
```

Or if you have the repository cloned:

```bash
./sdd-toolkit/sdd-update-amazonq.sh
```

### Manual Update (From GitHub Repository)

#### Amazon Q Developer (Global)

Pull the latest prompts and update your global Amazon Q installation:

```bash
# Update Amazon Q prompts from repository
cd /tmp && \
git clone --depth 1 https://github.com/firstcommit730/sdd-llm-toolkit.git && \
rm -rf ~/.aws/amazonq/prompts/*.md && \
cp sdd-llm-toolkit/prompts/*.md ~/.aws/amazonq/prompts/ && \
rm -rf ~/.aws/amazonq/.specify && \
cp -r sdd-llm-toolkit/.specify ~/.aws/amazonq/ && \
rm -rf sdd-llm-toolkit && \
echo "✅ Amazon Q prompts updated successfully!"
```

#### GitHub Copilot (Project-Local)

Pull the latest prompts and update your project's Copilot installation:

```bash
# Update GitHub Copilot prompts in current project
cd /tmp && \
git clone --depth 1 https://github.com/firstcommit730/sdd-llm-toolkit.git && \
cd - && \
rm -rf .github/prompts/*.prompt.md && \
mkdir -p .github/prompts && \
for file in /tmp/sdd-llm-toolkit/prompts/*.md; do \
  cp "$file" .github/prompts/"$(basename "$file" .md).prompt.md"; \
done && \
rm -rf .specify/templates .specify/scripts && \
cp -r /tmp/sdd-llm-toolkit/.specify/templates .specify/ && \
cp -r /tmp/sdd-llm-toolkit/.specify/scripts .specify/ && \
rm -rf /tmp/sdd-llm-toolkit && \
echo "✅ GitHub Copilot prompts updated successfully!"
```

**Note:** The update commands will:

- Remove existing prompt files to avoid conflicts
- Pull the latest version from the repository
- **Preserve** your `.specify/memory/` directory (constitution and audits)
- Update `.specify/templates/` and `.specify/scripts/` to the latest versions

**⚠️ Warning:** If you've customized any templates in `.specify/templates/`, back them up before updating, as they will be overwritten.

## Source Files

Prompt files are located at: `prompts/*.md`

All prompts are vendor-neutral markdown files that work with multiple AI assistants.

## Attribution

This toolkit is inspired by and derived from [github/spec-kit](https://github.com/github/spec-kit), adapted for multi-vendor support and portability.
