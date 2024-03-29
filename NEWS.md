# PoolTestR v0.1.3 (Release date: 2022-07-XX)
This is patch to fix a bug affecting `PoolPrev`. The bug affected the maximum likelihood estimates (MLE) and likelihood ratio confidence intervals (LR-CIs) of prevalence when the default Jeffrey's prior was being used. The bug would usually make the MLE and LR-CIs much closer to the Bayesian estimates than they should have been. As both sets of estimates are valid, the results will still have been approximately correct.

This patch also includes an option, `replicate.poolscreen` (default to `FALSE`), for `PoolPrev`. This options changes the way the likelihood ratio confidence intervals are calculated. With `replicate.poolscreen = TRUE` PoolPrev will more closely reproduce the results produced by Poolscreen. We believe that our implementation of these intervals is more correct so would recommend that users continue to use the default (`replicate.poolscreen = FALSE`), but this option may be helpful for those who are trying to compare results across the two programs.

# PoolTestR v0.1.2 (Release date: 2021-07-XX)
We have published a paper about PoolTestR in *Environmental Modelling and Software* now available at https://doi.org/10.1016/j.envsoft.2021.105158. If you find this package useful, please let us know and/or cite our paper!

A couple bug fixes:
* corrections to the Jeffrey's prior in PoolPrev
* improved numerical stability of hierarchical models -- previous implementation was causing initialisation of MCMC to fail in some edge cases

A few improvements:
* Allow user to specify level of confidence intervals and credible intervals
* option for getPrevalence to return the posterior median as the point estimate (instead of the posterior mean) for Bayesian models with with PoolRegBayes
* Implement PoolRegBayes with a logit link function as custom family in brms. This allows for better post-processing for the results of PoolRegBayes -- e.g. simulating from the model, leave-one-out cross-validation, posterior predictive checks. see brms for details
* Allow users to pass more control variables to MCMC sampling routines across PoolRegBayes, HierPoolPrev, and PoolPrev
* Allows users to specify the scale parameter for the half-Cauchy hyper-prior or the standard deviations of the random effect terms in HierPoolPrev. Also reduced the default value of this hyperprior from 25 (very diffuse) to 2 (weakly informative).
This is now very comparable to the equivalent default hyper-prior for brms models including those fit using PoolRegBayes (i.e. a half t distribution three degrees of freedom )

# PoolTestR v0.1.1 (Release date: 2021-02-13)

Minor patch so that the package works across more platforms (namely solaris)


# PoolTestR v0.1.0 (Release date: 2021-02-08)

This is our first official release! Please see the github site (https://github.com/AngusMcLure/PoolTestR#pooltestr) for a basic crash course on using the package. An upcoming (open access) journal article will go into further detail. A preprint can be accessed at https://arxiv.org/abs/2012.05405. I'll post a link to the article when published.
