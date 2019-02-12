#' Setup a project
#'
#' @param name Name of the project
#'
#' @export
setup_project <- function(name){
  current_date <- format(Sys.time(), "%Y-%m-%d")
  name <- gsub(" " , "_", name)
  folder_name <- paste(current_date, name, sep = "-")

  usethis::create_project(folder_name)

  folders <- c("analysis", "sql", "data", "output", "drawer")
  purrr::walk(folders, ~ dir.create(paste(folder_name, ., sep = "/")))
}

#' Setup a R code file
#'
#' @param name Name of the file
#'
#' @export
setup_file <- function(name){
  current_number <- get_current_file_number() %>%
    stringr::str_pad(2, "left", pad = "0")

  if(is.na(current_number)){
    current_number <- "01"
    }

  dir <- paste0("analysis/", current_number, "-", name, ".R")

  file.create(dir)

  file_conn <- file(dir)
  writeLines(c("library(tidyverse)","library(janitor)", "library(skimr)"), file_conn)
  close(file_conn)

  file.edit(dir)
}

get_current_file_number <- function(){
  list.files("analysis") %>%
    purrr::map_chr(~substr(., 1, 2)) %>%
    max() %>%
    as.integer() %>%
    `+`(1)
}
