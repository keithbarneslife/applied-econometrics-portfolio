# How to Use This Portfolio

## Setup (once)

**iPad:**
- Install **Working Copy** (git client) and **webRios** (R environment)
- In Working Copy, clone `https://github.com/keithbarneslife/applied-econometrics-portfolio.git`
- In webRios, run the install command from `setup.R` at the repo root

**Or Mac:** clone the repo, open in RStudio, install the same packages.

---

## Every Session (iPad)

Open Split View: Working Copy on the left, webRios on the right.

1. **Start.** In Working Copy, open the project's `analysis.R`, select all, copy. Paste into webRios, run. You're back where you left off.

2. **Work.** Write new commands in `analysis.R` (the Working Copy pane). Copy each one over to webRios to run. If it works, leave it. If it errors, fix it in the file.

3. **End.** In Working Copy, tap Commit → message → Push.

---

## Two rules for `analysis.R`

- Commands with `<-` (create objects) stay in the file.
- Inspection commands (`glimpse()`, `head()`, `summary()`) — put a `#` in front after you've looked at the output, or delete the line. They shouldn't run next time.

That's it. Never copy from the webRios console back into the file.

---

## Reflection and Phase Reviews

- When a project is complete, add `reflection.md` using the template in `docs/tracking.md`.
- After Projects 5, 8, 11, and 14, do a calibration review in `reviews/`.

---

## Maths Thread

Short sections in `docs/maths-foundations.md` to work through before:
- Phase 1 (Projects 1–5): expected values, variance
- Phase 2a (Projects 6–8): matrix algebra
- Phase 2c (Projects 12–13): asymptotic theory

---

## When to Use Claude

Debugging, theory discussion, calibration reviews, PhD application work. You don't need AI for the core workflow.
