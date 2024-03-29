% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PoolReg.R
\name{PoolReg}
\alias{PoolReg}
\title{Frequentist Mixed or Fixed Effect Logistic Regression with Presence/Absence
Tests on Pooled Samples}
\usage{
PoolReg(formula, data, poolSize, link = "logit", ...)
}
\arguments{
\item{formula}{A \code{formula} of the kind used to define models in
\code{lme4}, which are generalisation of the formulae used in \code{lm} or
\code{glm} that allow for random/group effects. The left-hand side of the
formula should be the name of column in \code{data} with the result of the
test on the pooled samples. The result must be encoded with 1 indicating a
positive test result and 0 indicating a negative test result.}

\item{data}{A \code{data.frame} with one row for each pooled sampled and
columns for the size of the pool (i.e. the number of specimens / isolates /
insects pooled to make that particular pool), the result of the test of the
pool and any number of columns to be used as the dependent variables in the
logistic regression}

\item{poolSize}{The name of the column with number of
specimens/isolates/insects in each pool}

\item{link}{link function. There are two options `'logit'` (logistic
regression, the default) and `'cloglog'` (complementary log log
regression).}

\item{...}{Arguments to be passed on to \code{stats::glm} or \code{lme4::glmer}
e.g. weights}
}
\value{
An object of class \code{glmerMod} (or \code{glm} if there are no
  random/group effects)
}
\description{
It can be useful to do mixed effects logistic regression on the
presence/absence results from pooled samples, however one must adjust for the
size of each pool to correctly identify trends and associations. This can
done by using a custom link function [PoolTestR::PoolLink()], defined in this
package, in conjunction with using \code{glm} from the \code{stats} package
(fixed effect models) or \code{glmer} from the \code{lme4} package (mixed
effect models).
}
\examples{
# Perform logistic-type regression modelling for a synthetic dataset consisting
# of pools (sizes 1, 5, or 10) taken from 4 different regions and 3 different
# years. Within each region specimens are collected at 4 different villages,
# and within each village specimens are collected at 8 different sites.


### Models in a frequentist framework
#ignoring hierarchical sampling frame within each region
Mod <- PoolReg(Result ~ Region + Year,
               data = SimpleExampleData,
               poolSize = NumInPool)
summary(Mod)

#accounting hierarchical sampling frame within each region
HierMod <- PoolReg(Result ~ Region + Year + (1|Village/Site),
                   data = SimpleExampleData,
                   poolSize = NumInPool)
summary(HierMod)
#Extract fitted prevalence for each combination of region and year and then at
#each level of the hierarchical sampling frame (i.e. for each village in each
#region and  each site in each village)
getPrevalence(HierMod)


### Models in a Bayesian framework with default (non-informative) priors
#ignoring hierarchical sampling frame within each region
\donttest{
  BayesMod <- PoolRegBayes(Result ~ Region + Year,
                           data = SimpleExampleData,
                           poolSize = NumInPool)
  summary(BayesMod)
  getPrevalence(BayesMod) #Extract fitted prevalence for each combination of region and year

  #accounting hierarchical sampling frame within each region
  BayesHierMod <- PoolRegBayes(Result ~ Region + Year + (1|Village/Site),
                               data = SimpleExampleData,
                               poolSize = NumInPool)
  summary(BayesHierMod)
  getPrevalence(BayesHierMod)
}

### Calculate adjusted estimates of prevalence
# We use the same function for all four models, but the outputs are slightly different

# Extract fitted prevalence for each combination of region and year
getPrevalence(Mod)
\donttest{
  getPrevalence(BayesMod)
}

#Extract fitted prevalence for each combination of region and year and then at
#each level of the hierarchical sampling frame (i.e. for each village in each
#region and  each site in each village)
getPrevalence(HierMod)
\donttest{
  getPrevalence(BayesHierMod)
}

# You can also use getPrevalence to predict at prevalence for other values of
# the covariates (e.g. predict prevalence in year 4)

#Making a data frame containing data make predict on
DataFuture <- unique(data.frame(Region = SimpleExampleData$Region,
                                Village = SimpleExampleData$Village,
                                Site = SimpleExampleData$Site,
                                Year = 4))

getPrevalence(Mod, newdata = DataFuture)
getPrevalence(HierMod, newdata = DataFuture)
\donttest{
  getPrevalence(BayesMod, newdata = DataFuture)
  getPrevalence(BayesHierMod, newdata = DataFuture)
}
}
\seealso{
\code{\link{getPrevalence}},
  \code{\link{PoolRegBayes}}
}
