install.packages("bupaverse")
install.packages("readxl")
install.packages("processanimateR")

library("bupaverse") #Process mining library for multiple packages https://cran.r-project.org/web/packages/bupaverse/index.html
library(readxl) #Reads a excel file to get data
library(processanimateR) # Used to animate process maps

##--Load Data-----------------------------------------------------------------

##Read a excel file to import data into R

##Note my data contains the following if you wanted to match the format:
##Event_ID, Local_Referral_ID, RTT_ID, Waiting_List_Type, Treatment_Function_Code, Referral_Source, Org_Code, RTT_Status, Event, Event_Date_Time

##The Event_ID is the unique identifier which is the same for 1 patients pathway.

data <- read_excel("C:/Users/RubyNicholls/Downloads/ArtificialPatientTreatment_Data.xlsx", 
                                          col_types = c("numeric", "text", "text", 
                                                         "numeric", "numeric", "text", 
                                                     "text", "date"))

##View data that's been imported
View(data)

##--Prepare Data and Create Event Log---------------------------------------

## https://bupaverse.github.io/docs/create_logs.html

##Add a row number to data
data$row_num <- seq.int(nrow(data))

##Add column called lifecycle_id with text 'Start' against each row
data$lifecycle_id <- "Start"

##Create Event Log from data by selecting columns against the fields needed in event log
event_log <- data %>%
  eventlog(case_id = "Event_ID",
           activity_id = "Event",
           resource_id = "Organisation",
           activity_instance_id = "row_num",
           lifecycle_id = "lifecycle_id", 
           timestamp = "Event_Date_Time")

##--Create different variations of static process maps-------------------------

## https://bupaverse.github.io/docs/frequency_maps.html

##Output a absolute frequency map (ie how many times each event has happened)
event_log %>%
  process_map(frequency("absolute"))

##Output a relative map (ie the % each pathway follows a set of events.)
event_log %>%
  process_map(frequency("relative"))

##Output a relative consequent map (ie what happens before each event. The % in the event itself will represent the % of activity out of all activity.)
event_log %>%
  process_map(frequency("relative-consequent"))

##Output a process map that shows average days between each event
event_log %>% process_map(performance(mean,"days"))

##Output a process map that shows maximum days between each event
event_log  %>% process_map(performance(FUN = max))


event_log %>% processing_time("activity") %>% plot()

##--Adjust to show percentile of static process maps and adjust visuals-------

# Create process map (top 70% traces) changing direction of output from top to bottom
## Codes - Instead of a left-right (LR) layout, the rankdir can be set to TB (top-bottom), BT (bottom-top) or RL (right-left).
event_log %>% filter_trace_frequency(percentage = 0.70) %>% 
  process_map(type_nodes = frequency("absolute_case"),
              type_edges = performance(median, "hours", "inter_start_time"),
              sec_edges = frequency("relative"),
              rankdir="TB")


# Create process map (top 80% traces) and adjust the colours against  frequency and performance
event_log %>% filter_trace_frequency(percentage = 0.80) %>% 
  process_map(type_nodes = frequency("absolute_case", color_scale = "PuBu"),
              type_edges = performance(median, "days", "inter_start_time", color_edges = "dodgerblue4"),
              sec_edges = frequency("relative"))

## Create a process map with % of cases & total cases for 80th percentile

event_log %>% filter_trace_frequency(percentage = 0.80) %>%
  process_map(type = frequency("relative_case"),
              sec = frequency("absolute"))

##--Combine measures on static process maps------------------------------------

## Both primary and secondary layers can be differentiated between nodes and edges.
event_log %>% filter_trace_frequency(percentage = 0.80) %>%
process_map(type_nodes =  frequency("relative_case"),
            type_edges = performance(units = "days"),
            sec_nodes = frequency("absolute"),
            sec_edges = performance(FUN = max, units = "days"))

##--Create animated process maps that visualise flow--------------------------

##Create data limited to 80th percentile
NHS_Process_Map <- event_log %>% filter_trace_frequency(percentage = 0.80)

##Create a process map to use for animation (using data limited to 80th percentile)
animate_process(NHS_Process_Map, mapping = token_aes(color = token_scale("red")))

##--Create a process matrix --------------------------------------------------
## shows a grid by event and how often they're found in your event data

## https://bupaverse.github.io/docs/process_matrix.html

event_log %>%
  process_matrix(frequency("absolute")) %>%
  plot()

##--Create dotted charts -----------------------------------------------------
## A dotted chart is a graph in which each activity instance is displayed by a dot. The x-axis refers to the time aspect, while the y-axis refers to cases

## https://bupaverse.github.io/docs/dotted_chart.html

##If you don't have time present in your dataset, then everything will default to your default date eg midnight
##----------------------------------------------------------------------------

event_log %>%
  dotted_chart(x = "absolute")

##-- Create a trace explorer

event_log%>%
trace_explorer(n_traces = 10,
               coverage_labels = c("cumulative", "relative"))