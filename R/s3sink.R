.__sink_original__ <- new.env(parent = emptyenv())
.__sink_override__ <- new.env(parent = emptyenv())


get_s3_override <- function(name) {
  .__sink_override__[[name]]
}

override_s3_method <- function(name, method) {
  table <- .BaseNamespaceEnv[[".__S3MethodsTable__."]]

  if (exists(name, table)) {
    assign(name, get(name, table), .__sink_original__)
  }

  attr(method, ".__sink_override__") <- TRUE
  assign(name, method, table)
  assign(name, method, .__sink_override__)
  invisible(NULL)
}

remove_s3_override <- function(name) {
  table <- .BaseNamespaceEnv[[".__S3MethodsTable__."]]

  if (!exists(name, envir = table))
    return(invisible(NULL))

  if (!isTRUE(attr(get(name, envir = table), ".__sink_override__")))
    return(invisible(NULL))

  if (exists(name, envir = .__sink_original__)) {
    assign(name, get(name, envir = .__sink_original__), envir = table)
  } else {
    rm(list = name, envir = table)
  }

  if (exists(name, envir = .__sink_override__))
    rm(list = name, envir = .__sink_override__)

  invisible(NULL)
}

resume_s3_override <- function(name) {
  method <- get_s3_override(name)

  if (!is.null(method)) {
    override_s3_method(name, method)
  }
  invisible(NULL)
}

ns_sink_hook <- function(name, pkgname) {
  setHook(packageEvent(pkgname, "onLoad"),
          function(...) resume_s3_override(name))
}

#' Capture arguments to S3 generics
#'
#' @param name character string. Name of an S3 generic
#' @param pkgname character string. Name of a package which registers the
#'   generic used in `name`. (optional)
#'
#' @details ...
#' @return
#'   `sink_s3` returns invisibly `NULL`
#'
#'   `unsink_s3` returns invisibly a list of lists of arguments
#'
#' @export
#'
#' @examples
#' sink_s3("print.ggplot", "ggplot2")
#' library(ggplot2)
#' ggplot(mtcars) + geom_point(aes(mpg, disp))
#' out <- unsink_s3("print.ggplot")
#'
#' str(out)
sink_s3 <- function(name, pkgname = NULL) {
  if (!is.null(name) & !is.character(name))
    stop("'name' must be a length one character vector.")

  if (!is.null(pkgname) & !is.character(pkgname))
    stop("'pkgname' must be a length one character vector.")


  e <- new.env(parent = baseenv())
  e[[".__sink_output__"]] <- list()

  stub <- function(...) {
    .__sink_output__ <<- base::append(.__sink_output__, list(...))
  }

  environment(stub) <- e
  override_s3_method(name, stub)

  if (!is.null(pkgname))
    ns_sink_hook(name, pkgname)
}

#' @rdname sink_s3
#' @export
unsink_s3 <- function(name) {
  override_method <- get_s3_override(name)
  sink_env <- environment(override_method)
  remove_s3_override(name)

  return(invisible(sink_env[[".__sink_output__"]]))
}

#' @export
capture_s3 <- function(expr, name, pkgname) {
  sink_s3(name, pkgname)
  eval(substitute(expr))
  unsink_s3(name)
}
