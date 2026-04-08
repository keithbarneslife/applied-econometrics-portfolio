# How to Use This Portfolio

This document explains the day-to-day workflow for working through the 16 projects independently.

## Setup

### Option A: iPad with webRios (Primary)

You need two apps:

1. **webRios** — your R environment. This is where you write and run R code.
2. **Working Copy** (iOS app) — a git client that clones this repo and lets you commit and push from your iPad. Free to clone and read; push requires a one-time Pro purchase (~£20).

**First-time setup:**
- Install both apps
- In Working Copy: clone `https://github.com/keithbarneslife/applied-econometrics-portfolio.git` (use your GitHub credentials or token)
- Your repo folders are now accessible in the iOS Files app under the "Working Copy" location

**Installing R packages (do this once):**

Open webRios and run:
```r
install.packages("tidyverse")
install.packages(c("WDI", "readxl", "knitr", "rmarkdown", "sandwich",
                    "lmtest", "modelsummary", "pwt10", "fixest",
                    "wooldridge", "did", "haven", "rdrobust",
                    "eurostat", "ggdag"))
```

### Option B: Mac with RStudio

If working on your Mac Mini instead:
- Clone the repo: `git clone https://github.com/keithbarneslife/applied-econometrics-portfolio.git`
- Open RStudio, set the project folder as your working directory
- Install the same packages as above
- Commit and push via Terminal or RStudio's Git tab

---

## A Typical Session (20–40 minutes)

### Step 1: Read the project README
Open the next project folder's `README.md` (either in Working Copy or on GitHub.com). It tells you exactly what to do: the economic question, the data source, the R packages, the steps, and the theory to read.

### Step 2: Write and run R code in webRios
- Open webRios
- Write your code for this session's task (each project README breaks the work into individual sessions)
- Run it, check the output, iterate

### Step 3: Save your work to the repo

**iPad workflow:**
1. In webRios, select all your code and copy it
2. Open Working Copy
3. Navigate to the project folder (e.g. `01-lac-gdp-trends/`)
4. Tap `+` → "New File" → name it `analysis.R` (or `analysis.Rmd` for R Markdown)
5. Paste your code and save
6. To save plots: if webRios lets you export images, save them to the project folder via Files app. Otherwise, you can regenerate plots later on your Mac.
7. Go to the repository root in Working Copy → "Commit" → write a message (e.g. "Project 01: completed data import and reshaping") → "Push"

**Tip:** If webRios supports the iOS Files app file provider, you may be able to save directly from webRios into the Working Copy folder, skipping the copy-paste. Test this: in webRios, try saving a file and see if "Working Copy" appears as a location in the save dialog.

**Mac workflow:**
```bash
cd applied-econometrics-portfolio
git add .
git commit -m "Project 01: completed data import and reshaping"
git push
```

### Step 4: When the project is complete
Create a `reflection.md` file in the project folder using the template in `docs/tracking.md`. Commit and push.

---

## Deciding What to Work On

Work through projects in order (1 → 16). Each project builds on the previous one.

**If you finish a project and it's a phase boundary (Projects 5, 8, 11, 14):** do a calibration review before starting the next phase. See `docs/tracking.md` for the template. Save it in `reviews/`.

**If you're stuck:** move sideways, not backwards. Try a different dataset or a simpler version of the same question. Don't restart from scratch. If you've been stuck for more than two sessions, record it in your reflection — that's useful diagnostic information.

---

## The Maths Thread

Before starting certain phases, work through the relevant section of `docs/maths-foundations.md`:

- Before Phase 1 (Projects 1–5): Expected values, variance, summation notation
- Before Phase 2a (Projects 6–8): Matrix algebra basics
- Before Phase 2c (Projects 12–13): Asymptotic theory intuition

These are short (20 min each) and can be done on paper + a quick R verification in webRios.

---

## File Naming Convention

Each project folder should contain:

| File | Purpose |
|------|---------|
| `analysis.R` or `analysis.Rmd` | Your main R code |
| `reflection.md` | Post-project reflection (use template from `docs/tracking.md`) |
| `*.png` | Any saved plots |
| `data/` subfolder (optional) | Downloaded datasets, if small enough to commit |

For large datasets (e.g. full WDI download), don't commit the data file. Instead, include the download code at the top of your R script so it's reproducible.

---

## When to Come Back to Claude

You don't need AI for the core workflow. But it's useful for:
- Debugging R code that isn't working
- Discussing a theory concept you can't resolve from the textbook
- Calibration reviews (talking through what to adjust)
- Phase 3 work (research proposal, supervisor identification)
- Pushing changes to GitHub if you prefer not to use Working Copy
