#' @title dispRity object plotting
#'
#' @description Plots a \code{dispRity} object.
#'
#' @param x A \code{dispRity} object.
#' @param ... Any optional arguments to be passed to \code{\link[graphics]{plot}}.
#' @param type Either \code{"continuous"}, \code{"box"}, \code{"line"}, \code{"polygon"} or \code{"space"}. When unspecified, if no disparity was calculated, \code{"preview"} is used. If disparity was calculated, \code{"continuous"} is used for \code{\link{chrono.subsets}} and \code{"box"} for \code{\link{custom.subsets}}. See details.
#' @param quantiles The quantiles to display (default is \code{quantiles = c(50, 95)}; is ignored if the \code{dispRity} object is not bootstrapped).
#' @param cent.tend A function for summarising the bootstrapped disparity values (default is \code{\link[stats]{median}}).
#' @param rarefaction Either \code{NULL} (default) or \code{FALSE} for not using the rarefaction scores; a \code{numeric} value of the level of rarefaction to plot; or \code{TRUE} for plotting the rarefaction curves.
#' @param elements \code{logical} whether to plot the number of elements per subsets.
#' @param ylim Optional, two \code{numeric} values for the range of the y axis.
#' @param xlab Optional, a \code{character} string for the caption of the x axis.
#' @param ylab Optional, one or two (if \code{elements = TRUE}) \code{character} string(s) for the caption of the y axis.
#' @param col Optional, some \code{character} string(s) for the colour of the plot.
#' @param chrono.subsets \code{logical} whether to handle continuous data from the \code{chrono.subsets} function as time (in Ma). When this option is set to TRUE for other \code{type} options, the names of the subsets are used for the x axis labels.
#' @param observed \code{logical} whether to add the observed values on the plot as crosses (default is \code{FALSE}) or a \code{list} of any of the graphical arguments \code{"col"}, \code{"pch"} and/or \code{"cex"}.
#' @param add \code{logical} whether to add the new plot an existing one (default is \code{FALSE}).
#' @param density the density of shading lines to be passed to \code{\link[graphics]{polygon}}. Is ignored if \code{type = "box"} or \code{type = "line"}.
#' @param element.pch optional, if \code{elements = TRUE}, the point type to represent them (default are squares: \code{element.pch = 15}).
#' @param dimensions optional, if \code{type = "preview"}, a pair of \code{"numeric"} values of which dimensions to display (default is \code{c(1,2)}).
#' @param matrix optional, if \code{type = "preview"}, the \code{"numeric"} value of which matrix to display (default is \code{1}).
# ' @param significance when plotting a \code{\link{sequential.test}} from a distribution, which data to use for considering slope significance. Can be either \code{"cent.tend"} for using the central tendency or a \code{numeric} value corresponding to which quantile to use (e.g. \code{significance = 4} will use the 4th quantile for the level of significance ; default = \code{"cent.tend"}).
# ' @param lines.args when plotting a \code{\link{sequential.test}}, a list of arguments to pass to \code{\link[graphics]{lines}} (default = \code{NULL}).
# ' @param token.args when plotting a \code{\link{sequential.test}}, a list of arguments to pass to \code{\link[graphics]{text}} for plotting tokens (see details; default = \code{NULL}).
#' @param nclass when plotting a \code{\link{null.test}} the number of \code{nclass} argument to be passed to \code{\link[graphics]{hist}} (default = \code{10}).
#' @param coeff when plotting a \code{\link{null.test}} the coefficient for the magnitude of the graph (see \code{\link[ade4]{randtest}}; default = \code{1}).
#'
#' @details
#' The different \code{type} arguments are:
#' \itemize{
#'   \item \code{"continuous"}: plots the results as a continuous line.
#'   \item \code{"box"}: plots the results as discrete box plots (note that this option ignores the user set quantiles and central tendency).
#'   \item \code{"line"}: plots the results as discrete vertical lines with the user's set quantiles and central tendency.
#'   \item \code{"polygon"}: identical as \code{"line"} but using polygons rather than vertical lines.
#'   \item \code{"preview"}: plots two dimensional preview of the space (default is \code{c(1,2)}). WARNING: the plotted dimensions might not be representative of the full multi-dimensional space!
#' }
#' 
#TG: The following is from sequential.test (not implemented yet)
# The \code{token.args} argument intakes a list of arguments to be passed to \code{\link[graphics]{text}} for plotting the significance tokens. The plotted tokens are the standard p-value significance tokens from R:
# \code{0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1}
# Additionally, the \code{float} argument can be used for setting the height of the tokens compared to the slopes. For example one can use \code{token.args = list(float = 0.3, col = "blue", cex = 0.5))} for plotting blue tokens 50% smaller than normal and 30% higher than the slope.
#'
#' @examples
#' ## Load the disparity data based on Beck & Lee 2014
#' data(disparity)
#' 
#' ## Discrete plotting
#' plot(disparity, type = "box")
#' 
#' ## Using polygons rather than boxes (quantiles and central tendency can be
#' ## set by the user)
#' plot(disparity, type = "polygon", quantiles = c(10, 50, 95),
#'      cent.tend = mean)
#' 
#' ## Using different options
#' plot(disparity, type = "line", elements = TRUE, ylim = c(0, 5),
#'      xlab = ("Time (Ma)"), ylab = "disparity")
#' 
#' ## Continuous plotting (all default options)
#' plot(disparity, type = "continuous")
#' 
#' ## Using different options (with non time.slicing option)
#' plot(disparity, type = "continuous", chrono.subsets = FALSE,
#'      elements = TRUE, col = c("red", "orange", "yellow"))
#' 
#' ## Rarefactions plots
#' plot(disparity, rarefaction = TRUE)
#' 
#' ## Observed data
#' plot(disparity, observed = TRUE)
#'
#' ## Observed data with graphical details
#' plot(disparity, observed = list("pch" = 19, col = "blue", cex = 4))
#' 
#' \dontrun{
#' ## Geoscale plots
#' require(geoscale)
#' 
#' ## Converting the data into a list
#' data_obs <- extract.dispRity(disparity, observed = TRUE)
#' data_distribution <- extract.dispRity(disparity, observed = FALSE)
#' ## Removing one list level
#' data_distribution <- unlist(data_distribution, recursive = FALSE)
#' data_obs <- as.vector(data_obs)
#' 
#' ## Getting the ages
#' ages <- as.numeric(names(disparity$subsets))
#' 
#' ## Plotting the results median
#' geoscalePlot(ages, data_obs, boxes = "Age", data.lim = c(1.5, 2), type = "l")
#'
#' ## Plotting the results distribution
#' geoscaleBox(data_distribution, ages, boxes = "Age", data.lim = c(1.5, 2))
#' }
#' 
#' 
#' @seealso \code{\link{dispRity}}, \code{\link{summary.dispRity}}, \code{\link{pair.plot}}.
#'
#' @author Thomas Guillerme

# #Testing
# source("sanitizing.R")
# source("plot.dispRity_fun.R")
# data(BeckLee_mat50)
# data(BeckLee_tree)
# data <- custom.subsets(BeckLee_mat50, crown.stem(BeckLee_tree, inc.nodes = FALSE))
# type = "preview"

# data <- customised_subsets
# quantiles=c(50, 95)
# cent.tend=median
# rarefaction = NULL
# elements = FALSE
# chrono.subsets = FALSE
# observed = FALSE
# add = FALSE
# density = NULL
# nclass = 10
# coeff = 1


# data(disparity)
# data <- disparity
# type = "line"
# ewments = TRUE
# ylim = c(0, 5)
# xlab = ("Time (Ma)")
# ylab = "disparity"

plot.dispRity <- function(x, ..., type, quantiles = c(50, 95), cent.tend = median, rarefaction = NULL, elements = FALSE, ylim, xlab, ylab, col, chrono.subsets = TRUE, observed = FALSE, add = FALSE, density = NULL, element.pch = 15, dimensions = c(1,2), nclass = 10, coeff = 1, matrix = 1){ #significance="cent.tend", lines.args=NULL, token.args=NULL

    data <- x
    match_call <- match.call()
    dots <- list(...)

    #SANITIZING
    #DATA
    if(length(class(data)) > 1) {

        ## Subclass plots

        ## randtests plots
        if(is(data, c("dispRity")) && is(data, c("randtest"))) {
            ## sanitising
            check.class(nclass, "numeric")
            check.class(coeff, "numeric")
            check.length(nclass, 1, " must be a single numeric value.")
            check.length(coeff, 1, " must be a single numeric value.")
            
            ## length_data variable initialisation
            length_data <- length(data)
            
            ## Set up the plotting window
            ## Open the multiple plots
            if(length_data != 1) {
                plot_size <- ifelse(length_data == 3, 4, length_data)
                op_tmp <- par(mfrow = c(ceiling(sqrt(plot_size)), round(sqrt(plot_size))))

                ## Rarefaction plots
                for(model in 1:length_data) {
                    plot.randtest(data[[model]], nclass = nclass, coeff = coeff, main = paste("MC test for subsets ", names(data)[[model]], sep = ""), ...)
                    ## plot.randtest(data[[model]], nclass = nclass, coeff = coeff, main = paste("MC test for subsets ", names(data)[[model]], sep = "")) ; warning("DEBUG: plot")
                }
                par(op_tmp)
            } else {
                plot.randtest(data[[1]], nclass = nclass, coeff = coeff, ...)
                ## plot.randtest(data[[model]], nclass = nclass, coeff = coeff) ; warning("DEBUG: plot")
            }
        }

        ## dtt plots (from https://github.com/mwpennell/geiger-v2/blob/master/R/disparity.R)
        if(is(data, c("dispRity")) && is(data, c("dtt"))) {
            ## Silence warnings
            options(warn = -1)

            ## Get the ylim
            if(missing(ylim)) {
                ylim <- c(range(pretty(data$dtt)))

                if(!is.null(data$sim)) {
                    ylim_sim <- range(data$sim)
                    ylim <- range(c(ylim, ylim_sim))
                }
            }

            if(missing(xlab)) {
                xlab <- "relative time"
            }
            if(missing(ylab)) {
                ylab <- "scaled disparity"
            }

            if(missing(col)) {
                colfun <- grDevices::colorRampPalette(c("lightgrey", "grey"))
                col <- c("black", colfun(length(quantiles)))
            }

            ## Plot the relative disparity curve
            plot(data$times, data$dtt, xlab = xlab, ylab = ylab, ylim = ylim, type = "n", ...)
            #plot(data$times, data$dtt, xlab = xlab, ylab = ylab, ylim = ylim, type = "n") ; warning("DEBUG plot")

            if(!is.null(data$sim)) {

                ## Check the quantiles
                check.class(quantiles, "numeric", " must be any value between 1 and 100.")
                ## Are quantiles probabilities or proportions ?
                if(any(quantiles < 1)) {
                    ## Transform into proportion
                    quantiles <- quantiles*100
                }
                ## Are quantiles proper proportions
                if(any(quantiles < 0) | any(quantiles > 100)) {
                    stop.call("", "quantiles(s) must be any value between 0 and 100.")
                }
                quantiles_n <- length(quantiles)

                ## Check the central tendency
                check.class(cent.tend, "function")
                ## The function must work
                if(make.metric(cent.tend, silent = TRUE) != "level1") {
                    stop.call("", "cent.tend argument must be a function that outputs a single numeric value.")
                }


                ## Summarised data
                quantiles_values <- apply(data$sim, 1, quantile, probs = CI.converter(quantiles), na.rm = TRUE)
                cent_tend_values <- apply(data$sim, 1, cent.tend)

                ## Plotting the polygons for each quantile
                for (cis in 1:quantiles_n) {
                    xx <- c(data$times, rev(data$times))
                    yy <- c(quantiles_values[(quantiles_n*2) - (cis-1), ], rev(quantiles_values[cis ,]))
                    polygon(xx, yy, col = col[cis+1],  border = FALSE, density = density)
                }


                ## Add the central tendency
                lines(data$times, cent_tend_values, col = col[1], lty = 2)
            }

            ## Add the observed disparity
            lines(data$times, data$dtt, col = col[1], lwd = 1.5)

            ## Re-enable warnings
            options(warn = 0)
        } 

        ## model.test plots
        if(is(data, c("dispRity")) && is(data, c("model.test"))) {

            ## Colours
            if(missing(col)) {
                col <- "grey"
            }
            ## Ylab
            if(missing(ylab)) {
                ylab <- "weighted AIC"
            }

            ## Ylim
            if(missing(ylim)) {
                ylim <- NULL
            }

            ## Plotting the model support
            plot.model.test.support(data = data, col = col, ylab = ylab, ylim = ylim, ...)
        }
        
        ## model.sim plots
        if(is(data, c("dispRity")) && is(data, c("model.sim"))) {
            
            ## xlab
            if(missing(xlab)) { 
                xlab <- "default"
            } 

            ## ylab
            if(missing(ylab)) {
                ylab <- "default"
            }

            ## col
            if(missing(col)) {
                col <- "default"
            }
    
            ## ylim
            if(missing(ylim)) {
                ylim <- "default"
            }

            ## add
            check.class(add, "logical")

            ## density
            if(!is.null(density)) {
                check.class(density, "numeric")
                check.length(density, 1, " must be a single numeric value.")
            }

            ## Get inherited subsets (if exist)
            if(!is.null(data$subsets)) {
                subset_names <- rev(data$subsets)
            } else {
                subset_names <- rev(data$simulation.data$fix$subsets)
            }

            ## Preparing the data and the arguments
            summarised_data <- data.frame(summary.dispRity(data, quantiles = quantiles, cent.tend = cent.tend, digits = 5))
            colnames(summarised_data)[3] <- "obs"
            summarised_data[,1] <- subset_names

            ## Setting the default arguments
            default_arg <- set.default(summarised_data, data, elements = FALSE, ylim = ylim, xlab = xlab, ylab = ylab, col = col, rarefaction = FALSE, type = "continuous", is_bootstrapped = TRUE)
            ylim <- default_arg[[1]]
            xlab <- default_arg[[2]]
            ylab <- default_arg[[3]]
            if(length(ylab) == 0) {
                ylab <- "disparity (simulated)"
            }
            col <- default_arg[[4]]

            ## Plotting the model
            plot_details <- plot.continuous(summarised_data, rarefaction = FALSE, is_bootstrapped = TRUE, is_distribution = TRUE, ylim, xlab, ylab, col, time_slicing = summarised_data$subsets, observed = FALSE, obs_list_arg = NULL, add, density, ...)
        }

        if(is(data, c("dispRity")) && is(data, c("test.metric"))) {

            ## Getting the number of plot groups
            group_plot <- sapply(names(data$results), function(x) strsplit(x, "\\.")[[1]][[1]])

            ## Separating the plots in different groups (per plot windows)
            n_plots <- length(unique(group_plot))

            if(n_plots > 1){
                ## Correct the number of plots if only 3
                plot_size <- ifelse(n_plots == 3, 4, n_plots)

                ## Setting up plotting window
                op_tmp <- par(mfrow = c(ceiling(sqrt(plot_size)),floor(sqrt(plot_size))))
            }

            ## Separating the data
            plot_groups <- list()
            for(group in 1:length(unique(group_plot))) {
                plot_groups[[group]] <- data$results[grep(unique(group_plot)[[group]], names(data$results))]
            }
            ## Separating the models
            if(!is.null(data$models)) {
                model_groups <- list()
                for(group in 1:length(unique(group_plot))) {
                    model_groups[[group]] <- data$models[grep(unique(group_plot)[[group]], names(data$models))]
                }
            }


            ## Get the yaxis scale
            all_ylim <- if(missing(ylim)) {range(unlist(lapply(data$results, function(x) x[,2])), na.rm = TRUE)} else {ylim}
            #all_ylim <- range(unlist(lapply(data$results, function(x) x[,2])), na.rm = TRUE)

            ## Get the colours
            if(missing(col)) {
                if(any(unique(group_plot) != "random")) {
                    col <- c("orange", "blue")
                } else {
                    col <- "black"
                }
            } else {
                if(length(col) < 2) {
                    col <- c(col, "grey")
                } else {
                    col <- col[1:2]
                }
            }

            ## Plot all the results
            for(one_plot in 1:n_plots) {
                ## Get the data to plot
                plot_data <- plot_groups[[one_plot]]

                ## First plot
                plot(plot_data[[1]],
                    ylim = all_ylim,
                    xlim = if(is.null(dots$xlim)) {range(as.numeric(plot_data[[1]][,1]))} else {xlim},
                    xlab = if(missing(xlab))      {"Amount of data (%)"} else {xlab},
                    ylab = if(missing(ylab))      {data$call$metric} else {ylab},
                    pch  = if(is.null(dots$pch))  {19} else {dots$pch},
                    main = if(is.null(dots$main)) {unique(group_plot)[[one_plot]]} else {dots$main},
                    col  = col[1]
                    )

                ## Second plot
                if(length(plot_data) > 1) {
                    plot_data[[2]][,1] <- as.numeric(plot_data[[2]][,1])
                    points(plot_data[[2]],
                           pch = if(is.null(dots$pch))  {19} else {dots$pch},
                           col = col[2])
                    legend("bottomright", legend = names(plot_data),
                           pch = if(is.null(dots$pch))  {19} else {dots$pch},
                           col = col)
                }

                ## Plot the model (if exists)
                if(!is.null(data$models)) {

                    ## Adding slopes and fits
                    add.slope <- function(model, col) {
                        ## Get the slope parameters
                        slope_param <- try.get.from.model(model, "Estimate")

                        ## Plot the model
                        if(!any(is.na(slope_param)) || !is.null(slope_param)) {
                            ## Add the slope
                            abline(a = slope_param[1],
                                   b = slope_param[2],
                                   col = col)
                        }
                    }
                    add.fit <- function(model) {
                        fit_param <- try.get.from.model(model, "r.squared")
                        if(!is.null(fit_param) || length(fit_param) != 0) {

                            if(any(names(fit_param) == "adj.r.squared")) {
                                fit_param <- fit_param$adj.r.squared
                                is_adjusted <- TRUE
                            } else {
                                is_adjusted <- FALSE
                            }

                            return(paste0(ifelse(is_adjusted, "Adj. R^2: ", "R^2: "), unlist(round(fit_param, 3))))
                        } else {
                            return(NA)
                        }
                    }

                    add.slope(model_groups[[one_plot]][[1]], col = col[1])
                    fit <- add.fit(model_groups[[one_plot]][[1]])
                    
                    if(!is.null(model_groups[[one_plot]][[1]])) {
                        add.slope(model_groups[[one_plot]][[2]], col = col[2])
                        fit <- c(fit, add.fit(model_groups[[one_plot]][[2]]))
                    }

                    ## Add the fits
                    if(!all(na_fit <- is.na(fit))) {
                        legend("topright", legend = fit[!na_fit], lty = c(1,1)[!na_fit], col = col[1:2][!na_fit])
                    }
                }
            }
            if(n_plots > 1) {
                par(op_tmp)
            }
        }
        
        ## Exit subclass plots
        return(invisible())
    }

    ## ----
    ## Normal disparity plot
    ## ----

    ## must be class dispRity
    check.class(data, "dispRity")
    ## must have one element called dispRity
    if(is.na(match("disparity", names(data)))) {
        if(!missing(type) && type != "preview") {
            stop.call(match_call$x, paste0(" must contain disparity data.\nTry running dispRity(", as.expression(match_call$x), ", ...)"))
        } else {
            if(missing(type)) {
                type <- "preview"
            }
        }
    }
    if(!missing(type) && type == "preview") {
        ## Preview plot
        plot.preview(data, dimensions = dimensions, matrix = matrix, ylim = ylim, xlab = xlab, ylab = ylab, col = col, ...)
        return(invisible())
    }

    ## Check if disparity is a value or a distribution
    is_distribution <- ifelse(length(data$disparity[[1]]$elements) != 1, TRUE, FALSE)
    ## Check the bootstraps
    is_bootstrapped <- ifelse(!is.null(data$call$bootstrap), TRUE, FALSE)

    ## quantiles
    ## Only check if the data is_bootstrapped or if it's a distribution
    if(is_bootstrapped || is_distribution) {
        check.class(quantiles, c("numeric", "integer"), " must be any value between 1 and 100.")

        ## Are quantiles probabilities or proportions ?
        if(any(quantiles < 1)) {
            ## Transform into proportion
            quantiles <- quantiles*100
        }
        ## Are quantiles proper proportions
        if(any(quantiles < 0) | any(quantiles > 100)) {
            stop.call("", "quantiles(s) must be any value between 0 and 100.")
        }
    }

    ## cent.tend
    ## Must be a function
    check.class(cent.tend, "function")
    ## The function must work
    if(make.metric(cent.tend, silent = TRUE) != "level1") {
        stop.call("", "cent.tend argument must be a function that outputs a single numeric value.")
    }

    ## type
    # if(length(data$subsets) == 1) {
    #     type <- "box"
    #     message("Only one subset of data available: type is set to \"box\".")
    # }

    if(missing(type)) {
        ## Set type to default
        if(any(grep("continuous", data$call$subsets))) {
            type <- "continuous"
        } else {
            type <- "box"
        }
    } else {
        ## type must be either "discrete", "d", "continuous", or "c"
        all_types <- c("continuous", "c", "box", "b", "line", "l", "polygon", "p")
        ## type must be a character string
        check.class(type, "character")
        type <- tolower(type)
        ## type must have only one element
        check.length(type, 1, paste(" argument must only one of the following:\n", paste(all_types, collapse=", "), ".", sep=""))
        check.method(type, all_types, "type argument")
        
        ## if type is a letter change it to the full word (lazy people...)
        type <- ifelse(type == "c", "continuous", type)
        type <- ifelse(type == "b", "box", type)
        type <- ifelse(type == "l", "line", type)
        type <- ifelse(type == "p", "polygon", type)
    }

    ## If continuous, set time to continuous Ma (default)
    if(type == "continuous" & chrono.subsets) {
        ## Check if time.slicing was used (saved in call)
        if(data$call$subsets[1] == "continuous") {
            time_slicing <- names(data$subsets)
        }
    } 
    if(!chrono.subsets) {
        time_slicing <- FALSE
    } else {
        time_slicing <- names(data$subsets)
    }

    ## elements
    ## must be logical
    check.class(elements, "logical")

    ## Rarefaction
    if(is.null(rarefaction)) {
        rarefaction <- FALSE
    }
    ## If data is not bootstrapped, rarefaction is FALSE
    if(!is_bootstrapped) {
        rarefaction <- FALSE
    }
    ## Check class
    silent <- check.class(rarefaction, c("logical", "integer", "numeric"))
    if(!is(rarefaction, "logical")) {
        ## Right class
        rarefaction <- as.numeric(rarefaction)
        check.length(rarefaction, 1, errorif = FALSE, msg = "Rarefaction must a single numeric value.")
        ## Check if all subsets have the appropriate rarefaction level
        rarefaction_subsets <- lapply(lapply(data$subsets, lapply, nrow), function(X) which(X[-1] == rarefaction)+1)
        ## Check if subsets have no rarefaction
        if(length(unlist(rarefaction_subsets)) != length(data$subsets)) {
            wrong_rarefaction <- lapply(rarefaction_subsets, function(X) ifelse(length(X) == 0, TRUE, FALSE))
            stop.call("", paste0("The following subsets do not contain ", rarefaction, " elements: ", paste(names(data$subsets)[unlist(wrong_rarefaction)], collapse = ", "), "."))
        }
    }

    ## observed
    class_observed <- check.class(observed, c("logical", "list"))
    if(class_observed == "list") {
        ## Transforming into logical and handling the list below
        obs_list_arg <- observed
        observed <- TRUE
    } else {
        ## Creating and empty list to be handled below
        obs_list_arg <- list()
    }

    ## xlab
    if(missing(xlab)) { 
        xlab <- "default"
        if(!any("customised" %in% data$call$subsets) && chrono.subsets != FALSE && rarefaction != TRUE) {
            xlab <- "Time (Mya)"
        }
    } else {
        ## length must be 1
        check.length(xlab, 1, " must be a character string.")
    }

    ## ylab
    if(missing(ylab)) {
        ylab <- "default"
    } else {
        ## length must be 
        if(elements == FALSE) {
            check.length(ylab, 1, " must be a character string.")
        } else {
            if(length(ylab) > 2) {
                stop.call("", "ylab can have maximum of two elements.")
            }
        }
    }

    ## col
    ## if default, is ok
    if(missing(col)) {
        if(type == "box" & rarefaction != TRUE) {
            col <- "white"
        } else {
            col <- "default"
        }
    } else {
        check.class(col, "character", " must be a character string.")
    }

    ## ylim
    if(missing(ylim)) {
        ylim <- "default"
    } else {
        check.class(ylim, "numeric")
        check.length(ylim, 2, " must be a vector of two elements.")
    }

    ## add
    check.class(add, "logical")

    ## PREPARING THE PLOT

    ## summarising the data
    ## (remove NAs if data has a distribution of trees)
    if(!is.na(data$call$subsets["trees"]) && as.numeric(data$call$subsets["trees"]) > 1) {
        summarised_data <- summary.dispRity(data, quantiles = quantiles, cent.tend = cent.tend, digits = 5, na.rm = TRUE)
    } else {
        summarised_data <- summary.dispRity(data, quantiles = quantiles, cent.tend = cent.tend, digits = 5)
    }

    ## Setting the default arguments
    default_arg <- set.default(summarised_data, data, elements = elements, ylim = ylim, xlab = xlab, ylab = ylab, col = col, rarefaction = rarefaction, type = type, is_bootstrapped = is_bootstrapped)
    ylim <- default_arg[[1]]
    xlab <- default_arg[[2]]
    ylab <- default_arg[[3]]
    col <- default_arg[[4]]

    ## Adding the default parameters to observed
    if(observed) {
        if(is.null(obs_list_arg$col)) {
            obs_list_arg$col <- col[[1]]
        }
        if(is.null(obs_list_arg$pch)) {
            obs_list_arg$pch <- 4
        }
        if(is.null(obs_list_arg$cex)) {
            obs_list_arg$cex <- 1
        }
    }

    ## PLOTTING THE RESULTS

    ## Rarefaction plot
    if(rarefaction == TRUE) {
        ## How many rarefaction plots?
        n_plots <- length(data$subsets)

        ## Open the multiple plots
        plot_size <- ifelse(n_plots == 3, 4, n_plots)
        op_tmp <- par(mfrow = c(ceiling(sqrt(plot_size)),round(sqrt(plot_size))))

        ## Rarefaction plots

        ## Get the list of subsets
        subsets_levels <- unique(summarised_data$subsets)

        ## Split the summary table
        sub_summarised_data <- lapply(as.list(subsets_levels), split.summary.data, summarised_data)

        ## Plot the rarefaction curves
        for(nPlot in 1:n_plots) {
            plot.rarefaction(sub_summarised_data[[nPlot]], ylim, xlab, ylab, col, ...)
            # plot.rarefaction(sub_summarised_data[[nPlot]], ylim, xlab, ylab, col) ; warning("DEBUG: plot")
        }

        ## Done!
        par(op_tmp)

        return(invisible())
    }

    ## Continuous plot
    if(type == "continuous") {
        ## Bigger plot margins if elements needed
        if(elements) {
            par(mar = c(5, 4, 4, 4) + 0.1)
        }
        saved_par <- plot.continuous(summarised_data, rarefaction, is_bootstrapped, is_distribution, ylim, xlab, ylab, col, time_slicing, observed, obs_list_arg, add, density,...)
        # saved_par <- plot.continuous(summarised_data, rarefaction, is_bootstrapped, is_distribution, ylim, xlab, ylab, col, time_slicing, observed, obs_list_arg, add, density); warning("DEBUG: plot")
        if(elements) {
            par(new = TRUE)
            plot.elements(summarised_data, rarefaction, ylab = ylab, col = col[[1]], type = "continuous", cex.lab = saved_par$cex.lab, element.pch = element.pch)
        }
        return(invisible())
    }

    ## Polygons or lines
    if(type == "polygon" | type == "line") {
        ## Bigger plot margins if elements needed
        if(elements) {
            par(mar = c(5, 4, 4, 4) + 0.1)
        }
        ## Personalised discrete plots
        saved_par <- plot.discrete(summarised_data, rarefaction, is_bootstrapped, is_distribution, type, ylim, xlab, ylab, col, observed, obs_list_arg, add, density, ...) 
        # saved_par <- plot.discrete(summarised_data, rarefaction, is_bootstrapped, type, ylim, xlab, ylab, col, observed, obs_list_arg, add, density) ; warning("DEBUG: plot")
        if(elements) {
            par(new = TRUE)
            plot.elements(summarised_data, rarefaction, ylab = ylab, col = col[[1]], type = "discrete", cex.lab = saved_par$cex.lab, element.pch = element.pch)
        }
        return(invisible())
    }

    ## Box plot
    if(type == "box") {
        ## Simple case: boxplot
        plot_data <- transpose.box(data, rarefaction, is_bootstrapped)
        ## Bigger plot margins if elements needed
        if(elements) {
            par(mar = c(5, 4, 4, 4) + 0.1)
        }
        saved_par <- boxplot(plot_data, ylim = ylim, xlab = xlab, ylab = ylab[[1]], col = col, add = add, ...)
        # saved_par <- boxplot(plot_data, ylim = ylim, xlab = xlab, ylab = ylab[[1]], col = col, add = add) ; warning("DEBUG: plot")

        if(observed == TRUE) {
            if(any(!is.na(extract.from.summary(summarised_data, 3, rarefaction)))){
                ## Add the points observed (if existing)
                for(point in 1:length(plot_data)) {
                    x_coord <- point
                    y_coord <- extract.from.summary(summarised_data, 3, rarefaction)[point]
                    points(x_coord, y_coord, pch = obs_list_arg$pch, col = obs_list_arg$col, cex = obs_list_arg$cex)
                }
            }
        }
        if(elements) {
            par(new = TRUE)
            plot.elements(summarised_data, rarefaction, ylab = ylab, col = col[[1]], type = "discrete", cex.lab = saved_par$cex.lab, element.pch = element.pch)
        }

        return(invisible())
    }

}