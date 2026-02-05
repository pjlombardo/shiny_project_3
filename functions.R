
genes_df <- read.csv("data/limma-voom_luminalpregnant-luminallactate",
                     sep = "\t")
norm_counts_df <- read.csv("data/limma-voom_normalised_counts",
                           sep = "\t")

top_genes<-genes_df %>%
  filter(adj.P.Val < 0.01,
         abs(logFC) > 0.58) %>%
  arrange(P.Value)%>%
  slice(1:20) # the 20 will eventually be interactive.

joined_df <- inner_join(x = top_genes,
           y = norm_counts_df,
           by = "ENTREZID") %>%
  select(SYMBOL.x,P.Value, logFC, starts_with("M"))


# ignore P.Value and logFC,  for each gene (SYMBOL.x) we want to compute a z-scores versions of the M-stuff, by row.  We can use scale() in R to do this, but dplyr prefers doing things by column, not row. 

# pivot_longer --> takes columns and makes them into a single variable, entries become a value variable.
# pivot_wider --> takes a single variable (categorical) and changes it With measurement value, into a series of columns each with column given by the categorical variable label.

plot_df<-joined_df %>%
  select(SYMBOL.x, starts_with("M")) %>%
  pivot_longer(cols = starts_with("M"),
               names_to = "m_stuff",
               values_to = "NormCounts") %>%
  pivot_wider(names_from = "SYMBOL.x",
              values_from = "NormCounts") %>%
  mutate(across(-c("m_stuff"),scale)) %>%
  as.data.frame() %>%
  pivot_longer(cols = -c("m_stuff"),
               names_to = "SYMBOL",
               values_to = "NormCounts") %>%
  as.data.frame()

ggplot(data = plot_df,
       aes(x = m_stuff,
           y = SYMBOL,
           fill = NormCounts)) + 
  geom_tile() + 
  scale_fill_gradient2(low = "blue",
                       mid = 'white',
                       high = 'red',
                       midpoint = 0)+
  theme_bw()
