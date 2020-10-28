# Add to lockfile
lock <- renv:::lockfile("renv.lock")
# set the repositories for a lockfile
lock$repos(CRAN = "https://cran.r-project.org")
# depend on digest 0.6.22
lock$add(pacman = "pacman@0.5.1")
# write to file
lock$write("renv.lock")


# WAY BETTER SOLUTION: https://github.com/MilesMcBain/capsule
capsule::create("01-Setup.Rmd")