
## To run shiny in the browser (ie shinylive)
## do_first.R



setwd("~/code/shiny_project/shinylive")
dir()

# Copy an existing shiny app, to directory shinylive/myapp

# Example: Copy "Hello World" from `{shiny}`

# find file 
path = system.file("examples", "01_hello", package="shiny") 

# copy it  (~/code/shinylive/myapp) creates `myapp` for you.
fs::dir_copy(path, "./myapp", overwrite = TRUE)

# `convert` and download web `assets` - wait!  (both myapp, site under shinylive)
shinylive::export("myapp", "site")


# To preview:  all is running inside browser
httpuv::runStaticServer("site")



# workflow - does what?
usethis::use_github_action(url="https://github.com/posit-dev/r-shinylive/blob/actions-v1/examples/deploy-app.yaml")
