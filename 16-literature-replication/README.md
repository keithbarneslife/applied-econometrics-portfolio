# Project 16: Literature Replication

## Economic Question
Depends on the paper you choose. Ideally, this paper is closely related to your proposed PhD research topic.

## What You're Learning
Engaging with the research frontier: reading a paper closely enough to reproduce its main results, understanding its data and methodology at a granular level, and connecting your work to potential supervisors.

## How to Choose a Paper
1. Go to the University of Reading Economics department staff page: https://www.reading.ac.uk/economics/our-staff/
2. Identify 2–3 faculty members whose research interests align with yours
3. Read their recent publications (last 3–5 years)
4. Choose a paper that: (a) uses a method you've learned (FE, DiD, IV, RD), (b) has replication data available (check the journal's replication archive or the author's website), and (c) relates to a question you might want to pursue in your PhD

## Steps

### Weeks 1–2: Read and obtain data
- Read the paper carefully. Understand the research question, identification strategy, and main results
- Download the replication data (check journal websites, author pages, or email the author)
- Map the paper's main specification to R code in your head before writing anything

### Weeks 2–3: Replicate
- Reproduce the paper's main table (usually Table 2 or 3 — the core causal estimates)
- You don't need to replicate every table. The main result is enough.
- Document any discrepancies between your results and theirs. Small differences (3rd decimal place) are normal due to software differences. Large differences mean you've made an error or used different data.

### Week 3+: Document
- Write an R Markdown document that:
  1. Summarises the paper's contribution in your own words
  2. Shows your replication code and output
  3. Compares your results to the published results
  4. Discusses what you would do differently or extend (this is embryonic PhD thinking)
- Send a brief, professional email to the author saying you replicated their paper as part of your PhD preparation and found it valuable. Academics appreciate this, and it's a way to make contact with potential supervisors.

## What "Done" Looks Like
- R Markdown replicating a published paper's main result
- Written comparison with published results
- A brief note on potential extensions (this feeds into your research proposal)
- **This completes the portfolio.** 16 projects from data wrangling to literature replication.

## Estimated Sessions: ~6
---

## Workflow Reminder

**See [WORKFLOW.md](../WORKFLOW.md) for the full two-pane workflow and sandbox convention.**

Quick version:
1. Open `16-literature-replication/analysis.Rmd` in Working Copy. This is your source of truth.
2. Open webRios alongside it.
3. Type new commands into `analysis.Rmd` → copy → paste into webRios → run.
4. Commands that create objects go in the pipeline section. Inspection commands (`glimpse`, `head`, `summary`, etc.) go in the sandbox section, commented out.
5. At the end of the session, commit and push from Working Copy. Suggested message: `"Project 16: [what you did this session]"`.

**Never copy from the webRios console back into `analysis.Rmd`.** Console output is disposable.

**At the end of the project:** create `reflection.md` using the template in `docs/tracking.md`.
