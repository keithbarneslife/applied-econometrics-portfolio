# Maths Foundations — Parallel Thread

This is not a separate phase. It runs alongside the main project sequence, covering the specific mathematical tools needed *just before* the project that requires them. The goal is not to complete a maths course but to reactivate the language that econometric theory is written in.

## Recommended Resources

- **Gill, J. (2006). *Essential Mathematics for Political and Social Research*.** Cambridge UP. Covers exactly what a social scientist returning to quantitative work needs: probability, linear algebra, calculus of several variables. Targeted and concise.
- **Wooldridge Appendices.** The maths appendices in *Introductory Econometrics: A Modern Approach* cover summation, probability, and basic matrix algebra more concisely. A free alternative if you already own Wooldridge.

## Alongside Phase 1 (Projects 1–5): Probability and Statistics Foundations

These topics are needed to understand OLS properly — not just as a command in R but as a mathematical result.

### Summation Notation

The Σ operator, its properties (linearity, pulling constants out). You cannot read a single econometrics proof without this.

### Expected Values

E[X] as a population concept. Key results:
- Linearity of expectations: E[aX + bY] = aE[X] + bE[Y]
- Law of iterated expectations: E[Y] = E[E[Y|X]]

The law of iterated expectations is *the* key result underpinning OLS: the conditional expectation function E[Y|X] is what OLS estimates.

### Variance and Covariance

- Var(X) = E[X²] − (E[X])²
- Cov(X,Y) = E[XY] − E[X]E[Y]
- Var(aX + bY) = a²Var(X) + b²Var(Y) + 2abCov(X,Y)

The OLS slope coefficient is literally β = Cov(X,Y) / Var(X). Understanding this identity means understanding what OLS does.

### Probability Distributions

Normal, t, chi-squared, F. You don't need to derive them; you need to know what each one governs in the context of hypothesis testing. Why do we use t-tests rather than z-tests? (Because we estimate the variance.)

### How to Study This

One 20-minute session per concept. Write out the key identities by hand (not in R). Then verify them with a quick R simulation: generate random data, compute E[X] and Var(X) both by formula and with `mean()` / `var()`, and confirm they match. This bridges the maths to the code.

```r
# Example: verify Var(X) = E[X²] − (E[X])²
set.seed(42)
x <- rnorm(10000, mean = 5, sd = 2)
var(x)                          # R's built-in
mean(x^2) - mean(x)^2          # from the identity
# These should be approximately equal
```

---

## Alongside Phase 2a (Projects 6–8): Matrix Algebra Basics

These topics are needed to read OLS in matrix form, which is how Wooldridge and any PhD-level text presents it.

### Vectors and Matrices

What they are, addition, scalar multiplication.

### Matrix Multiplication

AB ≠ BA. Dimensions must conform: (m × n) times (n × p) gives (m × p).

### Transpose and Inverse

X' (transpose), X⁻¹ (inverse). (X'X)⁻¹ exists when X has full column rank.

### OLS in Matrix Form

β̂ = (X'X)⁻¹X'y

This is the same OLS you already know, but expressed for multiple regressors simultaneously. The variance of β̂ is σ²(X'X)⁻¹ under homoskedasticity.

### How to Study This

Work through in R using small matrices (3×2, 4×3). Create X and y, compute the OLS estimator manually, and confirm it matches `lm()` output.

```r
# OLS in matrix form
set.seed(42)
n <- 100
X <- cbind(1, rnorm(n), rnorm(n))   # intercept + 2 regressors
beta_true <- c(2, 0.5, -1.3)
y <- X %*% beta_true + rnorm(n)

# Manual computation
beta_hat <- solve(t(X) %*% X) %*% t(X) %*% y

# Compare to lm()
coef(lm(y ~ X[,2] + X[,3]))

# These should match
```

---

## Alongside Phase 2c (Projects 12–13): Asymptotic Theory Intuition

These concepts are needed to understand IV and to read *Mostly Harmless Econometrics*.

### Consistency

β̂ converges in probability to β as n → ∞. This is different from unbiasedness, which is a finite-sample property. OLS is both unbiased and consistent (under the standard assumptions). IV is consistent but generally biased in finite samples.

### Probability Limits

The formal notation: plim(β̂\_OLS) = β + Cov(X,ε) / Var(X).

If Cov(X,ε) ≠ 0 (endogeneity), OLS is inconsistent — it converges to the wrong value no matter how large your sample. This is *why* we need IV.

### Central Limit Theorem

√n(β̂ − β) → N(0, V). This is why standard errors shrink with √n and why t-statistics work in large samples even without normality.

### How to Study This

Monte Carlo simulation in R. Generate data with a known β, estimate it 1,000 times with increasing n, and plot the distribution of β̂. Watch it converge and become normal. Then introduce endogeneity (correlate X with ε) and watch OLS fail while IV converges to the truth.

```r
# Monte Carlo: OLS consistency
set.seed(42)
beta_true <- 1.5
results <- data.frame(n = integer(), beta_hat = numeric())

for (n in c(50, 200, 1000, 5000)) {
  for (i in 1:500) {
    x <- rnorm(n)
    y <- beta_true * x + rnorm(n)
    results <- rbind(results, data.frame(n = n, beta_hat = coef(lm(y ~ x))[2]))
  }
}

library(ggplot2)
ggplot(results, aes(x = beta_hat)) +
  geom_histogram(bins = 40) +
  facet_wrap(~n, scales = "free_y") +
  geom_vline(xintercept = beta_true, colour = "red") +
  labs(title = "OLS converges to the true value as n grows")
```
