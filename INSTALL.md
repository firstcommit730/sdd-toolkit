# Spec-Kit Prompts - Install Guide

## Amazon Q Install

```bash
# Create Amazon Q prompts directory and copy all prompts
mkdir -p ~/.aws/amazonq/prompts && \
cp prompts/*.md ~/.aws/amazonq/prompts/ && \
echo "✅ Amazon Q prompts installed successfully!"
```

## GitHub Copilot Install

```bash
# Create GitHub prompts directory and copy all prompts
mkdir -p ~/.github/prompts && \
cp prompts/*.md ~/.github/prompts/ && \
echo "✅ GitHub prompts installed successfully!"
```

## Manual Install

**For Amazon Q:**
```bash
mkdir -p ~/.aws/amazonq/prompts
cp prompts/*.md ~/.aws/amazonq/prompts/
```

**For GitHub Copilot:**
```bash
mkdir -p ~/.github/prompts
cp prompts/*.md ~/.github/prompts/
```

## Verify Installation

**Amazon Q:**
```bash
ls -la ~/.aws/amazonq/prompts/
```

**GitHub Copilot:**
```bash
ls -la ~/.github/prompts/
```

You should see: `audit.md`, `constitution.md`, `implement.md`, `plan.md`, `specify.md`, `tasks.md`

## Quick Test

Type `@constitution` in your IDE to test the installation.

## Available Prompts

- `@audit` - Generate compliance audit and TODO list
- `@constitution` - Update project constitution with versioning
- `@specify` - Create feature specifications from descriptions  
- `@plan` - Generate implementation plans and design artifacts
- `@tasks` - Create dependency-ordered task breakdowns
- `@implement` - Execute implementation following task plan

## Prerequisites

- Amazon Q or GitHub Copilot plugin installed in your IDE
- Project with `.specify/` directory structure (this project has it)
- Bash shell access for script execution

## Next Steps

1. Read [AMAZONQ_PROMPTS_HOWTO.md](./AMAZONQ_PROMPTS_HOWTO.md) for usage guide
2. Start with: `@specify <your feature description>`
3. Follow the workflow: specify → plan → tasks → implement

## Troubleshooting

**Prompts not found:**
- Verify `~/.aws/amazonq/prompts/` directory exists
- Check file permissions: `chmod 644 ~/.aws/amazonq/prompts/*.md`

**Script errors:**
- Ensure you're in the project root directory
- Make scripts executable: `chmod +x .specify/scripts/bash/*.sh`

## Source Files

Prompt files are located at: `prompts/*.md`