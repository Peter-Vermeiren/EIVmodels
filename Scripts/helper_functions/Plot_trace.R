Plot_trace <- function(samples, file){

  # get parameters
  params <- colnames(samples)
  if(any(params %in% "deviance")){params <- params[-which(params=="deviance")]}
  if(any(params %in% "chain")){params <- params[-which(params=="chain")]}
  if(any(params %in% "chain_iter")){params <- params[-which(params=="chain_iter")]}
  if(any(params %in% "sim_iter")){params <- params[-which(params=="sim_iter")]}
  if(any(params %in% "CV")){params <- params[-which(params=="CV")]}

  plots <- list()
  for(i in seq_along(params)){

    # data just for the plot
    plot_df <- samples %>%
      select(c(chain_iter, params[i], chain, CV))
    colnames(plot_df) <- c("chain_iter","param","chain", "CV" )


    # the plot
    plots[[i]] <- ggplot(plot_df, aes(x = chain_iter,
                                      y = param,
                                      col = chain)) +
      facet_wrap(~CV) +
      geom_line(alpha=0.5) +
      ggtitle(params[i]) +
      theme_classic()
  }

  # save plots
  png(file = file,
      res = 300, units = "cm", width = 20,height = 30)
  if(length(params) == 4){
    # p1 <- plots[[1]]
    grid.arrange(plots[[1]], plots[[2]],
                 plots[[3]],  plots[[4]],
                 ncol=1, nrow =4)
  }
  if(length(params) == 5){
    grid.arrange(plots[[1]],  plots[[2]],
                 plots[[3]], plots[[4]],
                 plots[[5]],
                 ncol=1, nrow =5)
  }
  if(length(params) == 6){
    grid.arrange(plots[[1]], plots[[2]],
                 plots[[3]], plots[[4]],
                 plots[[5]], plots[[6]],
                 ncol=1, nrow =6)
  }
  dev.off()
}
