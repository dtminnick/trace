# Load libraries
library(readr)
library(dplyr)
library(stringr)

# --- Load the data ---
gold <- read_csv("evaluation_sop_mock_001.csv")       # Gold standard
llm  <- read_csv("llm_output_sop_mock_001.csv")        # LLM-generated output

# --- Ensure same number of rows ---
if (nrow(gold) != nrow(llm)) {
  warning("Mismatch in number of rows: padding with NAs.")
  max_rows <- max(nrow(gold), nrow(llm))
  gold <- bind_rows(gold, tibble(task_id = rep(NA, max_rows - nrow(gold))))
  llm  <- bind_rows(llm,  tibble(task_id = rep(NA, max_rows - nrow(llm))))
}

# --- Fields to compare ---
fields <- c("task_name", "description", "actor", "inputs", "outputs", "tools")

# --- Comparison function ---
compare_fields <- function(gold_row, llm_row) {
  sapply(fields, function(field) {
    gold_val <- str_trim(as.character(gold_row[[field]]))
    llm_val  <- str_trim(as.character(llm_row[[field]]))
    if (is.na(gold_val) || is.na(llm_val)) return(0)
    return(as.integer(gold_val == llm_val))
  })
}

# --- Row-by-row comparison ---
comparison <- bind_rows(
  lapply(1:nrow(gold), function(i) {
    result <- compare_fields(gold[i, ], llm[i, ])
    result_df <- as.data.frame(t(result))
    result_df$row_accuracy <- mean(as.numeric(result))
    result_df
  })
)

# --- Summary stats ---
summary <- comparison %>%
  summarise(across(everything(), mean)) %>%
  pivot_longer(cols = everything(), names_to = "field", values_to = "accuracy")

# --- Save output files ---
write_csv(comparison, "evaluation_results.csv")
write_csv(summary, "evaluation_summary.csv")

print(summary)
