% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dispRity.metric.R
\name{dispRity.metric}
\alias{dispRity.metric}
\alias{dimension.level3.fun}
\alias{dimension.level2.fun}
\alias{dimension.level1.fun}
\alias{variances}
\alias{ranges}
\alias{centroids}
\alias{mode.val}
\alias{ellipse.volume}
\alias{convhull.surface}
\alias{convhull.volume}
\alias{diagonal}
\alias{ancestral.dist}
\alias{pairwise.dist}
\alias{span.tree.length}
\alias{n.ball.volume}
\alias{radius}
\alias{neighbours}
\alias{displacements}
\alias{quantiles}
\alias{func.eve}
\alias{func.div}
\alias{angles}
\alias{deviations}
\title{Disparity metrics}
\usage{
dimension.level3.fun(matrix, ...)
dimension.level2.fun(matrix, ...)
dimension.level1.fun(matrix, ...)
}
\arguments{
\item{matrix}{A matrix.}

\item{...}{Optional arguments to be passed to the function. Usual optional arguments are \code{method} for specifying the method for calculating distance passed to \code{\link[vegan]{vegdist}} (e.g. \code{method = "euclidean"} - default - or \code{method = "manhattan"}) or \code{k.root} to scale the result using the eqn{kth} root. See details below for available optional arguments for each function.}
}
\description{
Different implemented disparity metrics.
}
\details{
These are inbuilt functions for calculating disparity. See \code{\link{make.metric}} for details on \code{dimension.level3.fun}, \code{dimension.level2.fun} and \code{dimension.level1.fun}.

The currently implemented dimension-level 1 metrics are:
\itemize{
  \item \code{convhull.volume}: calculates the convex hull hypervolume of a matrix (calls \code{convhulln(x, options = "FA")$vol}).
     \itemize{
         \item Both \code{convhull} functions call the \code{\link[geometry]{convhulln}} function with the \code{"FA"} option (computes total area and volume).
         \item WARNING: both \code{convhull} functions can be computationally intensive above 10 dimensions!
     }

  \item \code{convhull.surface}: calculates the convex hull hypersurface of a matrix (calls \code{convhulln(x, options = "FA")$area}).

  \item \code{diagonal}: calculates the longest distance in the ordinated space.
     \itemize{
         \item WARNING: This function is the generalisation of Pythagoras' theorem and thus \bold{works only if each dimensions are orthogonal to each other}.
     }

  \item \code{ellipse.volume}: calculates the ellipsoid volume of a matrix.
     \itemize{
         \item WARNING: this function assumes that the input matrix is ordinated and calculates the matrix' eigen values from the matrix as \code{abs(apply(var(matrix),2, sum))} (which is equivalent to \code{eigen(var(matrix))$values} but faster). These values are the correct eigen values for any matrix but differ from the ones output from \code{\link[stats]{cmdscale}} and \code{\link[ape]{pcoa}} because these later have their eigen values multiplied by the number of elements - 1 (i.e. \code{abs(apply(var(matrix),2, sum)) * nrow(matrix) -1 }). Specific eigen values can always be provided manually through \code{ellipse.volume(matrix, eigen.value = my_val)} (or \code{dispRity(matrix, metric = ellipse.volume, eigen.value = my_val)}).
     }

  \item \code{func.div}: The functional divergence (Vill'{e}ger et al. 2008): the ratio of deviation from the centroid (this is similar to \code{FD::dbFD$FDiv}).

  \item \code{func.eve}: The functional evenness (Vill'{e}ger et al. 2008): the minimal spanning tree distances evenness (this is similar to \code{FD::dbFD$FEve}). If the matrix used is not a distance matrix, the distance method can be passed using, for example \code{method = "euclidean"} (default).

  \item \code{mode.val}: calculates the modal value of a vector.

  \item \code{n.ball.volume}: calculate the volume of the minimum n-ball (if \code{sphere = TRUE}) or of the ellipsoid (if \code{sphere = FALSE}).


}

 See also \code{\link[base]{mean}}, \code{\link[stats]{median}}, \code{\link[base]{sum}} or \code{\link[base]{prod}} for commonly used summary metrics.

The currently implemented dimension-level 2 metrics are:
\itemize{
  \item \code{ancestral.dist}: calculates the distance between each tip and node and their ancestral. This function needs either (1) \code{matrix}/\code{list} from \code{\link{nodes.coordinates}}; or a \code{tree} (\code{"phylo"}) and \code{full} (\code{"logical"}) argument to calculate the node coordinates for the direct descendants (\code{full = FALSE}) or all descendants down to the root (\code{full = TRUE}). NOTE: distance is calculated as \code{"euclidean"} by default, this can be changed using the \code{method} argument.

  \item \code{angles}: calculates the angles of the main axis of variation per dimension in a \code{matrix}. The angles are calculated using the least square algorithm from the \code{\link[stats]{lm}} function. The unit of the angle can be changed through the \code{unit} argument (either \code{"degree"} (default), \code{radian} or \code{slope}) and a base angle to measure the angle from can be passed through the \code{base} argument (by default \code{base = 0}, measuring the angle from the horizontal line (not that the \code{base} argument has to be passed in the same unit as \code{unit}). When estimating the slope through \code{\link[stats]{lm}}, you can use the option \code{significant} to only consider significant slopes (\code{TRUE}) or not (\code{FALSE} - default).

  \item \code{centroids}: calculates the distance between each row and the centroid of the matrix (Lalibert'{e} 2010). This function can take an optional arguments \code{centroid} for defining the centroid (if missing (default), the centroid of the matrix is used). This argument can be either a subset of coordinates matching the matrix's dimensions (e.g. \code{c(0, 1, 2)} for a matrix with three columns) or a single value to be the coordinates of the centroid (e.g. \code{centroid = 0} will set the centroid coordinates to \code{c(0, 0, 0)} for a three dimensional matrix). NOTE: distance is calculated as \code{"euclidean"} by default, this can be changed using the \code{method} argument.

\item \code{deviations}: calculates the minimal Euclidean distance between each element in and the hyperplane (or line if 2D, or a plane if 3D). You can specify equation of hyperplane of \emph{d} dimensions in the \eqn{intercept + ax + by + ... + nd = 0} format. For example the line \eqn{y = 3x + 1} should be entered as \code{c(1, 3, -1)} or the plane \eqn{x + 2y - 3z = 44} as \code{c(44, 1, 2, -3,)}. If missing the \code{hyperplane} (default) is calculated using a least square regression using a gaussian \code{\link[stats]{glm}}. Extract arguments can be passed to \code{\link[stats]{glm}} through \code{...}. When estimating the hyperplane, you can use the option \code{significant} to only consider significant slopes (\code{TRUE}) or not (\code{FALSE} - default).
  \item \code{displacements}: calculates the ratio between the distance to the centroid (see \code{centroids} above) and the distance from a reference (by default the origin of the space). The reference can be changed through the \code{reference} argument. NOTE: distance is calculated as \code{"euclidean"} by default, this can be changed using the \code{method} argument.

  \item \code{neighbours}: calculates the distance to a neighbour (Foote 1990). By default this is the distance to the nearest neighbour (\code{which = min}) but can be set to any dimension level - 1 function (e.g. \code{which = mean} gives the distance to the most average neighbour). NOTE: distance is calculated as \code{"euclidean"} by default, this can be changed using the \code{method} argument. 

  \item \code{pairwise.dist}: calculates the pairwise distance between elements - calls \code{vegdist(matrix, method = method, diag = FALSE, upper = FALSE, ...)} (Foote 1990). The distance type can be changed via the \code{method} argument (see \code{\link[vegan]{vegdist}} - default: \code{method = "euclidean"}). This function outputs a vector of pairwise comparisons in the following order: d(A,B), d(A,C), d(B,C) for three elements A, B and C. NOTE: distance is calculated as \code{"euclidean"} by default, this can be changed using the \code{method} argument.

  \item \code{quantiles}: calculates the quantile range of each axis of the matrix. The quantile can be changed using the \code{quantile} argument (default is \code{quantile = 95}, i.e. calculating the range on each axis that includes 95\% of the data). An optional argument, \code{k.root}, can be set to \code{TRUE} to scale the ranges by using its \eqn{kth} root (where \eqn{k} are the number of dimensions). By default, \code{k.root = FALSE}.

  \item \code{radius}: calculates a distance from the centre of each axis. The \code{type} argument is the function to select which distance to calculate. By default \code{type = max} calculates the maximum distance between the elements and the centre for each axis (i.e. the radius for each dimensions)

  \item \code{ranges}: calculates the range of each axis of the matrix (Wills 2001). An optional argument, \code{k.root}, can be set to \code{TRUE} to scale the ranges by using its \eqn{kth} root (where \eqn{k} are the number of dimensions). By default, \code{k.root = FALSE}.

  \item \code{variances}: calculates the variance of each axis of the matrix (Wills 2001). This function can also take the \code{k.root} optional argument described above.

  \item \code{span.tree.length}: calculates the length of the minimum spanning tree (see \code{\link[vegan]{spantree}}). This function can get slow with big matrices. To speed it up, one can directly use distance matrices as the multidimensional space.

}

When used in the \code{\link{dispRity}} function, optional arguments are declared after the \code{metric} argument: for example
    \code{dispRity(data, metric = centroids, centroid = 0, method = "manhattan")}
}
\examples{
## A random matrix
dummy_matrix <- matrix(rnorm(90), 9, 10)

## ancestral.dist
## A random tree with node labels
rand_tree <- rtree(5) ; rand_tree$node.label <- paste0("n", 1:4)
## Adding the tip and node names to the matris
rownames(dummy_matrix) <- c(rand_tree$tip.label, rand_tree$node.label)
## Calculating the direct ancestral nodes
direct_anc_centroids <- nodes.coordinates(dummy_matrix, rand_tree, full = FALSE)
## Calculating all the ancestral nodes
all_anc_centroids <- nodes.coordinates(dummy_matrix, rand_tree, full = TRUE)
## Calculating the distances from the direct ancestral nodes
ancestral.dist(dummy_matrix, nodes.coords = direct_anc_centroids)
## Calculating the distances from all the ancestral nodes
ancestral.dist(dummy_matrix, nodes.coords = all_anc_centroids)

## angles
## The angles in degrees of each axis
angles(dummy_matrix)
## The angles in slope from the 1:1 slope (Beta = 1)
angles(dummy_matrix, unit = "slope", base = 1)

## centroids
## Distances between each row and centroid of the matrix
centroids(dummy_matrix)
## Distances between each row and an arbitrary point
centroids(dummy_matrix, centroid = c(1,2,3,4,5,6,7,8,9,10))
## Distances between each row and the origin
centroids(dummy_matrix, centroid = 0)

## deviations
## The deviations from the least square hyperplane
deviations(dummy_matrix)
## The deviations from the plane between the x and y axis
deviations(dummy_matrix, hyperplane = c(0,1,1,0,0,0,0,0,0,0,0))

## diagonal
## Matrix diagonal
diagonal(dummy_matrix) # WARNING: only valid if the dimensions are orthogonal

## displacements
## displacement ratios (from the centre)
displacements(dummy_matrix)
## displacement ratios (from an arbitrary point)
displacements(dummy_matrix, reference = c(1,2,3,4,5,6,7,8,9,10))
## displacement ratios from the centre (manhattan distance)
displacements(dummy_matrix, method = "manhattan")

## convhull.surface
## Making a matrix with more elements than dimensions (for convhull)
thinner_matrix <- matrix(rnorm(90), 18, 5)
## Convex hull hypersurface of a matrix
convhull.surface(thinner_matrix)

## convhull.volume
## Convex hull volume of a matrix
convhull.volume(thinner_matrix)

## ellipse.volume
## Ellipsoid volume of a matrix
ellipse.volume(dummy_matrix)
## Calculating the same volume with provided eigen values
ordination <- prcomp(dummy_matrix)
## Calculating the ellipsoid volume
ellipse.volume(ordination$x, eigen.value = ordination$sdev^2)

## func.div
## Functional divergence
func.div(dummy_matrix)

## func.eve
## Functional evenness
func.eve(dummy_matrix) 
## Functional evenness (based on manhattan distances)
func.eve(dummy_matrix, method = "manhattan")

## neighbours
## The nearest neighbour euclidean distances
neighbours(dummy_matrix)
## The furthest neighbour manhattan distances
neighbours(dummy_matrix, which = max, method = "manhattan")

## mode.val
## Modal value of a vector
mode.val(dummy_matrix)

## pairwise.dist
## The pairwise distance
pairwise.dist(dummy_matrix)
## The average squared pairwise distance
mean(pairwise.dist(dummy_matrix)^2)
## equal to:
geiger::disparity(data = dummy_matrix)

## quantiles
## The 95 quantiles
quantiles(dummy_matrix)
## The 100 quantiles (which are equal to the ranges)
quantiles(dummy_matrix, quantile = 100) == ranges(dummy_matrix) # All TRUE

## radius
## The maximal radius of each axis (maximum distance from centre of each axis)
radius(dummy_matrix)

## ranges
## ranges of each column in a matrix
ranges(dummy_matrix)
## ranges of each column in the matrix corrected using the kth root
ranges(dummy_matrix, k.root = TRUE)

## span.tree.length
## Minimum spanning tree length (default)
span.tree.length(dummy_matrix)
## Minimum spanning tree length from a distance matrix (faster)
distance <- as.matrix(dist(dummy_matrix))
span.tree.length(distance)
## Minimum spanning tree length based on Manhattan distance
span.tree.length(dummy_matrix, method = "manhattan")
span.tree.length(as.matrix(dist(dummy_matrix, method = "manhattan"))) # Same

## variances
## variances of a each column in the matrix
variances(dummy_matrix)
## variances of a each column in the matrix corrected using the kth root
variances(dummy_matrix, k.root = TRUE)


}
\references{
Donohue I, Petchey OL, Montoya JM, Jackson AL, McNally L, Viana M, Healy K, Lurgi M, O'Connor NE, Emmerson MC. 2013. On the dimensionality of ecological stability. Ecology letters. 16(4):421-9.

Lalibert'{e} E, Legendre P. 2010. A distance-based framework for measuring functional diversity from multiple traits. Ecology, 91(1), pp.299-305.

Vill'{e}ger S, Mason NW, Mouillot D. 2008. New multidimensional functional diversity indices for a multifaceted framework in functional ecology. Ecology. 89(8):2290-301.

Wills MA. 2001. Morphological disparity: a primer. In Fossils, phylogeny, and form (pp. 55-144). Springer, Boston, MA.

Foote, M. 1990. Nearest-neighbor analysis of trilobite morphospace. Systematic Zoology, 39(4), pp.371-382.
}
\seealso{
\code{\link{dispRity}} and \code{\link{make.metric}}.
}
\author{
Thomas Guillerme
}
