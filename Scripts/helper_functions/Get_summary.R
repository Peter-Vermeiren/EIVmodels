get_summary <- function(df){
  cat("median and 95% CI \n======================\n ")
  print(round(apply(df[, params], 2, quantile, probs = c(0.025, 0.5, 0.975)), 2))
  
  cat("95% CI range \n======================\n")
  CIrange <- apply(df[, params], 2, quantile, probs = 0.975) - 
    print(apply(df[, params], 2, quantile, probs = 0.025))
  
  cat("Coef Var (alternative with median and 95CI \n======================\n ")
  median <- apply(df[, params], 2, quantile, probs = 0.5)
  CValt <- abs(median)/CIrange
  round(CValt, 2)
}
