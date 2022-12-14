#########
#	Here I place all the small stuff I used R for
#	and the plotting scripts of RevGadget...
#


####Create all combinations of a "n" character long string using 0 and 1
n = 7
expand.grid(replicate(n, 0:1, simplify = FALSE))



#separate the ingroup from the outgroup
tree <- read.nexus("Run23.nex")
tip <- c("OG01", "OG04", "OG11", "OG12", "OG15", "OG16", "OG17", "OG07", "OG08", "OG14", "OG05", "OG13", "OG02", "OG10", "OG03", "OG09", "OG06")
ingroup <- drop.tip(tree, tip)
ingroup
write.nexus(ingroup, file="InGroup.nex")


#Install RevGadget
install.packages("magick")
devtools::install_github("cmt2/RevGadgets")


library(devtools)


install_github("GuangchuangYu/ggtree")
install_github("revbayes/RevGadgets")



setwd("../output")

library(RevGadgets)
library(coda)
library(ggplot2)
library(ggtree)
library(grid)
library(gridExtra)

file <- "Simple.ase.tre"
l <- c("1" = "A",
       "2" = "I",
       "3" = "S",
       "4" = "E",
       "5" = "M",
       "6" = "L",
       "7" = "C",
       "9" = "AS",
       "13" = "SE",
       "14" = "AM",
       "16" = "SM",
       "17" = "EM",
       "22" = "ML",
       "24" = "IC",
       "26" = "EC",
       "28" = "LC")

t <- processAncStates(path = file, state_labels = l)

#clrs <- c("wheat1", "wheat3", "yellow2", "olivedrab3", "green", "darkorange1", "forestgreen", 
#          "cornflowerblue", "turquoise3", "coral4", "mediumorchid2", "yellow4",
#          "lightskyblue4","navy", "lightcoral", "aquamarine")

clrs <- c("wheat1", "wheat3", "yellow2", "#aaffc3", "Orange", "#bfef45", "Pink", 
          "cornflowerblue", "turquoise3", "Magenta", "deeppink4", "Lavender",
          "Purple","navy", "lightcoral", "#808000")

names(clrs) <- t@state_labels

data.frame(index = 1:length(clrs), clr = clrs)

clrs <- clrs[c(1,4,5,8,10,12,14,
               2,3,6,7,9,11,13,15,16)]
data.frame(index = 1:length(clrs), clr = clrs)

#for svg file ### Doesn't work great, test different options!!!!
svg("BioGeo.svg", width = 10, height = 12)

#for pdf file
pdf("BioGeo_rectangular.pdf", width = 10, height = 12)

plotAncStatesMAP(t,
                 cladogenetic = T,
                 node_labels_as = "state_posterior",
                 timeline = T,
                 node_labels_size = 1.5,
                 node_size_as = NULL,
                 node_size = 8,
                 tree_layout = "rectangular",
                 geo_units = list("epochs", "periods"),
                 node_color = clrs)
dev.off()

#slanted tree:
pdf("BioGeo_slanted.pdf", width = 10, height = 12)
plotAncStatesMAP(t,
                 cladogenetic = F,
                 node_labels_as = "state_posterior",
                 timeline = F,
                 tip_labels = F,
                 tip_labels_states = T,
                 tip_labels_states_size = 2,
                 tip_labels_states_offset = 1,
                 node_labels_size = 1,
                 node_size_as = NULL,
                 node_size = 8,
                 tree_layout = "slanted",
                 geo_units = list("epochs", "periods"),
                 node_color = clrs)
dev.off()

#roundrect tree:
pdf("BioGeo_roundrect.pdf", width =10, height = 12)
plotAncStatesMAP(t,
                 cladogenetic = F,
                 node_labels_as = "state_posterior",
                 timeline = F,
                 tip_labels = F,
                 tip_labels_states = T,
                 tip_labels_states_size = 2,
                 tip_labels_states_offset = 1,
                 node_labels_size = 1,
                 node_size_as = NULL,
                 node_size = 8,
                 tree_layout = "roundrect",
                 geo_units = list("epochs", "periods"),
                 node_color = clrs)
dev.off()

#circular tree:
pdf("BioGeo_circular.pdf", width = 7, height = 7)
plotAncStatesMAP(t,
                 cladogenetic = F,
                 node_labels_as = "state",
                 timeline = F,
                 tip_labels = F,
                 tip_labels_states = T,
                 tip_labels_states_size = 1.2,
                 tip_labels_states_offset = 1,
                 node_labels_size = 1,
                 node_size_as = NULL,
                 node_size = 8,
                 tree_layout = "circular",
                 geo_units = list("epochs", "periods"),
                 node_color = clrs)
dev.off()
