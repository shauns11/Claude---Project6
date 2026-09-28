###############################
#CLAUDE.md (Project6)
###############################
  
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Purpose

Execute Stata do-file using Stata in batch mode This do-file will load and analyse the Stata dataset 
(survey_data.dta) that is in the data folder. The task involves opening and saving a new do-file in the code folder.

## File Paths

- Working directory: `C:\CLAUDE\Projects\Project6`
- Stata executable: `C:\Program Files\StataNow19\StataMP-64.exe`
- Do-files: `code\`
- Log files, tables, figures: `output\`
- Dataset: `data\`

## Running a Do-File

- Open Stata
- Create a new do-file 

## Do-File Template

Follow this structure in writing the do-file: 
- Open a log file at the top (using `replace`)

- Load the "survey_data.dta" dataset 

- Confirm the outcome variable exists in the dataset before proceeding (e.g. `describe <varname>` or `codebook <varname>`). If it does not exist, stop and check with the user rather than guessing a variable name.

- Use the 'svyset' command using the survey weight, primary sampling unit (PSU) and strata variables

- Set user defined values as missing for the outcome variable. Missing values 
are negative values (e.g. -9, -8 and -1)

- Estimate survey statistics for the outcome variable using complex survey commands (e.g. svy:mean)

- Publish the output using the etable command. Use the export option to save the output in a text file (.txt). This text file to be given the name of the outcome variable and saved in the output folder

- Capture date and time, display them, then close the log file.

Relevant Stata commands following this structure are (in this example, the outcome variable is "income"):

```stata
log using "C:\CLAUDE\Projects\Project6\output\income.log", replace

* ... commands ...

*load survey_data:
use "C:\CLAUDE\Projects\Project6\data\survey_data.dta", clear

*confirm outcome variable exists before proceeding:
describe income

*'svyset' the data:
svyset [pw=wt_int],psu(psu) strata(strata)

*set values as missing:
mvdecode income,mv(-9/-1)

*estimate survey statistics for the outcome variable: 
svy:mean income

*publish the output using the etable command and save in a txt file
etable, cstat(_r_b) cstat(_r_se, nformat(%7.2f)) export("C:/CLAUDE/Projects/Project6/output/income.txt", replace)


local date `c(current_date)'
local time `c(current_time)'
display _newline "Run `date' at `time'"

log close
```

### Running and Saving the do-file in batch mode


- Run the do-file from within Stata
- Save the do-file in the code folder within the working directory with a filename that refers to the outcome variable (e.g. income.do)

### Executing via command line

To run the do-file in batch mode, launch Stata with the `/e` flag from **PowerShell**, not the Bash tool. Git Bash rewrites leading-slash arguments like `/e` into filesystem paths, which silently breaks the flag — Stata then opens an idle interactive window instead of executing the do-file, and no log is produced.

Use `Start-Process` with `-Wait` so the call blocks until Stata exits and the log file is finalized:

```powershell
Start-Process -FilePath "C:\Program Files\StataNow19\StataMP-64.exe" -ArgumentList '/e do "C:\CLAUDE\Projects\Project6\code\Do_File_Name.do"' -Wait
```

After it returns, verify the expected `.log` file exists in `output\` before reporting the task as complete.

## Conventions

- Log file naming: `Do_File_Name.log` 
- Save do-files to `code\`, save log files to `output\`

## Examples 

- See the income.do file in the examples folder for example of workflow.

## Git and GitHub

Remote: `https://github.com/shauns11/Claude---Project6.git` (branch `main`). The GitHub CLI (`gh`) is not installed, so use plain `git` and the GitHub website.

### First-time setup (new project)

1. Create `.gitignore` in the project root **before** the first commit, so ignored files are never committed:

```text
# Secondary logs created by Stata batch mode (/e) in the project root
/*.log

# Stata datasets (anywhere in the project)
*.dta
```

2. Initialise the repository, check what will and won't be committed, then commit:

```powershell
git init -b main
git add .
git status --short             # files to be committed
git status --short --ignored   # lines starting "!!" are ignored (e.g. 01.log)
git commit -m "Initial commit"
```

3. Create an **empty** repository on github.com (no README, .gitignore or licence) and choose Public or Private.
4. Before pushing, confirm the remote exists and is empty. `git ls-remote` returns nothing for an empty repo and "Repository not found" if the URL is wrong, deleted or private without access:

```powershell
git ls-remote https://github.com/shauns11/Claude---Project6.git
```

5. Add the remote and push `main`:

```powershell
git remote add origin https://github.com/shauns11/Claude---Project6.git
git push -u origin main
git status -sb                 # should show: ## main...origin/main
```

6. Update the `Remote:` line at the top of this section.

Notes:
- Never use `git push --force` against a repository that already has history unless you intend to permanently replace it.
- Warnings like "LF will be replaced by CRLF" are Windows line-ending notices and can be ignored.

### Day-to-day

```powershell
git status                 # see what changed
git add .                  # stage changes
git commit -m "Message"    # commit
git push                   # upload to GitHub
```

### What is tracked

- Tracked: `code\` (do-files), `output\` (logs, tables, figures), `CLAUDE.md`, `.gitignore`
- Ignored (see `.gitignore`):
  - `/*.log` — root-level logs created by Stata batch mode
  - `*.dta` — Stata datasets, anywhere in the project



## Stata Skills

Comprehensive Stata reference files are stored locally at:

- [.claude/skills/stata/SKILL.md](.claude/skills/stata/SKILL.md) — Stata syntax, data management, econometrics, causal inference, graphics, Mata, and 20+ community packages (`reghdfe`, `estout`, `did`, `rdrobust`, etc.)
- [.claude/skills/stata-c-plugins/SKILL.md](.claude/skills/stata-c-plugins/SKILL.md) — C/C++ plugin development for Stata

When writing, debugging, or explaining Stata code, read the relevant SKILL.md first. Each file contains a routing table — follow it to load only the 1–3 reference files needed for the task. Reference files live alongside the SKILL.md in `references/` and `packages/` subdirectories.








