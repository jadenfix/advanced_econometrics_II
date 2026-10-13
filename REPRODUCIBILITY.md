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

Use R with packages: AER, boot, car, dplyr, fixest, ggplot2, lmtest, mlogit, pscl, readxl, sampleSelection, sandwich, tidyr, tidyverse. Render coursework with `Rscript -e 'rmarkdown::render("FILE.Rmd")'`. R was unavailable in the audit environment; no R runtime success is claimed. The Greene TableF4-1 URL requires live access, and homework8 auction analysis refers to prior undefined bid_grid/F_est variables.
