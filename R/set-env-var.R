#' Creates a enviroment with variables from a pairwise dataframe
#'
#' @param data A dataframe with two columns
#'
#' @return An enviroment
#' @export
df_to_enviroment <- function(data){
  data %>%
    tidyr::spread(var, val) %>%
    list2env()
}
