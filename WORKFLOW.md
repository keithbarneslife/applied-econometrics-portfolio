# How to Use This Portfolio

This document explains the day-to-day workflow for working through the 16 projects.

## Setup

### Option A: iPad with webRios (Primary)

You need two apps:

1. **webRios** — your R environment. This is where code runs.
2. **Working Copy** — a git client that holds your repo and acts as your text editor for `analysis.R` files. Free to clone and read; ~£20 one-off for push.

**First-time setup:**
- Install both apps
- In Working Copy: clone `https://github.com/keithbarneslife/applied-econometrics-portfolio.git`
- Install R packages in webRios (see `setup.R` at the repo root, or re-run the install command from the chat history)

### Option B: Mac with RStudio

- Clone: `git clone https://github.com/keithbarneslife/applied-econometrics-portfolio.git`
- Open RStudio, install the same packages, commit and push via Terminal or RStudio's Git tab

---

## The Two-Pane Workflow (iPad)

This is the most important thing to internalise. **`analysis.R` in Working Copy is the source of truth. webRios is just where code runs.**

**Setup at the start of every session:**
1. Open Working Copy in Split View on your iPad
2. Navigate to the project folder, open `analysis.R`
3. Open webRios in the other pane

**During the session, the flow is one-directional: Working Copy → webRios.**

1. Type a new command into `analysis.R` (in Working Copy — Working Copy is your text editor)
2. Copy that command
3. Paste into webRios, run it
4. Look at the output in the webRios console
5. If it worked, the command is already in `analysis.R`. Go back to Working Copy and type the next command.
6. If it didn't work, fix the command in `analysis.R` and try again.

**You never copy from webRios back to `analysis.R`.** The console output stays in the console. The file stays clean.

**At the end of the session:** commit and push from Working Copy.

### Why this works

On a Mac, RStudio has a "script pane" and a "console pane" — you write in the script and send lines to the console with Cmd+Enter. The output appears in the console but never contaminates the script. We're using Working Copy and webRios as separate panes to mimic the same separation on iPad.

---

## The Sandbox Convention

Not every command belongs in the pipeline. Exploratory commands like `glimpse()`, `head()`, `nrow()`, `summary()`, and `unique()` are useful *during* a session but you don't want them to run every time you re-source the script.

Every `analysis.R` file has two sections:

```r
# =========================================
# Pipeline: run top to bottom to reproduce the analysis
# =========================================

library(tidyverse)
gdp <- ...   # permanent pipeline commands

# =========================================
# Sandbox: one-off inspection, not part of pipeline
# =========================================
# glimpse(gdp_raw)
# head(gdp_raw)
# nrow(gdp)
```

**Rule of thumb:**
- **Pipeline (no comment):** any command that creates or modifies an object (`<-`, `%>%`, regressions, plots you want regenerated)
- **Sandbox (commented out):** any command that just prints or inspects (`glimpse`, `head`, `print`, `summary`, `unique`, `nrow`)

When you're starting a new session, re-sourcing the pipeline brings your state back instantly. If you want to inspect something again, uncomment the relevant sandbox line and run it.

---

## A Typical Session (20–40 minutes)

### Step 1: Reload your state
Open the project folder. Open `analysis.R`. Copy the entire pipeline section, paste into webRios, run it. You now have every object from the previous session back in memory.

### Step 2: Read the next session's instructions in the project README

### Step 3: Work through the steps
For each new command:
- Type it into `analysis.R` (in Working Copy)
- Copy, paste into webRios, run
- If exploratory (`glimpse`, `head`, etc.) → move the line into the sandbox section and comment it out
- If pipeline → leave it in the pipeline section

### Step 4: Commit and push
In Working Copy: Commit → write a message (e.g. "Project 01: session 3 - visualisation") → Push.

### Step 5: When the project is complete
Create `reflection.md` in the project folder using the template in `docs/tracking.md`. Commit and push.

---

## Deciding What to Work On

Work through projects in order (1 → 16). Each project builds on the previous one.

**Phase boundaries (after Projects 5, 8, 11, 14):** do a calibration review before starting the next phase. See `docs/tracking.md`. Save in `reviews/`.

**If you're stuck for more than two sessions on a single step:** record it in your reflection and move on. That's useful diagnostic information.

---

## The Maths Thread

Before starting certain phases, work through the relevant section of `docs/maths-foundations.md`:

- Before Phase 1 (Projects 1–5): Expected values, variance, summation notation
- Before Phase 2a (Projects 6–8): Matrix algebra basics
- Before Phase 2c (Projects 12–13): Asymptotic theory intuition

20 min each, on paper + quick R verification in webRios.

---

## When to Come Back to Claude

You don't need AI for the core workflow. But it's useful for:
- Debugging R code that isn't working
- Discussing a theory concept you can't resolve from the textbook
- Calibration reviews
- Phase 3 work (research proposal, supervisor identification)
