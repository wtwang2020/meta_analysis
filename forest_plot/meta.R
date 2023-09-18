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
setwd("D:/�α�/��ͬѧ�ĺ�����Ŀ/������/�ڶ�ƪmeta/��/ͼƬ/ɭ��ͼ")
���� <- read_delim("D:/�α�/��ͬѧ�ĺ�����Ŀ/������/�ڶ�ƪmeta/��/����/����.txt", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
#variables <- c("BBS", "FMA", "POMA-Balance", "TUG", "S-TIS2.0", "S-PASS", "S_FIST", "ABC")
variables <- ���� %>%
  select(��ֵ���) %>%
  unique() %>%
  unlist()
variables
width <- 13  # ͼ�ο��ȣ�Ӣ�磩
height <- 6 # ͼ�θ߶ȣ�Ӣ�磩
res <- 1000 # �ֱ��ʣ�dpi��
for (i in variables) {
subset_data <- ����[����$��ֵ��� == i, ]
# ѭ������ÿ������
m <- metacont(n.e = ����...5,      #�˴������Լ��޸ĵģ���Ϊ�汾���������ֲ������������б仯��
              mean.e = ����...6,  #�ֱ����ʵ���飺�������ƽ��ֵ��sd����������
              sd.e  = ��׼��...7, 
              n.c=����...8, 
              mean.c = ����...9, 
              sd.c=��׼��...10,
              studlab=paste(��һ����, ����ʱ��), #�����зֱ����������ֺ����
              data=subset_data) #���������Լ��������ϳ����ģ����ɴ���Լ��ľ���
settings.meta("Revman5")  # ����meta��ʽΪ�����revmanС��ͼ���ٺ�
pdf(file = paste(i, "_forest_plot.pdf", sep = ""), width = width, height = height, pointsize = 12)
forest_plot <- forest(m,
       squaresize = 0.4,  #���÷����С
       label.left = "Favours [Cortical screw]", 
       label.right = "Favours [Pedicle screw]",
       fixed = T) #����i���ܴ�ֻ�����ЧӦģ�;ͼӴ������֮Ϊrandom =F
dev.off()
}
