#' Create connection with snowflake
#'
#' Create connection with snowflake db. Remember to define the variables
#' `snowflake_uid`, `snowflake_password`, `snowflake_warehouse`, `snowflake_database`
#'  and `snowflake_scheme` with the `keyring` package (`keyring::key_set()`).
#'
#' @return Connection
#' @export
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
#' @return String
#' @export
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
run_query <- function(query, file = NA, name = NA){
  con <- create_connection_sf()
  if(!is.na(file)){
    query <- read_query(file)
  }
  a <- janitor::clean_names(suppressWarnings(DBI::dbGetQuery(con, query)))
  DBI::dbDisconnect(con)
  if(is.na(name)){
    return(a)
  } else {
    readr::write_csv(x = a, path = paste0("data/", name, ".csv"))
  }
}

#' Run multiples queries in a single folder
#'
#' @param folder Folder with all the queries
#' @param save Folder to store the results of the queries
#'
#' @export
run_queries <- function(folder = "sql/", save = "data/"){
  all_queries <- list.files(path = folder)

  all_queries %>%
    purrr::map(~ paste0(folder, .)) %>%
    purrr::map(~ run_query(file = .)) %>%
    purrr::set_names(stringr::str_sub(all_queries, end = -5)) %>%
    purrr::walk2(names(.), ~ readr::write_csv(x = .x, path = paste0(save, .y, ".csv")))
}
