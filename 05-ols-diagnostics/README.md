# Project 5: OLS Diagnostics and Professional Presentation

## Economic Question
Same underlying question as Project 4, but now presented as a polished empirical analysis.

## What You're Learning
Residual diagnostics, functional form choice (logs vs levels), and producing publication-quality regression tables with `modelsummary`.

## Theory to Read
*The Effect*, Chapter 10 (Treatment Effects) — skim for the discussion of functional form. Also review the Gauss-Markov assumptions: what needs to hold for OLS to be BLUE? Heteroskedasticity violates one of them — what are the consequences for inference (not for consistency)?

Wooldridge, Chapter 8 (Heteroskedasticity) — reference if you want the formal treatment.

## Data Source
Same as Project 4.

## R Packages Needed
`tidyverse`, `modelsummary`, `sandwich`, `lmtest`

## Steps

### Session 1: Diagnostics
- Take your best model from Project 4
- Plot residuals vs fitted values: `plot(model, which = 1)`
- Plot residuals vs each regressor — look for non-linearity or heteroskedasticity
- Breusch-Pagan test: `lmtest::bptest(model)` — is heteroskedasticity statistically significant?

### Session 2: Functional form
- Re-estimate in logs: `lm(log(account) ~ log(gdp_pc) + ...)`
- Compare residual plots. Are the log models better behaved?
- Interpret log-log coefficients as elasticities: "A 1% increase in GDP is associated with a ___% increase in account ownership"

### Session 3: Professional presentation
- Use `modelsummary` to produce a multi-column regression table showing all specifications side by side (bivariate, with controls, in logs, with robust SEs)
- `modelsummary(list("Bivariate" = m1, "Controls" = m2, "Log-Log" = m3), stars = TRUE)`
- This is what a table in a published paper looks like. Get comfortable producing them.

## What "Done" Looks Like
- R Markdown with diagnostic plots, log specifications, and a publication-quality regression table
- You can explain the Gauss-Markov assumptions and what heteroskedasticity does to inference
- **This completes Phase 1.** Do a calibration review (see `docs/tracking.md`) before starting Phase 2.

## Estimated Sessions: ~3


---

## Saving Your Work (iPad / webRios Workflow)

> See [WORKFLOW.md](../WORKFLOW.md) for full setup instructions.

1. Write and run your code in **webRios**
2. When done, copy your code
3. In **Working Copy**, navigate to `05-ols-diagnostics/`
4. Create `analysis.Rmd` (tap + → New File), paste your code, save
5. Commit with a message like "Project 05: [what you did this session]"
6. Push

**Files to create in this folder:**
- `analysis.Rmd` — your main analysis code
- `reflection.md` — fill in after completing the project (template in `docs/tracking.md`)
- Any exported plots (`.png`)
