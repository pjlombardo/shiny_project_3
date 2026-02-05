# Quick Reference

This Shiny App allows the user to interactively explore a heatmap between genes and mouse samples.  Using a number input, we can include a specified number of the top genes, and using a multiple select input we can select remove mouse samples.  The heatmap will adjust to those values.

This is not my example or my data.  This shiny app was inspired by the [Galaxy Tutorial here](https://training.galaxyproject.org/training-material/topics/transcriptomics/tutorials/rna-seq-viz-with-heatmap2/tutorial.html).  The data for this shiny app is available [here](https://zenodo.org/records/2529926).

[Shiny Gallery for Quick Reference](https://shiny.posit.co/r/gallery/)

### Layout description
Below a title and description, we will have our control elements (number input and a multiple selection input) across the next column.  Below everything is our heatmap which will update based on our selections and inputs.

### Inputs
The bullets below take the general form:

> shiny Component  |  **variable_name** | optional: args

* numericInput | **num_genes** | value = 5, min = 1, max = 30
* selectInput | **mouse_samples** | choices... to come

### Outputs
The bullets below take the general form:

> Shiny Component  |  **variable_name**  | (inputs required)  | optional: function used

* plotOutput | **heatmap** | () | make_plot(), which requires make_plot_df()

### Reactive components and Server

> component type | **variable_name(s)** | Events that trigger 

* fill in...


### Functions and Set up

> **make_plot_df**  |  ()  | Purpose: creates a plotting data frame based from the raw data.  This did involve quite a bit of normalization computations and data frame reshaping and joining.

> **make_plot** | () | Purpose: Calls the make_plot_df() function to make the apropriate dataframe for plotting, but then houses the ggplot code for creating the heatmap.
