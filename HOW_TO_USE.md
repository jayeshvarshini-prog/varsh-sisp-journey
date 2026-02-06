# How to Use Your Learning Journey System

## Overview

This repository includes an intelligent learning system that:
- Tracks your GitHub activity automatically
- Generates weekly reports of your contributions
- Asks you reflection questions
- Adjusts your learning plan based on what you're actually doing

## Weekly Review Process

### Step 1: Generate Your Weekly Report

Run the slash command in Claude Code:
```
/weekly-review
```

This will:
1. Fetch your GitHub activity from the past 7 days
2. Show PRs created, reviewed, issues, and comments (focused on SISP repos)
3. Generate a dated report in `reports/weekly-report-YYYY-MM-DD.md`

### Step 2: Reflect on Your Week

Claude will ask you questions like:
- What did you work on this week?
- What challenges did you face?
- What new concepts did you encounter?
- What skills did you use?
- What did you learn?

Answer thoughtfully - this helps tailor your learning plan!

### Step 3: Review the Analysis

Claude will:
- Analyze your GitHub activity patterns
- Identify skills you're using
- Spot areas where you might need more practice
- Connect your contributions to your learning goals

### Step 4: Get Your Updated Plan

Your `LEARNING_PLAN.md` will be automatically updated with:
- This week's activity summary
- Adjusted priorities based on what you worked on
- New focus areas
- Specific action items for next week
- Updated skill metrics

## Manual Report Generation

You can also generate reports manually:

**PowerShell (Windows):**
```powershell
cd C:\Users\Varshini\Documents\GitHub\varsh-sisp-journey
.\scripts\generate-weekly-report.ps1
```

**Bash (Git Bash/WSL):**
```bash
cd /c/Users/Varshini/Documents/GitHub/varsh-sisp-journey
bash scripts/generate-weekly-report.sh
```

## Directory Structure

```
varsh-sisp-journey/
├── reports/                    # Weekly activity reports
│   └── weekly-report-YYYY-MM-DD.md
├── scripts/                    # Report generation scripts
│   ├── generate-weekly-report.ps1
│   └── generate-weekly-report.sh
├── LEARNING_PLAN.md           # Your adaptive learning plan
├── notes/                      # Learning documentation
├── frontend-practice/          # Frontend exercises
├── admin-practice/            # Admin panel exploration
├── database-practice/         # Database learning
├── design-patterns/           # Software engineering patterns
└── experiments/               # General prototyping
```

## Tips for Success

### 1. **Weekly Consistency**
- Run `/weekly-review` every Friday or Monday
- Reflect honestly on your week
- Review the adjusted plan before starting new work

### 2. **Document as You Go**
- Keep `notes/LEARNING_NOTES.md` updated
- Add insights when you learn something new
- Link to relevant PRs and issues

### 3. **Practice Deliberately**
- Use practice directories to recreate SISP features
- Try implementing patterns you see in the codebase
- Experiment without fear of breaking production code

### 4. **Connect Activity to Learning**
- Notice patterns in what you're working on
- If you're always doing frontend work, maybe schedule database practice
- Balance between comfort zone and growth areas

### 5. **Track Progress**
- Look back at old weekly reports to see how far you've come
- Update skill metrics honestly in your learning plan
- Celebrate small wins!

## Example Workflow

**Monday Morning:**
```
1. Run /weekly-review to see last week's activity
2. Reflect on what you learned
3. Review updated learning plan
4. Set goals for the week based on recommendations
```

**During the Week:**
```
1. Work on SISP contributions
2. When you learn something new, document it in notes/
3. Practice new concepts in your practice directories
4. Ask questions in PRs and issues
```

**Friday Afternoon:**
```
1. Update any reflection sections in your latest report
2. Make notes about what to focus on next week
3. Review what you want to learn over the weekend
```

## Customization

### Adjust Report Scope

Edit the scripts to focus on specific repos:
- Add `--repo="org/repo-name"` filters to gh commands
- Change date ranges (default is 7 days)
- Add additional GitHub metrics

### Modify Learning Plan

Your `LEARNING_PLAN.md` is fully customizable:
- Add your own focus areas
- Adjust priorities
- Add specific SISP-related goals
- Track custom metrics

### Add Custom Questions

You can add reflection prompts in the report template to guide your weekly reviews.

## Troubleshooting

**Script doesn't run:**
- Make sure you're in the repository directory
- Check that GitHub CLI is installed: `gh --version`
- Verify you're authenticated: `gh auth status`

**No activity showing:**
- Verify your GitHub username in the script
- Check date ranges
- Make sure you've made contributions in the past week

**Claude can't find the skill:**
- Skills are loaded from `~/.claude/skills/`
- Restart Claude Code after adding new skills
- Check that `weekly-review.json` is in the correct location

## Questions?

Ask Claude! Say something like:
- "Walk me through my first weekly review"
- "Help me understand my learning plan"
- "What should I focus on this week?"
- "Show me my progress over time"
