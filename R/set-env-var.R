#' Creates a enviroment with variables from a pairwise dataframe
#'
#' @param data A dataframe with two columns
#'
#' @return An enviroment
#' @export
df_to_enviroment <- function(data){
  df_names <- names(data)
  data %>%
    tidyr::spread(df_names[1], df_names[2]) %>%
    list2env()
}
