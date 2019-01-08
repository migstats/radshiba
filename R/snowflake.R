#' Create connection with snowflake
#'
#' Create connection with snowflake db. Remember to define the variables
#' `snowflake_uid`, `snowflake_password`, `snowflake_warehouse`, `snowflake_database`
#'  and `snowflake_scheme` with the `keyring` package (`keyring::key_set()`).
#'
#' @return
#' @export
#'
#' @examples
create_connection_sf <- function(){
  connection_string <- paste0("Driver={SnowflakeDSIIDriver};SERVER=",
                              keyring::key_get("snowflake_server"),
                              ";UID=", keyring::key_get("snowflake_uid"),
                              ";PWD=", keyring::key_get("snowflake_password"))

  con <- DBI::dbConnect(odbc::odbc(), .connection_string = connection_string)
  suppressWarnings(DBI::dbSendQuery(con, paste("USE WAREHOUSE", keyring::key_get("snowflake_warehouse"))))
  suppressWarnings(DBI::dbSendQuery(con, paste0("USE SCHEMA \"", keyring::key_get("snowflake_database"),
                               "\".\"", keyring::key_get("snowflake_scheme"), "\"")))
  con
}

#' Read the content of a text file
#'
#' @param file Location of the file
#'
#' @return
#' @export String
#'
#' @examples
read_query<- function(file){paste(readLines(file), collapse="\n")}

#' Run query
#'
#' Execute a query, can be a string or a query from a file.
#'
#' @param query Query in a string format
#' @param file Route of the query
#'
#' @return Dataframe
#' @export
#'
#' @examples
run_query <- function(query, file = NA){
  con <- create_connection_sf()
  if(!is.na(file)){
    query <- read_query(file)
  }
  a <- janitor::clean_names(suppressWarnings(DBI::dbGetQuery(con, query)))
  DBI::dbDisconnect(con)
  return(a)
}

run_queries <- function(folder = "sql/"){
  all_queries <- list.files(path = folder)

  all_queries %>%
    purrr::map(~ paste0(folder, .)) %>%
    purrr::map_df(~ run_query(file = .))
}
