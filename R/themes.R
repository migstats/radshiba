#' Mediatonic theme
#'
#' @param base_size font base size
#'
#' @return ggplot object
#' @export
theme_mt <- function(base_size = 18){
  ggplot2::theme_light(base_size = base_size) %+replace%
    ggplot2::theme(
      plot.title = element_text(family = "Bebas Neue", hjust = 0, vjust = 2,
                                margin = margin(t = 0, r = 0, b = 4, l = 0)),
      plot.subtitle = element_text(family = "Lucida Sans Unicode", size = 12, hjust = 0, vjust = 1.8,
                                   margin = margin(t = 0, r = 0, b = 4, l = 0)),
      axis.text = element_text(family = "Bebas Neue", size = 14),
      axis.title.x = element_text(family = "Lucida Sans Unicode", size = 12, vjust = -0.5),
      axis.title.y = element_text(family = "Lucida Sans Unicode", size = 12, vjust = 4, angle = 90),
      plot.caption = element_text(family = "Bebas Neue", size = 12, hjust = 1, vjust = -1),
      plot.margin = margin(15,15,15,15),
      legend.title = element_text(family = "Bebas Neue", size = 14, vjust = -1),
      legend.title.align = 0.5,
      legend.text = element_text(family = "Lucida Sans Unicode", size = 10),
      legend.margin = margin(l = -0.5, unit = "cm"),
      strip.background = element_rect(colour = "black", fill = "red4"),
      strip.text = element_text(family = "Bebas Neue", colour = "white", size = 16,
                                margin = margin(t = 3, r = 0, b = 4, l = 0))
    )
}
