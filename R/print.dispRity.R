#' @title Prints a \code{dispRity} object.
#'
#' @description Summarises the content of a \code{dispRity} object.
#'
#' @param x A \code{dispRity} object.
#' @param all \code{logical}; whether to display the entire object (\code{TRUE}) or just summarise its contents (\code{FALSE} - default).
#' @param ... further arguments to be passed to \code{print} or to \code{print.dispRity}.
#' 
#' @examples
#' ## Load the disparity data based on Beck & Lee 2014
#' data(disparity)
#' 
#' ## Displaying the summary of the object content
#' disparity
#' print(disparity) # the same
#' print.dispRity(disparity) # the same
#'
#' ## Displaying the full object
#' print.dispRity(disparity, all = TRUE)
#'
#' @seealso \code{\link{custom.subsets}}, \code{\link{chrono.subsets}}, \code{\link{boot.matrix}}, \code{\link{dispRity}}.
#'
#' @author Thomas Guillerme

## DEBUG
# warning("DEBUG dispRity.R")
# library(dispRity)
# source("sanitizing.R")
# source("dispRity.R")
# source("dispRity_fun.R")
# source("dispRity.metric.R")
# source("make.dispRity.R")
# source("fetch.dispRity.R")
# source("boot.matrix.R") ; source("boot.matrix_fun.R")
# source("chrono.subsets.R") ; source("chrono.subsets_fun.R")
# source("custom.subsets.R") ; source("custom.subsets_fun.R")
# data(BeckLee_mat50)
# data(BeckLee_tree)
# data_simple <- BeckLee_mat50
# data_boot <- boot.matrix(BeckLee_mat50, bootstraps = 11, rarefaction = c(5,6))
# data_subsets_simple <- chrono.subsets(BeckLee_mat50, tree = BeckLee_tree,  method = "discrete", time = c(120,80,40,20))
# data_subsets_boot <- boot.matrix(data_subsets_simple, bootstraps = 11, rarefaction = c(5,6))
# data <- dispRity(data_subsets_boot, metric = c(variances))

 
print.dispRity <- function(x, all = FALSE, ...) {

    match_call <- match.call()
    x_name <- match_call$x

    if(all) {
        ## Print everything
        tmp <- x
        class(tmp) <- "list"
        print(tmp)

    } else {

        ## ~~~~~~~
        ## Composite dispRity objects (subclasses)
        ## ~~~~~~~


        if(length(class(x)) > 1) {
            ## randtest
            switch(class(x)[[2]],
                randtest = {
                    ## Remove the call (messy)
                    remove.call <- function(element) {
                        element$call <- "dispRity::null.test"
                        return(element)
                    }
                    x <- lapply(x, remove.call)

                    if(length(x) == 1) {
                        print(x[[1]])
                    } else {
                        tmp <- x
                        class(tmp) <- "list"
                        print(tmp) 
                    }
                    return(invisible())
                },
                model.test = {
                    cat("Disparity evolution model fitting:\n")
                    cat(paste0("Call: ", as.expression(x$call), " \n\n"))
                    
                    print(x$aic.models)

                    cat(paste0("\nUse x$full.details for displaying the models details\n"))
                    cat(paste0("or summary(x) for summarising them.\n"))

                    return(invisible())
                },
                model.sim = {
                    cat("Disparity evolution model simulation:\n")
                    cat(paste0("Call: ", as.expression(x$call), " \n\n"))
                    cat(paste0("Model simulated (", x$nsim, " times):\n"))

                    print(x$model)

                    cat("\n")

                    if(!is.null(x$p.value)) {
                        print(x$p.value)
                    }

                    return(invisible())
                },
                dtt = {
                    if(length(x) != 2){
                        ## Tested dtt
                        cat("Disparity-through-time test (modified from geiger:dtt)\n")
                        cat(paste0("Call: ", as.expression(x$call), " \n\n"))

                        cat(paste0("Observation: ", x$MDI , "\n\n"))

                        cat(paste0("Model: ", x$call$model , "\n"))
                        cat(paste0("Based on ", length(x$sim_MDI) , " replicates\n"))
                        cat(paste0("Simulated p-value: ", x$p_value , "\n"))
                        cat(paste0("Alternative hypothesis: ", x$call$alternative , "\n\n"))

                        print(c("Mean.dtt" = mean(x$dtt, na.rm = TRUE), "Mean.sim_MDI" = mean(x$sim_MDI, na.rm = TRUE), "var.sim_MDI" = var(x$sim_MDI, na.rm = TRUE)))

                        cat(paste0("\nUse plot.dispRity() to visualise."))
                        return(invisible())
                    } else {
                        ## raw dtt
                        ## Fake an object with no attributes
                        x_tmp <- x
                        class(x_tmp) <- "list"
                        print(x_tmp)
                        cat(paste0("- attr(*, \"class\") = \"dispRity\" \"dtt\"\n"))
                        cat(paste0("Use plot.dispRity to visualise."))
                        return(invisible())
                    }
                },
                test.metric = {
                    cat("Metric testing:\n")
                    cat(paste0("The following metric was tested: ", as.expression(x$call$metric), ".\n"))
                    cat(paste0("The test was run on "))
                    if(length(x$call$shifts) > 1) {
                        cat(paste0("the ", paste0(x$call$shifts, collapse = ", "), " shifts"))
                    } else {
                        cat(paste0("the ", x$call$shifts, " shift"))
                    }
                    cat(paste0(" for ", x$call$replicates, " replicate", ifelse(x$call$replicates > 1, "s", "")))
                    if(!is.null(x$models)) {
                        cat(paste0(" using the following model:\n"))
                        cat(as.character(as.expression(body(x$call$model))))
                    } else {
                        cat(paste0("."))
                    }
                    cat(paste0("\nUse summary(", x_name, ") or plot(",x_name, ") for more details."))
                    return(invisible())
                }
            )
        }

        
        ## ~~~~~~~
        ## Simple dispRity objects
        ## ~~~~~~~


        if(length(x$call) == 0) {
            if(!is.null(x$matrix) && is(x$matrix[[1]], "matrix")) {
                cat(" ---- dispRity object ---- \n")
                dims <- dim(x$matrix[[1]])
                n_matrices <- length(x$matrix)
                cat(paste0("Contains only ", ifelse(n_matrices > 1, paste0(n_matrices, " matrices "), "a matrix "), dims[1], "x", dims[2], "."))
            } else {
                cat("Empty dispRity object.\n")
            }
            return()
        }

        cat(" ---- dispRity object ---- \n")

        ## Print the matrix information
        if(any(names(x$call) == "subsets") && length(x$subsets) != 1) {
            ## Get the number of subsets (minus origin)
            subsets <- names(x$subsets)

            ## Check if there is more than one subset
            if(length(subsets) != 1) {

                ## Get the method
                method <- x$call$subsets

                switch(method[1],
                    "discrete" = {cat(paste(length(subsets), method[1], "time subsets for", nrow(x$matrix[[1]]), "elements"))},
                    "continuous" = {cat(paste(length(subsets),  paste(method[1], " (", method[2],")", sep = ""), "time subsets for", nrow(x$matrix[[1]]), "elements"))},
                    "customised" = {cat(paste(length(subsets), method[1], "subsets for", nrow(x$matrix[[1]]), "elements"))}
                    )

                # if(method[1] != "discrete") {
                #     method <- paste(method[1], " (", method[2],")", sep = "")
                # }
                # if(method[1] == "customised") {
                #     cat(paste(length(subsets), method[1], "subsets for", nrow(x$matrix[[1]]), "elements"))    
                # } else {
                #     cat(paste(length(subsets), method[1], "time subsets for", nrow(x$matrix[[1]]), "elements"))
                # }
                if(length(x$matrix) > 1) {
                    cat(paste0(" in ", length(x$matrix), " matrices"), sep = "")
                } else {
                    cat(paste0(" in one matrix"), sep = "")
                }

                if(length(x$call$dimensions) != 0) cat(paste(" with", x$call$dimensions, "dimensions"), sep = "")
                cat(":\n")
                if(length(subsets) > 5) {
                    cat("    ",paste(subsets[1:5], collapse=", "),"...\n")
                } else {
                    cat("    ",paste(subsets, collapse=", "), ".\n", sep="")
                }
            }
        } else {
            cat(paste(nrow(x$matrix[[1]]), "elements"))
            if(length(x$matrix) > 1) {
                cat(paste0(" in ", length(x$matrix), " matrices"), sep = "")
            } else {
                cat(paste0(" in one matrix"), sep = "")
            }
            if(length(x$call$dimensions) != 0) cat(paste(" with", x$call$dimensions, "dimensions"), sep = "")
            cat(".\n")
        }
        
        ## Print the bootstrap information
        if(any(names(x$call) == "bootstrap")) {
            if(x$call$bootstrap[[1]] != 0) {
                cat(paste("Data was bootstrapped ", x$call$bootstrap[[1]], " times (method:\"", x$call$bootstrap[[2]], "\")", sep = ""))
            }
            if(!is.null(x$call$bootstrap[[3]])) {
                if(x$call$bootstrap[[3]][[1]] == "full") {
                    cat(" and fully rarefied")
                } else {
                    cat(paste(" and rarefied to ", paste(x$call$bootstrap[[3]], collapse = ", "), " elements", sep = ""))
                }
            }
            cat(".\n")
        }

        ## Print the disparity information
        if(any(names(x$call) == "disparity")) {
            cat(paste("Disparity was calculated as:", paste(as.character(x$call$disparity$metrics$name), collapse = ", ")))
            cat(".\n")
        }
    }
}