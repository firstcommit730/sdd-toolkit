# LLM Specification Driven Development Toolkit - Installation Guide

A vendor-neutral installation guide for setting up SDD prompts with Amazon Q Developer and GitHub Copilot.

## Amazon Q Developer Install

```bash
# Create Amazon Q prompts directory and copy all prompts
mkdir -p ~/.aws/amazonq/prompts && \
cp prompts/*.md ~/.aws/amazonq/prompts/ && \
echo "✅ Amazon Q prompts installed successfully!"
```

## GitHub Copilot Install

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
```

**For GitHub Copilot:**

```bash
mkdir -p .github/prompts
for file in prompts/*.md; do
  cp "$file" .github/prompts/"$(basename "$file" .md).prompt.md"
done
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

## Source Files

Prompt files are located at: `prompts/*.md`

All prompts are vendor-neutral markdown files that work with multiple AI assistants.

## Attribution

This toolkit is inspired by and derived from [github/spec-kit](https://github.com/github/spec-kit), adapted for multi-vendor support and portability.
