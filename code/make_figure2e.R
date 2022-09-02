
####---- Create Figure 2e: distorsion induced by data reduction ----####

library("destiny")
library("ggplot2")
library("patchwork")
library("plotly")
library("scater")
set.seed(11111)

## SIMULATE DATA

## We simulate an hypothetical differentiation process based on 4 
## components that we will relate to as protein sets: 
## - protein set Z determines the progression of the differentiation
## - protein set X and Y provide a cycling process until the cell 
##   stabilize into one of two cell states.
## - protein set W determines  whether the cells are predisposed to 
##   state 1 or 2

## Create the protein set Z
n <- 1000
z <- 1:n
z <- z / 40
## Create the protein set X using the formula x = x0 + r cos(z)
r <- 5
x0 <- 0
x <- x0 + r * cos(z)
## Create the protein set Y using the formula y = y0 + r sin(z)
y0 <- 0
y <- y0 + r * sin(z)
## Create protein set W
w <- runif(n) 
## Create the 2 cell states tracks at X and Y based on W
t1 <- round(3/5 * length(x))
i <- t1:length(x)
thrs <- median(w)
isState1 <- w[i] > thrs
x0 <- x[t1]
y0 <- y[t1]
scale <- 5
x[i][isState1] <- x0 - 1:sum(isState1) / scale
x[i][!isState1] <- x0
y[i][isState1] <- y0
y[i][!isState1] <- y0 + 1:sum(!isState1) / scale
## Create the 2 cell state at equilibrium
t2 <- round(4/5 * length(x))
i <- t2:length(x)
isState1 <- w[i] > thrs
x[i][isState1] <- x[i][isState1][1]
x[i][!isState1] <- x[i][!isState1][1]
y[i][isState1] <- y[i][isState1][1]
y[i][!isState1] <- y[i][!isState1][1]
## Add biological heterogeneity unrelated to the differentiation 
## process
x <- x + runif(length(x), min = -maxNoise, max = max(x) * 0.1)
y <- y + runif(length(y), min = -maxNoise, max = max(y) * 0.1)

## Scale the components 
customScale <- function(x) {
    x <- x - min(x) ## avoid negative values
    x <- x / max(x) ## scale between [0,1]
}
x <- customScale(x)
y <- customScale(y)
z <- customScale(z)
w <- customScale(w)

## Simulate the expression matrix
## Each protein set is composed of the same number of proteins np
np <- 20
prots <- rep(1, np)
## The proteins in each protein set have increasing abundances
a <- 1:np
## Create the expression matrix for each protein set
gs1 <- prots * a %o% z / max(z)
gs2 <- prots * a %o% x / max(x)
gs3 <- prots * a %o% y / max(y)
gs4 <- prots * a %o% w / max(w)
## Combine the data in a single abundance matrix
dat <- rbind(gs1, gs2, gs3, gs4)
image(dat)

## Scale data
dat <- dat * 1E6
## Add technical noise
dat[] <- 2^rnorm(length(dat), log2(as.vector(dat + 1)), sd = 0.5)
image(dat)

## COMPUTE DIMENSION REDUCTIONS

## We here choose 3 dimension reduction techniques: PCA, t-SNE, and 
## diffusion maps

## Compute PCA
pca <- calculatePCA(dat, ntop = Inf, scale = TRUE)
## Compute tSNE
tsne <- calculateTSNE(dat, ncomponents = 2, 
                      ntop = Inf, scale = TRUE)
## Compute diffusion map
dm <- DiffusionMap(pca)

## CREATE FIGURE 2e

cellType = ifelse(w > thrs, "A", "B")
time = order(z)
pseudotime <- time / max(time)
df <- data.frame(pca, 
           tSNE = tsne,
           eigenvectors(dm),
           CellType = cellType,
           Time = time,
           Pseudotime = pseudotime)
## Assign colors based on the cell state (red or blue) and on the 
## progression of the differentiation:
## - early = green
## - intermediate = grey
## - late = blue or red
df$colors <- NA
df$colors[df$CellType == "B"] <- colorRampPalette(c("#4e9c59", "grey", "#4e819c"))(nrow(df))[df$Time[df$CellType == "B"]]
df$colors[df$CellType == "A"] <- colorRampPalette(c("#4e9c59", "grey", "#b35140"))(nrow(df))[df$Time[df$CellType == "A"]]

## 3D plot of the simulation components X, Y and Z
ply <- plot_ly(x = x, y = y, z = z, 
        type = "scatter3d",
        mode = "markers",
        marker = list(color = df$colors, size = 3)) %>% 
    layout(paper_bgcolor = rgb(1, 1, 1, 0),
           plot_bgcolor = rgb(1, 1, 1, 0),
           scene = list(xaxis = list(visible = FALSE),
                        yaxis = list(visible = FALSE),
                        zaxis = list(visible = FALSE),
                        bgcolor = rgb(1, 1, 1, 0),
                        camera = list(eye = list(x = 1.5,
                                                 y = -1.5,
                                                 z = 1),
                                      up = list(x = 0,
                                                y = 0,
                                                z = 1))))
ply
plyFile <- "figure2eA.png"
save_image(ply, normalizePath(plyFile))

## Plot of the 3 dimension reduction results
pl <- ggplot(df) +
    aes(x = PC1, 
        y = PC2) + 
    ggtitle("Principal component analysis") +
    ggplot(df) +
    aes(x = tSNE.1, 
        y = tSNE.2) +
    ggtitle("t-distributed stochastic\nneighbor embedding") +
    ggplot(df) +
    aes(x = DC1, 
        y = DC2) +
    ggtitle("Diffusion map") +
    plot_layout(design = "#1
                          23",
                guides = "collect") &
    aes(col = I(colors)) &
    geom_point() 
    theme_void() &
    theme(legend.position = "none")
pl
ggsave("figure2eBCD.svg", pl)

## The two files were assembled into Figure2e using Inkscape. 

