Here is the **generated `README.md` (GitHub-preview ready)** corresponding to your `ProgressiveSample` package and the `.Rd` documentation.
You can **copy-paste this directly into `README.md`** in your repository.

---

```md
# ProgressiveSample

An R package for generating **progressively Type-II censored samples** from
continuous lifetime distributions using a **quantile-based simulation approach**.

The package is intended for simulation studies in **reliability analysis,
life-testing experiments, and survival analysis** under progressive censoring
schemes.

---

## Overview

In a progressive Type-II censoring experiment, a total of `N` units are placed
on test, but only `M` failure times are observed. After each observed failure,
a predetermined number of surviving units are removed from the experiment
according to a specified censoring scheme.

The `ProgressiveSample()` function implements a general algorithm for simulating
progressively censored samples from any lifetime distribution whose
**quantile function** is available.

---

## Progressive Censoring Scheme

Let:

- `N` be the total number of units placed on test  
- `M` be the number of observed failures  
- `R = (R1, R2, …, RM)` be the progressive censoring scheme, where `Ri` denotes
  the number of surviving units removed immediately after the `i`-th failure  

The censoring scheme must satisfy:

```

sum(R) + M = N

````

---

## Installation

Install the development version from GitHub:

```r
# install.packages("devtools")
devtools::install_github("ksinghiit/ProgressiveSample")
````

---

## Function Description

### `ProgressiveSample()`

Generates a progressively Type-II censored sample using the inverse distribution
(quantile) method.

**Usage**

```r
ProgressiveSample(qfunc, alpha, beta, N, M, R)
```

**Arguments**

* `qfunc`: Quantile function of the lifetime distribution
* `alpha`: Shape parameter
* `beta`: Scale parameter
* `N`: Total number of units placed on test
* `M`: Number of observed failures
* `R`: Progressive censoring scheme vector of length `M`

**Value**

Returns a numeric vector of length `M` containing the observed failure times.

---

## Example: Weibull Distribution

### Weibull Quantile Function

The Weibull quantile function is given by

[
F^{-1}(u) = \left(\frac{-\log(1-u)}{\beta}\right)^{1/\alpha}.
]

```r
q_weibull <- function(u, alpha, beta) {
  ((-log(1 - u)) / beta)^(1 / alpha)
}
```

---

### Generate a Progressively Censored Sample

```r
# Total and effective sample sizes
N <- 50
M <- 35

# True parameter values
alpha <- 1.7
beta  <- 1.5

# Progressive censoring scheme
R <- c(rep(0, M - 1), N - M)

# Generate progressively censored sample
xsamp <- ProgressiveSample(
  qfunc = q_weibull,
  alpha = alpha,
  beta  = beta,
  N     = N,
  M     = M,
  R     = R
)

xsamp
```

---

## Reference

Balakrishnan, N. and Aggarwala, R. (2000).
*Progressive Censoring: Theory, Methods, and Applications*.
Birkhäuser, Boston.

---
