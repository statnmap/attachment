#' Return all package dependencies from current package
#'
#' @param path path to the DESCRIPTION file
#' @param dput if FALSE return a vector instead of dput output
#' @param field DESCRIPTION fied to parse, Import and Depends by default
#'
#' @return A character vector with packages names
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_dependencies()
#' }
get_dependencies <- function(path = "DESCRIPTION", dput = TRUE,
                             field = c("Depends", "Imports")) {
  out <- read.dcf(path)
  out <- out[, intersect(colnames(out), field)] %>%
    gsub(pattern = "\n", replacement = "") %>%
    strsplit(",") %>%
    unlist() %>%
    setNames(NULL)
  out <- out[!grepl("^R [(]", out)]

  if (!dput) {
    return(out)
  }
  out %>% dput()
}
