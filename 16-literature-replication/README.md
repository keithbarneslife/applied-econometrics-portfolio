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

## Saving Your Work (iPad / webRios Workflow)

> See [WORKFLOW.md](../WORKFLOW.md) for full setup instructions.

1. Write and run your code in **webRios**
2. When done, copy your code
3. In **Working Copy**, navigate to `16-literature-replication/`
4. Create `analysis.Rmd` (tap + → New File), paste your code, save
5. Commit with a message like "Project 16: [what you did this session]"
6. Push

**Files to create in this folder:**
- `analysis.Rmd` — your main analysis code
- `reflection.md` — fill in after completing the project (template in `docs/tracking.md`)
- Any exported plots (`.png`)
