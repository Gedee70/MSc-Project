library(krippendorffsalpha)
nominal=matrix(c(1,1,2,1,2,2,4,5,4,1,6,7,8,1,1,12,12,1,1,2,2,2,4,10,4,3,8,9,10,1,8,4,8,2,2,7,1,2,3,
                 10,8,1,13,1,1,2,3,11,1,10,10,1,2,8,1,4,3,2,1,1,1,
                 1,1,2,1,2,2,4,5,4,1,6,7,8,1,1,12,12,1,3,2,2,2,4,10,3,3,8,9,10,1,8,4,8,3,2,7,1,2,3,
                 10,8,1,13,1,1,2,3,11,1,10,10,1,2,8,1,4,3,2,1,1,1),61,2)
fit.nom=krippendorffs.alpha(nominal, level="nominal", confint = TRUE, method = "customary", verbose = TRUE, control=list(parallel=FALSE))
summary(fit.nom)
confint(fit.nom)
plot(fit.nom, xlim=c(0.8,1), xlab="Bootstrap Estimates", main="Interrater Agreement across 13 levels", density=FALSE)
plot(fit.nom, xlim=c(0,1), xlab="Bootstrap Estimates", main="Interrater Agreement across 13 levels", density=FALSE)
