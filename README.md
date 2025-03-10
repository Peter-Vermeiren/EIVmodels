# EIVmodels

This repository contains the code, data, and outputs used in the publication:
Vermeiren, Charles, C. Munoz (2025): Quantifying the relationship between observed variables that contain censored values using Bayesian error-in-variables regression
Preprint: https://hal.science/hal-04764660

To reconstruct the analyses, use the code in the Scripts folder, specifically, "Run_models" to calibrate the different model versions to the data, including censored datasets. (The results are saved as RData files in "Scripts/Model runs"). Then, the "postprocess..." files take the JAGS outputs (from Scripts/Model runs") and use them to validate the models, select the best model, make plots, etc...

If you are interested in the EIV models in JAGS, the txt files with the JAGS models are in Scripts/JAGS_models

If you are interested in the data or the plots from the paper, check the Data and Outputs folders.
