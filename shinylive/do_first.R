## do_first.R

setwd("~/code/SHINY/shinylive")
dir()

# Copy an existing app, to directory myapp

# Copy "Hello World" from `{shiny}`

# find file 
path = system.file("examples", "01_hello", package="shiny") 

# copy it
fs::dir_copy(path, "./shinylive/myapp", overwrite = TRUE)

# `convert` and download web `assets` - wait!
shinylive::export("myapp", "site")


# all is running inside browser
httpuv::runStaticServer("site")


# workflow
usethis::use_github_action(url="https://github.com/posit-dev/r-shinylive/blob/actions-v1/examples/deploy-app.yaml")
