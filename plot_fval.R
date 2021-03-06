library(mapproj)
fvals <- read.csv("output/sampled_fval_mat.csv")
colnames(fvals) <- c("x","y","z","tx","ty","tz","fval","theta","phi")
proj <- mapproject(fvals$theta, fvals$phi, projection = "orthographic")
plot(proj)
