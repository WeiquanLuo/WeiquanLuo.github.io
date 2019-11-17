# dirNoteHtml.R
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
rm(list=ls())
dev.off()
library(dplyr)
library(purrr)

xxx = "html"
d =2
istart = "Note"

dirStartXxx <- function(xxx = "",d = 0, istart = NULL, nstart = NULL){

  if(d == 0) (wd_ <- dir())
  if(d == 1) (wd_ <- dir("../"))
  if(d == 2) (wd_ <- dir("../../"))
  
  if (is.null(istart) & (is.null(nstart))) (return(wd_))
  if (!is.null(istart)) (wd_ <- wd_[grep(paste("^*", istart, sep = ""), wd_, value = F)])
  if (!is.null(nstart)) (wd_ <- wd_[-grep(paste("^", nstart, sep = ""), wd_, value = F)])
  

  wd_ <- data.frame(folder_ = wd_, stringsAsFactors = FALSE)
  wd_ <- wd_ %>% mutate(dir_ = purrr::map(folder_ , function(x) paste("../../", x, "/", sep = "")))
  wd_ <- wd_ %>% mutate(file_ = paste0( dir_, folder_, ".html"))
  print(wd_)
  return (wd_)
}

# copying
files_copying <- dirStartXxx(xxx = "html", d =2, istart = "Note")
file.copy(from = files_copying$file_, to = file.path(getwd(),"Note"), overwrite = TRUE)

# render
rmarkdown::render_site()