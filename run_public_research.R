# Public-input research lane, separate from unavailable course XLSX files.
full_args <- commandArgs()
file_arg <- grep('^--file=',full_args,value=TRUE)
if(length(file_arg)) {
  setwd(dirname(normalizePath(sub('^--file=','',file_arg[[1L]]))))
} else if('-f' %in% full_args) {
  setwd(dirname(normalizePath(full_args[[match('-f',full_args)+1L]])))
}
set.seed(123)
dir.create('public-research-output',showWarnings=FALSE)
pnt <- read.csv('data/wooldridge_pntsprd.csv')
wage <- read.csv('data/wooldridge_wage1.csv')
tests <- read.csv('data/ucla_tobit.csv')
stopifnot(nrow(pnt)==553,nrow(wage)==526,nrow(tests)==200,sum(tests$apt==800)==17)
lpm <- lm(favwin~spread,data=pnt)
probit <- glm(favwin~spread,family=binomial(link='probit'),data=pnt)
logit <- glm(favwin~spread,family=binomial(),data=pnt)
new <- data.frame(spread=10)
sports <- data.frame(model=c('LPM','probit','logit'),probability_at_spread10=c(predict(lpm,new),predict(probit,new,type='response'),predict(logit,new,type='response')))
# Archived workbook outputs provide a numerical cross-check of the inferred data.
stopifnot(abs(coef(lpm)[1]-.57694925)<1e-7,abs(predict(logit,new,type='response')-.8265117)<1e-7)
write.csv(sports,'public-research-output/sports-probabilities.csv',row.names=FALSE)
models <- list(LPM=lpm,probit=probit,logit=logit)
for(name in names(models))write.csv(summary(models[[name]])$coefficients,paste0('public-research-output/',name,'-coefficients.csv'))
wage_model <- lm(wage~educ+exper,data=wage)
# Resample observations exactly as the assignment's empirical bootstrap.
bootstrap <- replicate(1000,{sample <- wage[sample.int(nrow(wage),replace=TRUE),];coef(lm(wage~educ+exper,data=sample))['educ']})
write.csv(data.frame(education_coefficient=bootstrap),'public-research-output/wage-bootstrap.csv',row.names=FALSE)
library(survival)
# Same Gaussian censored-likelihood family as AER::tobit, using its survival
# backend directly to avoid the unrelated broad AER dependency stack.
tests$censor_status <- ifelse(tests$apt<=0,2L,ifelse(tests$apt>=800,0L,1L))
tobit <- survreg(Surv(apt,apt,censor_status,type='interval')~read+math+prog,data=tests,dist='gaussian')
ols <- lm(apt~read+math+prog,data=tests)
# Program is nominal in the source; report a separate categorical specification.
nominal_tobit <- survreg(Surv(apt,apt,censor_status,type='interval')~read+math+factor(prog),data=tests,dist='gaussian')
write.csv(summary(nominal_tobit)$table,'public-research-output/tobit-categorical-program.csv')
write.csv(data.frame(term=names(coef(ols)),OLS=unname(coef(ols)),Gaussian_Tobit=unname(coef(tobit))),'public-research-output/tobit-comparison.csv',row.names=FALSE)
# Original homework8 problem2: analytical symmetric first-price equilibrium.
# Values follow F(v)=v^2, three bidders, so b(v)=4v/5. This simulation is a
# check of that stated theory, not a substitute for missing auction1/2.xlsx.
values <- matrix(sqrt(runif(30000)),ncol=3)
bids <- .8*values
revenue <- apply(bids,1,max)
theory_revenue <- 24/35
stopifnot(abs(mean(revenue)-theory_revenue)<.02)
v <- seq(.05,1,length.out=20)
for(value in v){
 objective <- function(b) -(value-b)*min((b/.8)^4,1)
 optimum <- optimize(objective,c(0,min(value,.8)))$minimum
 stopifnot(abs(optimum-.8*value)<.001)
}
png('public-research-output/overview.png',width=1500,height=1000,res=130)
par(mfrow=c(2,2),mar=c(4,4,3,1))
grid <- data.frame(spread=seq(0,max(pnt$spread),length.out=100))
plot(grid$spread,predict(logit,grid,type='response'),type='l',lwd=3,col='#337565',ylim=c(0,1),xlab='Point spread',ylab='Favorite win probability',main='Actual public sports data')
lines(grid$spread,predict(probit,grid,type='response'),lwd=2,col='#c5794c');legend('bottomright',c('Logit','Probit'),col=c('#337565','#c5794c'),lwd=2,bty='n')
hist(bootstrap,breaks=30,col='#a7c6b6',main='Wage education coefficient bootstrap',xlab='OLS coefficient, 1000 resamples')
plot(fitted(ols),tests$apt,col='#337565',pch=16,cex=.5,xlab='OLS fitted aptitude',ylab='Observed aptitude',main='UCLA hypothetical censored data');abline(h=800,col='#c5794c',lty=2)
plot(v,.8*v,type='l',lwd=3,col='#337565',xlab='Private value',ylab='Equilibrium bid',main='Original auction theory: F(v)=v², n=3')
dev.off()
writeLines(c('Public inputs: Wooldridge1.4-7 pntsprd/wage1 and UCLA hypothetical Tobit dataset.','Original XLSX identity is unverified. Pntsprd reproduces archived rounded LPM intercept and spread10 logit probability.',paste('Wage bootstrap resamples:',length(bootstrap)),paste('Auction theoretical mean revenue:',theory_revenue),paste('Auction simulated mean revenue:',mean(revenue)),'Original private camping, election, earnings, cars and auction workbooks remain separate.','No heldout prediction, causal identification or welfare validity is established.'),'public-research-output/execution.txt')
print(sports);print(coef(wage_model));print(summary(tobit));cat('All public-input and stated auction-theory checks passed\n')
