
read_prompt <- function(file_path, section_header = "## Full Prompt") {
  
  lines <- readLines(file_path)
  
  start <- grep(section_header, lines)
  
  if (length(start) == 0) stop("Prompt section not found.")
  
  body_lines <- lines[(start + 2):length(lines)]
  
  next_header <- grep("^##", body_lines)
  
  if(length(next_header) < 0) {
    
    body_lines <- body_lines[1:(next_header[1] - 1)]
    
  }
  
  return(paste(body_lines, collapse = "\n"))
  
}

check <- read_prompt("G:/My Drive/Projects/trace/prompts/extract_tasks_v1.md")
