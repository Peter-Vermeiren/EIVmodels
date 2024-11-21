Get_samplesize <- function(jags_outputs){
  params <- jags_outputs[[1]]$parameters.to.save
  params <- params[-which(params=="deviance")]
  EffSamp_mat <- matrix(NA,
                        nrow=length(jags_outputs),
                        ncol= length(params))
  for(i in seq_along(jags_outputs)){
    effS <- effectiveSize(jags_outputs[[i]])
    EffSamp_mat[i,]  <- effS[-which(names(effS)=="deviance")]
  }
  colnames(EffSamp_mat) <- names(effS)[-which(names(effS)=="deviance")]
  return(EffSamp_mat)
}
