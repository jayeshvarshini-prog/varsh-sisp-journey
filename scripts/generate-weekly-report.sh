#!/bin/bash
# Weekly GitHub Activity Report Generator
# Focused on SISP repositories

# Configuration
GITHUB_USER="jayeshvarshini-prog"
START_DATE=$(date -d '7 days ago' +%Y-%m-%d 2>/dev/null || date -v-7d +%Y-%m-%d 2>/dev/null || echo "2024-01-01")
END_DATE=$(date +%Y-%m-%d)
REPORT_DIR="reports"
REPORT_FILE="$REPORT_DIR/weekly-report-$(date +%Y-%m-%d).md"

# Create reports directory if it doesn't exist
mkdir -p "$REPORT_DIR"

# Start report
cat > "$REPORT_FILE" <<EOF
# Weekly GitHub Activity Report
**Period:** $START_DATE to $END_DATE
**User:** $GITHUB_USER
**Generated:** $(date)

---

## Summary

EOF

# Get pull requests
echo "## Pull Requests" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "### PRs Created" >> "$REPORT_FILE"
gh search prs --author="$GITHUB_USER" --created="$START_DATE..$END_DATE" --json title,url,repository,state,createdAt --template '{{range .}}* [{{.repository.name}}] {{.title}} - {{.state}}
  URL: {{.url}}
  Created: {{.createdAt}}
{{end}}' >> "$REPORT_FILE" 2>/dev/null || echo "No PRs created this week" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "### PRs Reviewed/Commented" >> "$REPORT_FILE"
gh search prs --reviewed-by="$GITHUB_USER" --updated="$START_DATE..$END_DATE" --json title,url,repository,state --template '{{range .}}* [{{.repository.name}}] {{.title}} - {{.state}}
  URL: {{.url}}
{{end}}' >> "$REPORT_FILE" 2>/dev/null || echo "No PRs reviewed this week" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Get issues
echo "## Issues" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "### Issues Created" >> "$REPORT_FILE"
gh search issues --author="$GITHUB_USER" --created="$START_DATE..$END_DATE" --json title,url,repository,state,createdAt --template '{{range .}}* [{{.repository.name}}] {{.title}} - {{.state}}
  URL: {{.url}}
  Created: {{.createdAt}}
{{end}}' >> "$REPORT_FILE" 2>/dev/null || echo "No issues created this week" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "### Issues Commented On" >> "$REPORT_FILE"
gh search issues --commenter="$GITHUB_USER" --updated="$START_DATE..$END_DATE" --json title,url,repository,state --template '{{range .}}* [{{.repository.name}}] {{.title}} - {{.state}}
  URL: {{.url}}
{{end}}' >> "$REPORT_FILE" 2>/dev/null || echo "No issues commented on this week" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Reflection section
cat >> "$REPORT_FILE" <<EOF

---

## Reflection & Learning

### What I worked on:
-

### Challenges faced:
-

### Skills used:
-

### What I learned:
-

### Questions for next week:
-

---

## Action Items for Educational Plan

Based on this week's activity, consider:
- [ ] Areas that need more practice
- [ ] New concepts encountered
- [ ] Skills to develop further
- [ ] Topics to deep dive

EOF

echo "Report generated: $REPORT_FILE"
cat "$REPORT_FILE"
