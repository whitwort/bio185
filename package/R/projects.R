#' Publish the current version of a Shiny app project hosted on the course's 
#' Bio-185 GitHub organization to the RNA Shiny server.
#' 
#' @param projectName string with your group's project name.  This must match
#'   your group's repository name on GitHub.
#' @param remove if TRUE will remove the old version of your app and update.
#'   
#' @export
publishApp <- function(projectName, remove = TRUE) {
  
  basePath <- "/var/shiny-server/bio185"
  path     <- file.path(basePath, projectName)
  
  if (dir.exists(path) && remove) {
    message("Removing old version...")
    unlink(path, recursive = TRUE, force = TRUE)
  } else if (dir.exists(path) && !remove) {
    message("Can't publish; an app with that name already exists.  Try 'remove = TRUE'.")
  }
  
  gitURL <- paste0("https://github.com/WL-Biol185-ShinyProjects/", projectName, ".git")
  message("Trying to clone: ", gitURL)
  
  system(paste0( "git clone https://github.com/WL-Biol185-ShinyProjects/"
               , projectName
               ,".git /var/shiny-server/bio185/"
               , projectName
               )
         )
  
  message("If there were no errors, your app was published to:")
  message(paste0("https://rna.wlu.edu/shiny-apps/bio185/", projectName, "/"))
  
}
