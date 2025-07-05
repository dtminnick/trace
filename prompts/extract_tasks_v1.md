# Prompt Name: extract_tasks_v1

## Modifications

2025-07-06 - Baseline script.

## Purpose

This prompt is designed to extract and structure individual tasks from a
Standard Operating Procedure (SOP) for use in downstream process analysis,
AI/ML opportunity assessment, and operational modeling.

It identifies and classifies discrete tasks based on action, actor, input/output,
tooling, and conditions such as task repetition. The output is formatted as a
comma-separated values (CSV) file for import into analytics workflows.

## Use Case

This prompt is used during the early stages of operational assessment,
specifically when converting procedural documentation (SOPs) into structured
task-level data. It supports initiatives such as identifying automation or
AI/ML opportunities, evaluating task complexity, modeling workflows, and
quantifying repetitive rework. It is particularly useful in environments
where formal process models do not exist or are out of date, and SOPs
are the primary documentation source. The structured output enables
process mining, classification modeling, and integration with broader
assessment tools.

## Input

The input to this prompt is a section of SOP text, which may contain a mix of
numbered procedures, bullet points, or narrative descriptions.

The prompt expects no fixed structure in the SOP formatting.

Contextual information outside of the procedural steps (e.g., tool descriptions,
actor roles) may be used to enrich the extracted data.

## Output

The output is plain text in CSV format, with one row per task and the
following header:

task_id,task_name,description,actor,input,output,tool,task_type,repeats_conditionally

## Full Prompt

You are analyzing a Standard Operating Procedure (SOP) to extract structured
task-level data to support machine learning and AI opportunity assessments in
operations.

The SOP may include numbered steps, bulleted lists, or freeform narrative text.

Tasks may or may not include details such as inputs, outputs, or tools used.

Your role is to extract each discrete task and return it in a structured,

comma-delimited format that can be used for downstream analysis.

Extraction Instructions

For each task you identify, return a row in CSV format with the following fields,
using NA as a placeholder when a value is missing or not inferable:

task_id: Assign a unique integer ID to each task, starting from 1, and
incrementing sequentially in the order tasks appear in the SOP.

task_name: Provide a short name for the task using an action verb,
even if the source SOP uses passive or descriptive language.

description: Summarize the task in a single sentence that clearly describes
what is being done.

actor: Identify who performs the task (e.g., “Associate”, “Client”, “Manager”).

If not explicitly stated or reasonably inferred, use NA.

input: List what is needed to perform the task. If more than one input is

mentioned, separate them with commas. If not provided, use NA.

output: List what the task produces or modifies. Separate multiple outputs with commas.

Use NA if no outputs are mentioned.

tool: Identify any systems, forms, or tools used during the task (e.g., “Mainframe”,
“Salesforce”, “Workflow System”). Use commas for multiple tools or NA if none are
identified.

task_type: Categorize the task as one of the following types: transactional,
judgmental, communicative, escalation, or NA if unclear.

repeats_conditionally: Indicate whether the task may repeat due to a conditional
situation (e.g., a NIGO loop or missing data correction). Use Yes, No, or NA as
appropriate.

If a task contains subtasks, split them into separate task entries, each with
its own task ID. Maintain the original order from the SOP, and avoid combining
multiple actions into one row.

If helpful, use information from non-procedural SOP sections (such as background,
roles, or systems) to supplement task attributes like actor or tool.

Output Format

Return your results as comma-separated text in the following format, including the header row:

task_id,task_name,description,actor,input,output,tool,task_type,repeats_conditionally

Each row should represent a single task.  Delimit fields with three consecutive commas, i.e. ,,,.
