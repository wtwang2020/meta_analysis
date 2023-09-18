#library(mata)
library(meta)
library(readxl)
library(grid)
library(readxl)
library(readr)
library(tidyverse)
library(ggplot2)
#install.packages("showtext")
library(showtext)
#sessionInfo(meta)
#meta.version
packageVersion("meta")
font_add_google("Gochi Hand", "gochi")
font_add_google("Schoolbell", "bell")
font_add_google("Covered By Your Grace", "grace")
font_add_google("Rock Salt", "rock")
showtext_auto()
showtext_opts(dpi = 96)
setwd("D:/课本/与同学的合作项目/诉招隐/第二篇meta/新/图片/森林图")
数据 <- read_delim("D:/课本/与同学的合作项目/诉招隐/第二篇meta/新/数据/数据.txt", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#variables <- c("BBS", "FMA", "POMA-Balance", "TUG", "S-TIS2.0", "S-PASS", "S_FIST", "ABC")
variables <- 数据 %>%
  select(数值类别) %>%
  unique() %>%
  unlist()
variables
width <- 13  # 图形宽度（英寸）
height <- 6 # 图形高度（英寸）
res <- 1000 # 分辨率（dpi）
for (i in variables) {
subset_data <- 数据[数据$数值类别 == i, ]
# 循环遍历每个变量
m <- metacont(n.e = 例数...5,      #此处是我自己修改的，因为版本更迭，各种参数的名称略有变化了
              mean.e = 均数...6,  #分别代表实验组：对照组的平均值，sd，总样本量
              sd.e  = 标准差...7, 
              n.c=例数...8, 
              mean.c = 均数...9, 
              sd.c=标准差...10,
              studlab=paste(第一作者, 发表时间), #这两列分别是作者名字和年份
              data=subset_data) #数据是我自己随便从网上抄来的，换成大家自己的就行
settings.meta("Revman5")  # 设置meta格式为经典的revman小绿图，嘿嘿
pdf(file = paste(i, "_forest_plot.pdf", sep = ""), width = width, height = height, pointsize = 12)
forest_plot <- forest(m,
       squaresize = 0.4,  #设置方块大小
       label.left = "Favours [Cortical screw]", 
       label.right = "Favours [Pedicle screw]",
       fixed = T) #数据i方很大，只看随机效应模型就加此命令；反之为random =F
dev.off()
}

