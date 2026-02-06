# Weekly GitHub Activity Report Generator (PowerShell version)
# Focused on SISP repositories

# Configuration
$GITHUB_USER = "jayeshvarshini-prog"
$START_DATE = (Get-Date).AddDays(-7).ToString("yyyy-MM-dd")
$END_DATE = (Get-Date).ToString("yyyy-MM-dd")
$REPORT_DIR = "reports"
$REPORT_FILE = "$REPORT_DIR\weekly-report-$(Get-Date -Format 'yyyy-MM-dd').md"

# Create reports directory if it doesn't exist
New-Item -ItemType Directory -Force -Path $REPORT_DIR | Out-Null

# Start report
@"
# Weekly GitHub Activity Report
**Period:** $START_DATE to $END_DATE
**User:** $GITHUB_USER
**Generated:** $(Get-Date)

---

## Summary

"@ | Out-File -FilePath $REPORT_FILE -Encoding utf8

# Get pull requests
"## Pull Requests`n" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8

"`n### PRs Created" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
try {
    $prs = gh search prs --author="$GITHUB_USER" --created="${START_DATE}..${END_DATE}" --json title,url,repository,state,createdAt | ConvertFrom-Json
    if ($prs.Count -eq 0) {
        "No PRs created this week`n" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
    } else {
        foreach ($pr in $prs) {
            "* [$($pr.repository.name)] $($pr.title) - $($pr.state)" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
            "  URL: $($pr.url)" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
            "  Created: $($pr.createdAt)`n" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
        }
    }
} catch {
    "No PRs created this week`n" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
}

"`n### PRs Reviewed/Commented" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
try {
    $reviewed = gh search prs --reviewed-by="$GITHUB_USER" --updated="${START_DATE}..${END_DATE}" --json title,url,repository,state | ConvertFrom-Json
    if ($reviewed.Count -eq 0) {
        "No PRs reviewed this week`n" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
    } else {
        foreach ($pr in $reviewed) {
            "* [$($pr.repository.name)] $($pr.title) - $($pr.state)" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
            "  URL: $($pr.url)`n" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
        }
    }
} catch {
    "No PRs reviewed this week`n" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
}

# Get issues
"`n## Issues`n" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8

"`n### Issues Created" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
try {
    $issues = gh search issues --author="$GITHUB_USER" --created="${START_DATE}..${END_DATE}" --json title,url,repository,state,createdAt | ConvertFrom-Json
    if ($issues.Count -eq 0) {
        "No issues created this week`n" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
    } else {
        foreach ($issue in $issues) {
            "* [$($issue.repository.name)] $($issue.title) - $($issue.state)" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
            "  URL: $($issue.url)" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
            "  Created: $($issue.createdAt)`n" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
        }
    }
} catch {
    "No issues created this week`n" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
}

"`n### Issues Commented On" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
try {
    $commented = gh search issues --commenter="$GITHUB_USER" --updated="${START_DATE}..${END_DATE}" --json title,url,repository,state | ConvertFrom-Json
    if ($commented.Count -eq 0) {
        "No issues commented on this week`n" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
    } else {
        foreach ($issue in $commented) {
            "* [$($issue.repository.name)] $($issue.title) - $($issue.state)" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
            "  URL: $($issue.url)`n" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
        }
    }
} catch {
    "No issues commented on this week`n" | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8
}

# Reflection section
@"

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

"@ | Out-File -FilePath $REPORT_FILE -Append -Encoding utf8

Write-Host "Report generated: $REPORT_FILE"
Get-Content $REPORT_FILE
