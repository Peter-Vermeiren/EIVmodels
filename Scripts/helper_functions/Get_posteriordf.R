Get_posteriordf <- function(jags_outputs, modelname){

  params <- jags_outputs[[1]]$parameters.to.save

  if(length(jags_outputs) == 3){ ## if we are doing 3 fold cross validation
    print("posteriors for 3-fold CV model runs")
    Samples <- as.data.frame(
      rbind(jags_outputs[[1]]$BUGSoutput$sims.matrix[, params],
            jags_outputs[[2]]$BUGSoutput$sims.matrix[, params],
            jags_outputs[[3]]$BUGSoutput$sims.matrix[, params]))
    Samples$chain <- as.factor(rep(rep(c(1,2,3),
                                       each = jags_outputs[[1]]$BUGSoutput$n.keep), 3))
    Samples$CV <- as.factor(rep(c(1,2,3),
                                each = jags_outputs[[1]]$BUGSoutput$n.sims))
    Samples$chain_iter <- rep(1:jags_outputs[[1]]$BUGSoutput$n.keep, 9)
    Samples$sim_iter <- rep(1:jags_outputs[[1]]$BUGSoutput$n.sims, 3)
  }else if(length(jags_outputs) == 1){ # if it if just a single output (no 3 fold CV)
    print("posteriors for single model run")
    Samples <- as.data.frame(jags_outputs[[1]]$BUGSoutput$sims.matrix[, params])
    Samples$chain <- as.factor(rep(c(1,2,3), each = jags_outputs[[1]]$BUGSoutput$n.keep))
    Samples$chain_iter <- rep(1:jags_outputs[[1]]$BUGSoutput$n.keep, 3)
    Samples$sim_iter <- 1:jags_outputs[[1]]$BUGSoutput$n.sims
    Samples$CV <- 1
  }


  # a filter for some extreme values in the posterior MCMC
  # due to some tau extermes in censored M1b
  # i.e., kick out values above 99% interval
  if(modelname %in% c("M1b_cens_Y", "M1b_cens_X", "M1b_cens_XY")){
    filter_cutoff <- quantile(Samples$tau, 0.99)
    cat("filtered extremes beyond 99% quantile, value:", filter_cutoff)
    Samples <- Samples %>%
      filter(tau <= filter_cutoff)
  }

  return(Samples)
}
