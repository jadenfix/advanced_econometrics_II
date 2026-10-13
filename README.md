# Advanced Econometrics II 📈

*A Graduate-Level Toolkit for Structural Estimation and Causal Inference*

![R](https://img.shields.io/badge/R-4.3%2B-276DC3?logo=r)
![Stata](https://img.shields.io/badge/Stata-17%2B-1a5f9a)
![LaTeX](https://img.shields.io/badge/LaTeX-Typesetting-008080?logo=latex)

This repository contains implementations, lecture notes, and replication materials for an advanced graduate econometrics sequence, covering structural estimation methods and microeconometric techniques.

---

## 📚 Core Curriculum

### **Estimation Methods**
- Maximum Likelihood Estimation (Greene 14)
- Generalized Method of Moments (Greene 13)
- Simulation-Based Inference (Train 9)
- Structural Estimation (Aguirre 1, Train 2)

### **Causal Inference**
- Instrumental Variables (Greene 8, MHE 4)
- Selection Models (Greene 19)
- Demand Estimation (Aguirre 2)
- Auction Models (Aguirre 10)

### **Discrete Choice**
- Binary Choice Models (Greene 17)
- Multinomial/ Nested Logit (Train 3-4)
- Mixed Logit (Train 6)
- Dynamic Discrete Choice (Aguirre 6-8)

---

## 💻 Technical Implementations

### Structural Demand Estimation (Berry-Levinsohn-Pakes)
```r
# BLP demand estimation in R
library(BLPestimatoR)

blp_model <- estimateBLP(
  demand = brand ~ price + x1 + x2 | z1 + z2,
  market_identifier = "market",
  product_identifier = "product",
  data = automobile_data
)
```

## Executable public-input research lane

```bash
# R with the survival package is sufficient; public CSV inputs are committed.
Rscript run_public_research.R
```

Runs actual Wooldridge wage/sports regressions, a 1000-resample education-coefficient bootstrap, Gaussian censored likelihood on UCLA's public hypothetical teaching dataset, and numerical checks of the original three-bidder F(v)=v² auction equilibrium. CSV coefficients and a four-panel plot are written to public-research-output. The sports data reproduce the archived rounded LPM intercept and spread10 logit probability. Source/package versions/hashes and attribution are recorded in data/provenance.json. Original XLSX binary identity is not established; wage/UCLA data are transparently documented public counterparts. No mock model results or private-study data are invented.

The original auction block already defines bid_grid and F_est; the prior static 'undefined object' warning was incorrect. Missing auction1/auction2.xlsx, cars, camping, earnings, election and Angrist/Evans workbooks still govern their original empirical lanes. The new auction simulation validates the stated analytical problem, not those missing workbooks. Gaussian Tobit is fit through survival (the likelihood backend used by AER); original numeric-prog and a separately labeled categorical-prog specification are both exported. Neither runtime completion nor public-dataset recovery establishes causal validity or heldout forecast performance.
