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

## Saving Your Work (iPad / webRios Workflow)

> See [WORKFLOW.md](../WORKFLOW.md) for full setup instructions.

1. Write and run your code in **webRios**
2. When done, copy your code
3. In **Working Copy**, navigate to `15-original-research/`
4. Create `analysis.Rmd` (tap + → New File), paste your code, save
5. Commit with a message like "Project 15: [what you did this session]"
6. Push

**Files to create in this folder:**
- `analysis.Rmd` — your main analysis code
- `reflection.md` — fill in after completing the project (template in `docs/tracking.md`)
- Any exported plots (`.png`)
