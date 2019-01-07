#' Setup a project
#'
#' @param project_name Name of the project
setup_project <- function(project_name){
  current_date <- format(Sys.time(), "%Y-%m-%d")
  project_name <- gsub(" " , "_", project_name)
  folder_name <- paste(current_date, project_name, sep = "-")

  usethis::create_project(folder_name)

  folders <- c("analysis", "sql", "data", "output", "drawer")
  purrr::walk(folders, ~ dir.create(paste(folder_name, ., sep = "/")))
}
