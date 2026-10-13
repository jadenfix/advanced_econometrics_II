# Reproducibility boundaries

Run from the repository root; workstation-specific dataset paths now resolve by original basename. Original studies require their original datasets; no fabricated replacement is supplied.

## Missing input files

- `HansfordGomez.csv`
- `ang_ev_1980.xlsx`
- `auction1.xlsx`
- `auction2.xlsx`
- `campingdemand.xlsx`
- `cars.xlsx`
- `earndata.xlsx`
- `pntspread.xlsx`
- `testscr.xlsx`
- `wage.xlsx`

## Execution

Use R with packages: AER, boot, car, dplyr, fixest, ggplot2, lmtest, mlogit, pscl, readxl, sampleSelection, sandwich, tidyr, tidyverse. Render coursework with `Rscript -e 'rmarkdown::render("FILE.Rmd")'`. The original full coursework still requires those missing files and packages. The separate `Rscript run_public_research.R` lane executes on committed public inputs with core R and survival: 553 basketball, 526 wage and 200 hypothetical Tobit observations, a 1,000-replicate wage bootstrap, and 10,000-auction simulation of the stated analytic model. Public counterparts match archived basketball coefficients; workbook binary identity is not established. The Greene TableF4-1 URL requires live access. Contrary to an earlier audit note, the final homework8 chunk defines bid_grid and F_est itself; its actual missing dependencies are the auction workbook observations. See README and data/provenance.json for the bounded executed lane.
