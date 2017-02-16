#' Publish the current version of a Shiny app project hosted on the course's 
#' Bio-185 GitHub organization to the RNA Shiny server.
#' 
#' @param projectName string with your group's project name.  This must match
#'   your group's repository name on GitHub.
#' @param remove if TRUE will remove the old version of your app and update.
#'   
#' @export
publishApp <- function(projectName, remove = TRUE) {
  
  basePath <- "/var/shiny-server"
  path     <- file.path(basePath, projectName)
  
  if (dir.exists(path) & remove) {
    message("Removing old version...")
    unlink(path, recursive = TRUE)
  } else if (dir.exists(path) & !remove) {
    message("Can't publish.  An app with that name is already being hosted.  Try 'remove = TRUE'.")
  }

  gitURL <- paste0("https://github.com/WL-Biol185-ShinyProjects/", projectName, ".git")
  message("Trying to clone:", gitURL)
  
  system(paste0( "git clone https://github.com/WL-Biol185-ShinyProjects/"
               , projectName
               ,".git /var/shiny-server/bio185/"
               , projectName
               )
         )
  
}