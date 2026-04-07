# How to Use This Portfolio (Without AI Assistance)

This document explains the day-to-day workflow for working through the 16 projects independently.

## Before Your First Session

1. Install R and RStudio on your Mac (if not already done)
2. Open RStudio and install the core packages:

```r
install.packages(c("tidyverse", "fixest", "modelsummary", "sandwich",
                    "lmtest", "rdrobust", "haven", "WDI", "wooldridge"))
```

3. Clone this repo (if you haven't already):

```bash
git clone https://github.com/keithbarneslife/applied-econometrics-portfolio.git
```

## A Typical Session (20–40 minutes)

1. **Open the next project folder** in RStudio (File > Open Project, or just open the folder)
2. **Read the project's README.md** — it tells you exactly what to do: the economic question, the data source, the R packages, the steps, and the theory chapters to read
3. **Create an R Markdown file** (e.g. `analysis.Rmd`) in the project folder and work through the steps
4. **When you're done for the day**, save your work and commit:

```bash
cd applied-econometrics-portfolio
git add .
git commit -m "Project 01: completed data import and reshaping"
git push
```

5. **When the project is complete**, copy the reflection template from below into a `reflection.md` file in the project folder, fill it in, and commit.

## Deciding What to Work On

Work through projects in order (1 → 16). Each project builds on the previous one. If you're between projects, check the timeline on the Notion dashboard to see if you're on pace.

**If you finish a project and it's a phase boundary (Projects 5, 8, 11, 14):** do a calibration review before starting the next phase. See `docs/tracking.md` for the template. Save it in `reviews/`.

**If you're stuck on a project:** move sideways, not backwards. Try a different dataset or a simpler version of the same question. Don't restart from scratch. If you've been stuck for more than two sessions, that's useful diagnostic information — record it in your reflection.

## The Maths Thread

Before starting certain phases, work through the relevant section of `docs/maths-foundations.md`:

- Before Phase 1 (Projects 1–5): Expected values, variance, summation notation
- Before Phase 2a (Projects 6–8): Matrix algebra basics
- Before Phase 2c (Projects 12–13): Asymptotic theory intuition

These are short (20 min each) and can be done on paper + a quick R verification. They're not optional — they make the theory sections of each project legible.

## Reflection Template

Copy this into a `reflection.md` file in each completed project folder:

```markdown
# Project [N] Reflection

**Planned sessions:** ~[X]
**Actual sessions:** [Y]

## What was harder than expected?

[Be specific: R syntax, data wrangling, theory, or conceptual?]

## What was easier than expected?

[What did your existing economics training still give you?]

## Primary difficulty category

[🔧 R syntax / 📊 Data wrangling / 📐 Maths gap / 💡 Conceptual]

## Confidence rating: [1-5]

1 = Could not explain it to someone else
2 = Understand the idea but would struggle to implement independently
3 = Can implement with reference materials
4 = Can implement and explain from memory
5 = Could teach it to a colleague

## Notes for future projects

[Anything that should inform how the next project is approached]
```

## When to Come Back to Claude

You don't need AI for the core workflow. But it's useful for:
- Debugging R code that isn't working
- Discussing a theory concept you can't resolve from the textbook
- Calibration reviews (talking through what to adjust)
- Phase 3 work (research proposal, supervisor identification)
- Pushing changes to GitHub if you prefer not to use Terminal
