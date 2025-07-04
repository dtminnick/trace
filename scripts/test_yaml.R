
library("yaml")

patterns <- yaml::read_yaml("G:/My Drive/Projects/signal_patterns.yml")

tag_task <- function(description, patterns) {
  tags <- c()
  desc <- tolower(description)
  
  for (category in names(patterns)) {
    match_found <- FALSE
    
    for (kw in patterns[[category]]$keywords) {
      if (grepl(kw, desc, fixed = TRUE)) {
        # check exclusion
        if (!any(sapply(patterns[[category]]$excluded_terms, function(ex) grepl(ex, desc, fixed = TRUE)))) {
          tags <- c(tags, category)
          break
        }
      }
    }
  }
  
  if (length(tags) == 0) return("none") else return(paste(tags, collapse = ";"))
}


tasks_df$ai_opportunity_tag <- sapply(tasks_df$description, tag_task, patterns = patterns)