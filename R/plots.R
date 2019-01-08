#' Simple density plot function
#'
#' @param column Name of the column
#' @param alpha Alpha parameter for ggplot
#'
#' @export
dens <- function(column, alpha = NA){
  ggplot2::ggplot(data.frame(a = column), aes(x = a)) +
    ggplot2::geom_density(alpha = alpha) +
    ggplot2::theme_light()
}
