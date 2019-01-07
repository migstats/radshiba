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

run_query <- function(query, file = NA){
  con <- create_connection_sf()
  if(!is.na(file)){}
  a <- janitor::clean_names(suppressWarnings(DBI::dbGetQuery(con, query)))
  DBI::dbDisconnect(con)
  return(a)
}
