dens <- function(column, alpha = NA){
  ggplot2::ggplot(data.frame(a = column), aes(x = a)) +
    ggplot2::geom_density(alpha = alpha) +
    ggplot2::theme_light()
}
