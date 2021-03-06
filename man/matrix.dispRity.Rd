% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dispRity.utilities.R
\name{matrix.dispRity}
\alias{matrix.dispRity}
\alias{fetch.matrix}
\title{Fetching a matrix from a \code{dispRity} object.}
\usage{
matrix.dispRity(data, subsets, rarefaction, bootstrap, matrix = 1)
}
\arguments{
\item{data}{A \code{dispRity} object.}

\item{subsets}{Optional, a \code{numeric} value to select subsets.}

\item{rarefaction}{Optional, a \code{numeric} value to select the rarefaction level (\code{0} is no rarefaction).}

\item{bootstrap}{Optional, a \code{numeric} value to select a specific bootstrap draw (\code{0} is no bootstrap).}

\item{matrix}{A \code{numeric} value of which matrix to select (default is \code{1}).}
}
\description{
Fetching a specific matrix from a \code{dispRity} object.
}
\examples{
## Load the disparity data based on Beck & Lee 2014
data(disparity)

## To get the original matrix
matrix.dispRity(disparity)

## To get the un-bootstrapped matrix from the subset called "80"
matrix.dispRity(disparity, subsets = "80")

## To get the 52nd bootstrap draw of the second rarefaction level (15) of the
## same subset
matrix.dispRity(disparity, subsets = 2, rarefaction = 2, bootstrap = 52)

}
\author{
Thomas Guillerme
}
