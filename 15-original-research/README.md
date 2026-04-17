# Project 15: Original Empirical Analysis

## Economic Question
**You choose.** This should be a question drawn from your professional experience in international economic policy. Possible directions:
- Impact of financial inclusion interventions on economic outcomes (using Findex + WDI data)
- Effectiveness of development finance instruments (using OECD DAC data)
- EU structural funds revisited with modern DiD methods (extending Project 8)
- A question related to your proposed PhD topic

## What You're Learning
Independent research design: choosing a question, selecting an identification strategy, sourcing data, executing the analysis, and writing it up. This is the centrepiece of your portfolio.

## Theory to Read
No new theory. You're applying what you've learned in Projects 1–14. Re-read the relevant *Effect* chapter for whichever method you choose.

## Steps

### Week 1: Question and design
- Formulate a clear causal question
- Draw the DAG: what is the treatment, what is the outcome, what are the confounders?
- Choose an identification strategy from your toolkit: FE, DiD, IV, or RD
- Identify a publicly available dataset that lets you answer the question
- Write a 1-page research design memo: question, data, method, expected challenges

### Weeks 2–3: Data and analysis
- Download and clean the data
- Implement your chosen method in R
- Run robustness checks (different specifications, different samples, placebo tests)
- Produce clean tables and figures

### Week 4: Write-up
- Write an R Markdown document structured like a short empirical paper:
  1. Introduction (the question and why it matters)
  2. Data (sources, variables, summary statistics)
  3. Empirical strategy (identification, assumptions, threats)
  4. Results (main estimates, robustness)
  5. Discussion (what this tells us, limitations)
- This doesn't need to be publishable. It needs to show you can do economics independently.

## What "Done" Looks Like
- A complete, self-contained R Markdown document answering an original economic question
- Clean code, clear tables, honest discussion of limitations
- This is what you'd show a PhD admissions panel or potential supervisor

## Estimated Sessions: ~8
---

## Workflow Reminder

**See [WORKFLOW.md](../WORKFLOW.md) for the full two-pane workflow and sandbox convention.**

Quick version:
1. Open `15-original-research/analysis.Rmd` in Working Copy. This is your source of truth.
2. Open webRios alongside it.
3. Type new commands into `analysis.Rmd` → copy → paste into webRios → run.
4. Commands that create objects go in the pipeline section. Inspection commands (`glimpse`, `head`, `summary`, etc.) go in the sandbox section, commented out.
5. At the end of the session, commit and push from Working Copy. Suggested message: `"Project 15: [what you did this session]"`.

**Never copy from the webRios console back into `analysis.Rmd`.** Console output is disposable.

**At the end of the project:** create `reflection.md` using the template in `docs/tracking.md`.
