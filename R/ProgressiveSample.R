# -------------------------
# Progressive Type-II censored sample generator
#
# Generates a progressively Type-II censored sample from a continuous
# lifetime distribution using a quantile-based simulation approach.
#
# qfunc : Quantile function F^{-1}(u; alpha, beta) of the lifetime distribution
# alpha : Shape parameter of the distribution
# beta  : Scale parameter of the distribution
# N     : Total number of units placed on test
# M     : Number of observed failures
# R     : Progressive censoring scheme of length M, where R[i] denotes
#         the number of surviving units removed after the i-th failure
# -------------------------

ProgressiveSample <- function(qfunc, alpha, beta, N, M, R) {

  if (length(R) != M) {
    stop("Length of R must be equal to M.")
  }

  # Step 1: generate uniform variables
  w  <- runif(M)
  v  <- numeric(M)
  u  <- numeric(M)

  # Step 2: construct v_i as in the progressive censoring algorithm
  for (i in 1:M) {
    denom   <- i + sum(R[(M - i + 1):M])
    v[i]    <- w[i]^(1 / denom)
  }

  # Step 3: construct u_i from v_i
  for (i in 1:M) {
    u[i] <- 1 - prod(v[(M - i + 1):M])
  }

  # Step 4: transform uniforms to Weibull via quantile function
  x <- qfunc(u, alpha, beta)
  return(x)
}
