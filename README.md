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
