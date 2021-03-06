% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/HierPoolPrev.R
\name{HierPoolPrev}
\alias{HierPoolPrev}
\title{Estimation of prevalence based on presence/absence tests on pooled samples in
a hierarchical sampling frame}
\usage{
HierPoolPrev(
  data,
  result,
  poolSize,
  hierarchy,
  ...,
  prior.alpha = 0.5,
  prior.beta = 0.5,
  prior.absent = 0,
  alpha = 0.05,
  verbose = FALSE,
  cores = NULL
)
}
\arguments{
\item{data}{A \code{data.frame} with one row for each pooled sampled and
columns for the size of the pool (i.e. the number of specimens / isolates /
insects pooled to make that particular pool), the result of the test of the
pool. It may also contain additional columns with additional information
(e.g. location where pool was taken) which can optionally be used for
splitting the data into smaller groups and calculating prevalence by group
(e.g. calculating prevalence for each location)}

\item{result}{The name of column with the result of each test on each pooled
sample. The result must be stored with 1 indicating a positive test result
and 0 indicating a negative test result.}

\item{poolSize}{The name of the column with number of
specimens/isolates/insects in each pool}

\item{hierarchy}{The name of column(s) indicating the group membership. In a
nested sampling design with multiple levels of grouping the lower-level
groups must have names/numbers that differentiate them from all other
groups at the same level. E.g. If sampling was performed at 200 sites
across 10 villages (20 site per village), then there should be 200 unique
names for the sites. If, for instance, the sites are instead numbered 1 to
20 within each village, the village identifier (e.g. A, B, C...) should be
combined with the site number to create unique identifiers for each site
(e.g. A-1, A-2... for sites in village A and B-1, B-2... for the sites in
village B etc.)}

\item{...}{Optional name(s) of columns with variables to stratify the data by.
If omitted the complete dataset is used to estimate a single prevalence.
If included prevalence is estimated separately for each group defined by
these columns}

\item{prior.alpha, prior.beta, prior.absent}{The prior on the prevalence in
each group takes the form of beta distribution (with parameters alpha and
beta). The default is \code{prior.alpha = prior.beta = 1/2} i.e. the
uninformative "Jeffrey's" prior. Another popular uninformative choice is
\code{prior.alpha = prior.beta = 1}, i.e. a uniform prior.
\code{prior.absent} is included for consistency with \code{PoolPrev}, but
is currently ignored}

\item{alpha}{The confidence level to be used for the confidence and credible
intervals. Defaults to 0.5\% (i.e. 95\% intervals)}

\item{verbose}{Logical indicating whether to print progress to screen.
Defaults to false (no printing to screen)}

\item{cores}{The number of CPU cores to be used. By default one core is used}
}
\value{
A \code{data.frame} with columns: \itemize{ \item{\code{PrevMLE} (the
  Maximum Likelihood Estimate of prevalence)} \item{\code{CILow} and
  \code{CIHigh} (Lower and Upper Confidence intervals using the Likelihood
  Ratio method)} \item{\code{Bayesian Posterior Expectation}}
  \item{\code{CrILow} and \code{CrIHigh}} \item{\code{Number of Pools}}
  \item{\code{Number Positive}} } If grouping variables are provided in
  \code{...} there will be an additional column for each stratifying variable.
  When there are no stratifying variables (supplied in \code{...}) then the
  dataframe has only one row with the prevalence estimates for the whole
  dataset. When stratifying variables are supplied, then there is a separate row
  for each group.
}
\description{
Estimation of prevalence based on presence/absence tests on pooled samples in
a hierarchical sampling frame
}
\examples{
# Calculate prevalence for a synthetic dataset consisting of pools (sizes 1, 5,
# or 10) taken from 4 different regions and 3 different years. Within each
# region specimens are collected at 4 different villages, and within each
# village specimens are collected at 8 different sites.

\donttest{
  #Prevalence for each combination of region and year:
  #ignoring hierarchical sampling frame within each region
  PoolPrev(SimpleExampleData, Result, NumInPool, Region, Year)
  #accounting hierarchical sampling frame within each region
  HierPoolPrev(SimpleExampleData, Result, NumInPool, c("Village","Site"), Region, Year)
}


}
