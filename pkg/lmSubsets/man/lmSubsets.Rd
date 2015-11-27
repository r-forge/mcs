\name{lmSubsets}


\alias{lmSubsets}
\alias{lmSubsets.lm}
\alias{lmSubsets.formula}
\alias{lmSubsets.default}

\alias{print.lmSubsets}
\alias{plot.lmSubsets}


\title{All-Subsets Regression}


\description{All-subsets regression for ordinary linear models.}


\usage{
lmSubsets(object, \dots)

\method{lmSubsets}{formula}(formula, \ldots, lm = FALSE)

\method{lmSubsets}{lm}(object, \dots)

\method{lmSubsets}{default}(object, y, weights = NULL, offset = NULL,
include = NULL, exclude = NULL, size = NULL, tolerance = 0,
pradius = NULL, nbest = 1, \ldots, .algo = "hbba")
}


\arguments{
  \item{object, formula}{An object of class \code{lm}, \code{formula} or
    \code{matrix}.}
  \item{y}{The response variable.}
  \item{weights, offset}{Part of the standard \code{formula} interface.}
  \item{include, exclude}{Index vectors designating variables that are
    forced in or out of the model, respectively.}
  \item{size}{Vector of subset sizes.}
  \item{tolerance}{Vector of tolerances.}
  \item{pradius}{Preordering radius.}
  \item{nbest}{Number of best subsets.}
  \item{\dots}{Ignored.}
  \item{lm}{If \code{true}, compute \code{lm} component.}
  \item{.algo}{Internal use.}
}


\details{
  The function \code{lmSubsets} computes all-variable-subsets regression
  for ordinary linear models.  The function is generic and provides
  various methods to conveniently specify the regressor and response
  variables.  The standard \code{formula} interface (see
  \code{\link[stats]{lm}}) can be used, or the information can be
  extracted from an already fitted \code{lm} object.  The regressor
  matrix and response variable can also be passed in directly.

  The method computes the \code{nbest} best subset models for every
  subset size, where the "best" models are the models with the lowest
  residual sum of squares (RSS).  The scope of the search can be limited
  to certain subset sizes by setting \code{size}.  A tolerance vector
  (expanded if necessary) may be specified to speed up the algorithm,
  where \code{tolerance[n]} is the tolerance applied to subset models of
  size \code{n}.

  By way of \code{include} and \code{exclude}, variables may be forced
  into or out of the regression, respectively.

  The function will preorder the variables to reduce execution time if
  \code{pradius > 0}.  Good execution times are usually attained for
  approximately \code{pradius = n/3} (default value), where \code{n} is
  the number of regressors after evaluation \code{include} and
  \code{exclude}.

  A set of standard extractor functions for fitted model objects is
  available for objects of class \code{"lmSubsets"}.  See
  \code{\link{methods}} for more details.
}


\value{
  An object of class \code{"lmSubsets"}, i.e. a list with the
  following components:
  \item{nobs}{Number of observations.}
  \item{nvar}{Number of variables.}
  \item{weights}{Weights vector.}
  \item{offset}{Offset component.}
  \item{include}{Included regressors.}
  \item{exclude}{Excluded regressors.}
  \item{size}{Subset sizes.}
  \item{intercept}{\code{TRUE} if regression has an intercept term;
    \code{FALSE} otherwise.}
  \item{tolerance}{Tolerance vector.}
  \item{nbest}{Number of best subsets.}
  \item{df}{Degrees of freedom.}
  \item{rss}{Residual sum of squares.}
  \item{which}{Selected variables.}
}


\references{
  Hofmann, M. and Gatu, C. and Kontoghiorghes, E. J. (2007).  Efficient
  Algorithms for Computing the Best Subset Regression Models for
  Large-Scale Problems. \emph{Computational Statistics \& Data Analysis},
  \bold{52}, 16--29.

  Gatu, C. and Kontoghiorghes, E. J.  (2006).  Branch-and-Bound
  Algorithms for Computing the Best Subset Regression Models.
  \emph{Journal of Computational and Graphical Statistics},
  \bold{15}, 139--156.
}


\seealso{\code{\link{lmSelect}}, \code{\link{summary}},
  \code{\link{methods}}.}


\examples{
## load data (with logs for relative potentials)
data("AirPollution", package = "lmSubsets")

#################
## basic usage ##
#################

## canonical example: fit best subsets
xs <- lmSubsets(mortality ~ ., data = AirPollution, nbest = 10)

## visualize RSS
plot(xs)

## summarize
summary(xs)

## plot summary
plot(summary(xs))

## forced inclusion/exclusion of variables
xs <- lmSubsets(mortality ~ ., data = AirPollution,
                include = "noncauc", exclude = "whitecollar")

summary(xs)
}


\keyword{regression}