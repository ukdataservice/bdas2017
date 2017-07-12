## Install required packages for the course.
check_pkgs = function(pkgs) {
  pkg_check = function(pkg) {
    chooseCRANmirror(ind = 51)
    pkg_name = paste0("package:", pkg)
    pkg_inst = rownames(installed.packages())
    if (pkg_name %in% search()) {
      return()
    }
    if (!(pkg %in% pkg_inst)) {
      install.packages(pkg, dep = TRUE)
    }
  }
  invisible(sapply(pkgs, pkg_check))
  if (all(paste0("package:", pkgs) %in% search())) {
    message("All the packages have been successfully loaded.")
  }
}

pkgs = c("dplyr", "sparklyr", "readr", "tidyr", "rmarkdown",
         "lubridate", "ggplot2", "leaflet", "hexbin",
         "USAboundaries", "ggmap", "raster", "rgdal",
         "profvis", "pryr", "microbenchmark")

check_pkgs(pkgs)
