library(httr)

push <- function(build = FALSE, www = TRUE, pkg = TRUE, projects = TRUE) {
  
  if (build)    courseR::build()
  if (projects) updateProjects()
  if (www)      file.copy(from = "dist/www/", to = "live/", recursive = TRUE)
  if (pkg)      file.copy(from = "dist/bio185/", to = "live/", recursive = TRUE)
  
}

clean <- function() {
  unlink(x = c("_site", "build", "dist"), recursive = TRUE)
}

updateProjects <- function() {
  
  ps <- content( GET("https://api.github.com/orgs/WL-Biol185-ShinyProjects/repos")
               , as = "parsed"
               )
  
  projects <- lapply( ps
                    , function(p) { 
                        p$contributors <- content(GET(p$contributors_url), as = "parsed")
                        p
                      }
                    )
  
  s <- courseR:::renderTemplate( template = "templates/site/projects-page.html"
                               , data     = list( projects = projects
                                                , navbar   = courseR:::readFile("_navbar.html")
                                                , footer   = courseR:::readFile("footer.html")
                                                )
                               )
  
  cat(s, file = "dist/www/projects-page.html")
  
}
