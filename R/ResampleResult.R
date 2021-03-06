#' @title ResampleResult object.
#' @name ResampleResult
#' @rdname ResampleResult
#' @description
#' A resample result is created by \code{\link{resample}} and
#' contains the following object members:
#' \describe{
#' \item{task.id [\code{character(1)}]:}{
#'   Name of the Task.
#' }
#' \item{learner.id [\code{character(1)}]:}{
#'   Name of the Learner.
#' }
#' \item{measures.test [\code{data.frame}]:}{
#'   Gives you access to performance measurements
#'   on the individual test sets. Rows correspond to sets in resampling iterations,
#'   columns to performance measures.
#' }
#' \item{measures.train [\code{data.frame}]:}{
#'   Gives you access to performance measurements
#'   on the individual training sets. Rows correspond to sets in resampling iterations,
#'   columns to performance measures. Usually not available, only if specifically requested,
#'   see general description above.
#' }
#' \item{aggr [\code{numeric}]:}{
#'   Named vector of aggregated performance values. Names are coded like
#'   this <measure>.<aggregation>.
#' }
#' \item{err.msgs [\code{data.frame}]:}{
#'   Number of rows equals resampling iterations
#'   and columns are: \dQuote{iter}, \dQuote{train}, \dQuote{predict}.
#'   Stores error messages generated during train or predict, if these were caught
#'   via \code{\link{configureMlr}}.
#' }
#' \item{pred [\code{\link{ResamplePrediction}}]:}{
#'   Container for all predictions during resampling.
#' }
#' \item{models [list of \code{\link{WrappedModel}}]:}{
#'   List of fitted models or \code{NULL}.
#' }
#' \item{extract [\code{list}]:}{
#'   List of extracted parts from fitted models or \code{NULL}.
#' }
#' \item{runtime [\code{numeric(1)}]:}{
#'   Time in seconds it took to execute the resampling.
#' }
#' }
#' The print method of this object gives a short overview, including
#' task and learner ids, aggregated measures and runtime for the resampling.
#' @family resample
NULL

#' @export
print.ResampleResult = function(x, ...) {
  cat("Resample Result\n")
  catf("Task: %s", x$task.id)
  catf("Learner: %s", x$learner.id)
  catf("Aggr perf: %s", perfsToString(x$aggr))
  catf("Runtime: %g", x$runtime)
  invisible(NULL)
}
