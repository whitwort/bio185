push <- function(build = FALSE, www = TRUE, pkg = TRUE) {
  
  if (build) courseR::build()
  if (www)   file.copy( from = "dist/www/", to = "live/", recursive = TRUE)
  if (pkg)   file.copy( from = "dist/bio185/", to = "live/", recursive = TRUE)
  
}

clean <- function() {
  unlink(x = c("_site","build","dist"), recursive = TRUE)
}
