setwd(here()) 


dvs <- c("del_swp_total",   "del_swp_tot_n", "del_swp_tot_s", "del_cvp_total_n", "del_cvp_total_s", "del_cvp_total")

source("df_create.r")

df$dv <- df$dv_name

# orders dv_names here. varcodes.csv defines these names - need to be in varcodes.csv first
df$dv <- factor(df$dv, levels = c( "CVP Total","CVP NOD", "CVP SOD", "SWP Total", "SWP NOD", "SWP SOD"))



z1<-   pb_mn_ann_perav_taf_nolab_rank(df) + ggtitle("Mean Annual Baseline and Scenario Delivery Volumes")+
  theme(plot.margin=grid::unit(c(2,0.5,0.5,0.5), "mm")) +
  theme(strip.text.x = element_text(size = 8)) + 
 # scale_x_discrete(label=abbreviate) + #if low enough numbers of scens, activate to turn on scen labels, eitherthis
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5))  +
  theme(axis.title.x=element_blank(),axis.text.x=element_blank(), axis.ticks.x=element_blank()) #orthis
z1
zleg <- get_legend(z1) #save the legend
z1 <- z1 + theme(legend.position= "none") #remove legend to put back as separate plot

## mean annual CVP NOD difference from baseline

dvs <- c("del_swp_total","del_swp_tot_n", "del_swp_tot_s", "del_cvp_total_n", "del_cvp_total_s", "del_cvp_total")

source("df_create.r")
df_diff$dv <- df_diff$dv_name
df_diff$dv <- factor(df_diff$dv, levels = c( "CVP Total","CVP NOD", "CVP SOD", "SWP Total", "SWP NOD", "SWP SOD"))
z2 <- pb_mn_ann_perav_taf_d_nolab_rank(df_diff) + ggtitle("Mean Annual Delivery Volume, Difference from Baseline")+
  theme(plot.margin=grid::unit(c(0.5,0.5,0.5,0.5), "mm")) +
  theme(strip.text.x = element_text(size = 8)) + 
  
  # scale_x_discrete(label=abbreviate) + #if low enough numbers of scens, activate to turn on abbrv. scen labels, eitherthis
  theme(legend.position = "none") + 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5))  +
  theme(axis.title.x=element_blank(),axis.text.x=element_blank(), axis.ticks.x=element_blank()) #orthis
z2

z <- plot_grid(z1, z2, nrow = 2, rel_heights = c(1,2.5))
z <- plot_grid(z, zleg, nrow = 1, rel_widths = c(6,1))
setwd(here("plots", "delivplot_cvpswp_n&s_rankedtots&diffs"))
ggsave("deliv_cvpswp_n&s_rankedtots&diffs.jpg", dpi = 300, width = 13.333, height = 8, units = "in") 

setwd(here("plotexportscripts"))
rm(list = ls()[grep("^z", ls())])
