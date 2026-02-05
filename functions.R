
library(tidyverse)

genes_df <- read.csv("data/limma-voom_luminalpregnant-luminallactate",
                     sep = "\t")
norm_counts_df <- read.csv("data/limma-voom_normalised_counts",
                           sep = "\t")


choice_vals<-names(norm_counts_df %>% select(starts_with("M")))
m_choices <- list()
for (i in 1:length(choice_vals)){
  m_choices[[ choice_vals[i] ]] = choice_vals[i]
}

# make_plotting_df  make my plotting dataframe

make_plot_df <- function(num_genes, m_samples){
  # get top ___ genes
  top_genes<-genes_df %>%
    filter(adj.P.Val < 0.01,
           abs(logFC) > 0.58) %>%
    arrange(P.Value)%>%
    slice(1:num_genes) # the 20 will eventually be interactive.
  
  # join the top genes with the normalised count data
  joined_df <- inner_join(x = top_genes,
                          y = norm_counts_df,
                          by = "ENTREZID") %>%
    select(SYMBOL.x,P.Value, logFC, starts_with("M"))
  
  # we create the plot_df
  plot_df<-joined_df %>%
    # we normalize into z-score the counts by _SYMBOL_
    select(SYMBOL.x, starts_with("M")) %>%
    
    # make it so SYMBOLS appear as column entries
    pivot_longer(cols = starts_with("M"),
                 names_to = "m_stuff",
                 values_to = "NormCounts") %>%
    pivot_wider(names_from = "SYMBOL.x",
                values_from = "NormCounts") %>%
    
    # apply across all the SYMBOLS the scaling function
    mutate(across(-c("m_stuff"),scale)) %>%
    as.data.frame() %>%
    
    # Put this back into a long format, where we have a variable
    # for m_stuff, SYMBOL, and normalized counts.
    pivot_longer(cols = -c("m_stuff"),
                 names_to = "SYMBOL",
                 values_to = "NormCounts") %>%
    as.data.frame() %>% 
    
    # Join on the P.Value, so we can reorder the SYMBOL variable
    # as a factor with levels based on P.Value.
    inner_join(x = .,
               y = top_genes,
               by = "SYMBOL") %>%
    select(m_stuff:NormCounts, P.Value) %>% 
    mutate(SYMBOL = fct_reorder(SYMBOL, -P.Value)) %>%
    filter(m_stuff %in% m_samples)
  
  return(plot_df)
}

# make_plot   make my ggplot.
make_plot <- function(num_genes, m_samples){
  plot_df<-make_plot_df(num_genes, m_samples)
  
  ggplot(data = plot_df,
         aes(x = m_stuff,
             y = SYMBOL,
             fill = NormCounts)) + 
    geom_tile() + 
    scale_fill_gradient2(low = "blue",
                         mid = 'white',
                         high = 'red',
                         midpoint = 0)+
    scale_y_discrete(position="right")+
    theme_bw()+
    theme(legend.position = "top",
          legend.title = element_blank())
}


