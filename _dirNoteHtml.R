# dirNoteHtml.R

setwd(dirname(rstudioapi::getSourceEditorContext()$path))
rm(list=ls())
dev.off()


dirStartXxx <- function(xxx = "",d = 0, istart = NULL, nstart = NULL){

  if(d == 0) (wd_ <- dir())
  if(d == 1) (wd_ <- dir("../"))
  if(d == 2) (wd_ <- dir("../../"))
  
  if (is.null(istart) & (is.null(nstart))) (return(wd_))
  if (!is.null(istart)) (wd_ <- wd_[grep(paste("^*", istart, sep = ""), wd_, value = F)])
  if (!is.null(nstart)) (wd_ <- wd_[-grep(paste("^", nstart, sep = ""), wd_, value = F)])
  
  print(wd_)
  wd_ <- unlist(lapply(wd_, function(x) (paste("../../", x, "/", sep = ""))))
  wd_ <- sapply(wd_, function(x) (list.files(path = x, pattern = paste("*.", xxx ,"$", sep = ""))))
  return (paste(names(wd_),as.vector(wd_), sep = ""))
}

# copying
files_copying <- dirStartXxx(xxx = "html", d =2, istart = "Note")
file.copy(from = files_copying, to = getwd(), overwrite = TRUE)

# render
rmarkdown::render_site()