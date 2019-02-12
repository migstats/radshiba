#' Mediatonic theme
#'
#' @param base_size font base size
#'
#' @return ggplot object
#' @export
theme_mt <- function(base_size = 18){
  ggplot2::theme_light(base_size = base_size) %+replace%
    ggplot2::theme(
      plot.title = element_text(family = "Bebas Neue", hjust = 0, vjust = 2),
      plot.subtitle = element_text(family = "Lucida Sans Unicode", size = 12, hjust = 0, vjust = 1.8, margin(20,20,20,20, "cm")),
      axis.text = element_text(family = "Bebas Neue", size = 14),
      axis.title.x = element_text(family = "Lucida Sans Unicode", size = 12, vjust = -0.5),
      axis.title.y = element_text(family = "Lucida Sans Unicode", size = 12, vjust = 4, angle = 90),
      plot.caption = element_text(family = "Bebas Neue", size = 12, hjust = 1, vjust = -1),
      plot.margin = margin(15,15,15,15)
    )
}
