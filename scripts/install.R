## Install required packages for the course.
check_pkgs = function(pkgs) {
  pkg_check = function(pkg) {
    chooseCRANmirror(ind = 51)                 # UK repository
    pkg_name = paste0("package:", pkg)
    pkg_inst = rownames(installed.packages())
    if (pkg_name %in% search()) {
      return()
    }
    if (!(pkg %in% pkg_inst)) {
      install.packages(pkg, dep = TRUE)
    }
    library(pkg, char = TRUE, quietly = TRUE)
  }
  if (!identical(R.Version()$minor, "3.3")) {
    warning("This course material has only been tested on R v3.3")
   } 
  invisible(sapply(pkgs, pkg_check))
  if (all(paste0("package:", pkgs) %in% search())) {
    message("All the packages have been successfully loaded.")
  }
}

pkgs = c("dplyr", "readr", "tidyr", "rmarkdown", "nycflights13",
         "lubridate", "ggplot2", "DBI", "parallel", "microbenchmark", "devtools")

check_pkgs(pkgs)

## Use frozen version of Sparklyr.
if ("package:sparklyr" %in% search())
    detach("package:sparklyr", unload = TRUE)
if ("sparklyr" %in% rownames(installed.packages()))
     remove.packages("sparklyr")
devtools::install_github("ukdataservice/sparklyr")

## Devtools instructions:
##
## 1. Install the official "devtools" package: install.packages("devtools")
## 2. Download and install Rtools: https://cran.r-project.org/bin/windows/Rtools/
## 3. Install the developmental version of "devtools": devtools::install_github("hadley/devtools")
##
## If you get some kind of strange error message mentioning "rlang_is_null":
## remove.packages("rlang")
## install.packages("rlang")

## Spark instructions:
##
## If you don't have Spark installed on your computer, type "spark_install(version = "2.1.0")" in R
## after loading the sparklyr package. If this doesn't work, download Spark 2.1.0 from:
##
## https://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz
## 
## and extract it in a directory of your choice. Then set the SPARK_HOME environment variable as
## the directory in which you extracted the .tgz file above, e.g. ~/spark-2.1.0-bin-hadoop2.7

## Fix Hive permission issue:
##
## If you're getting long error messages related to Hive permissions when dealing with Spark:
##
## 1. Set HADOOP_HOME environment variable.
## 2. Download: https://github.com/ukdataservice/bdas2017/blob/master/scripts/winutils.exe?raw=true
## 3. Place it in %HADOOP_HOME%\bin.
## 4. Run command prompt as admin and follow the instructions below:
##    (a) List current permissions: %HADOOP_HOME%\bin\winutils.exe ls \tmp\hive
##    (b) Set permissions: %HADOOP_HOME%\bin\winutils.exe chmod 777 \tmp\hive
##    (c) Verify permissions: %HADOOP_HOME%\bin\winutils.exe ls \tmp\hive


