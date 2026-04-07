# Adaptive Progress Tracking

This portfolio is not a fixed syllabus. It is a learning system with a built-in feedback loop. The 16 projects define the trajectory (what methods to learn, in what order). The implementation details (which dataset, how many sessions, what to emphasise) adapt based on evidence about how the learning actually goes.

## After Every Project: Quick Reflection (5 minutes)

After completing each project, add a `reflection.md` file to that project's folder recording:

1. **Actual sessions taken** vs planned — Faster or slower? By how much?
2. **What was harder than expected?** — Be specific. Was it the R syntax, the data wrangling, the theory, or the conceptual step of connecting theory to code?
3. **What was easier than expected?** — This reveals what existing economics training still provides, even when rusty.
4. **Difficulty category** — Where did the friction come from?
   - 🔧 **R syntax** — understood the method but couldn't make R do it
   - 📊 **Data wrangling** — the analysis was clear but the data was messy
   - 📐 **Maths gap** — couldn't follow the formal derivation
   - 💡 **Conceptual** — wasn't sure *why* this method answers the question
5. **Confidence rating (1–5)** on the method this project covered:
   - 1 = Could not explain it to someone else
   - 2 = Understand the idea but would struggle to implement independently
   - 3 = Can implement with reference materials
   - 4 = Can implement and explain from memory
   - 5 = Could teach it to a colleague

### Reflection Template

Copy this into each project's `reflection.md`:

```markdown
# Project [N] Reflection

**Planned sessions:** ~[X]
**Actual sessions:** [Y]

## What was harder than expected?

[Specific description]

## What was easier than expected?

[Specific description]

## Primary difficulty category

[🔧 R syntax / 📊 Data wrangling / 📐 Maths gap / 💡 Conceptual]

## Confidence rating: [1-5]

## Notes for future projects

[Anything that should inform how the next project is approached]
```

---

## At Every Phase Boundary: Calibration Review (30 minutes)

At the end of Phase 1 (after Project 5), Phase 2a (after Project 8), Phase 2b (after Project 11), and Phase 2c/d (after Project 14), create a `calibration-review.md` in a `reviews/` folder.

### Step 1: Review the Pattern of Difficulty Categories

Look across the reflections from the projects just completed. Is there a consistent bottleneck?

- If 🔧 **R syntax** dominates → add an extra R-focused practice session before the next phase. Consider working through additional R4DS chapters or doing a small side exercise.
- If 📐 **Maths gap** keeps appearing → spend more time on the [maths parallel thread](maths-foundations.md) before proceeding. The maths is there to make the theory legible; if it's not working, the theory sections of future projects won't land.
- If 💡 **Conceptual** is the problem → re-read the relevant chapters of *The Effect* before proceeding. Consider working through the chapter exercises, not just reading.
- If 📊 **Data wrangling** dominates → choose cleaner datasets for the next phase's projects (e.g. use R package built-in data rather than raw downloads).

### Step 2: Decide Whether the Next Phase's Projects Need Adjusting

The *method* stays the same (you still learn DiD, IV, etc.). What can change:

- **Dataset complexity** — if data wrangling dominated the previous phase, choose a cleaner dataset for the next replication. If it was easy, choose something messier that stretches you.
- **Replication paper difficulty** — if you breezed through Card & Krueger, pick a more challenging IV replication. If it was a struggle, pick a cleaner example for the IV textbook project.
- **Bridging sessions** — if you rated a method 1–2, add 1–2 extra practice sessions before moving on (e.g., another simple FE regression on a different dataset before tackling the MSc reimplementation).
- **Maths emphasis** — if maths gaps are accumulating, allocate more sessions to the parallel thread before the next phase.

### Step 3: Check Pace

Are you ahead or behind the rough timeline? If behind, consider whether any Phase 3 scope can flex (e.g., doing one original project instead of two, or choosing a simpler replication). The first 14 projects are non-negotiable for building the core toolkit; Projects 15–16 can be scoped to available time.

### Calibration Review Template

```markdown
# Phase [X] Calibration Review

**Projects completed:** [N]–[M]
**Date:** [date]

## Difficulty pattern across this phase

| Project | Primary difficulty | Confidence |
|---------|-------------------|------------|
| [N]     | [category]        | [1-5]      |
| [N+1]   | [category]        | [1-5]      |
| ...     | ...               | ...        |

## Consistent bottleneck (if any)

[Description of the pattern]

## Adjustments for next phase

- [ ] Dataset complexity: [simpler / same / harder]
- [ ] Replication paper: [specific choice and why]
- [ ] Bridging sessions needed: [yes/no, on what]
- [ ] Maths thread emphasis: [increase / maintain / decrease]

## Pace check

[Ahead / on track / behind. Any scope adjustments needed for Phase 3?]
```

---

## The Rule: Aims Fixed, Implementation Flexible

### What never changes:
- The method each project covers
- The phase structure and sequencing
- The requirement to cover all four causal inference methods (FE, DiD, IV, RD)
- The overall aim of 16 completed portfolio projects

### What adapts:
- Which specific dataset or paper is used
- How many sessions are allocated
- Whether bridging exercises are added between projects
- How much time is spent on the maths thread
- The order within a phase (e.g., if struggling with FE, do an extra FE exercise before moving to DiD — but still do both)

This means the portfolio is not a rigid curriculum that fails on contact with reality. It is a learning system that responds to evidence about how you actually learn, while maintaining the scope and ambition of the original design.
