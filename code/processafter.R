library("Matrix")
library("arules")
setwd("C:/Users/834/Desktop/dm/assignment2")

#加载数据
dataBP = read.transactions("DATA_BP.csv",format="basket",sep=",",rm.duplicates=TRUE)
#得到频繁项集并保存
frequentsets=eclat(dataBP,parameter=list(support=0.05,maxlen=7))
write(frequentsets, file="frequentsets.csv", sep=",", quote=TRUE, row.names=FALSE) 
#查看频繁项集
inspect(frequentsets)
inspect(sort(frequentsets)[1:10])

#使用apriori算法得到关联规则
rules = apriori(dataBP,parameter = list(support = 0.1,confidence = 0.8,minlen=2)) 
#查看规则总体状态和具体规则的前10项
summary(rules)
inspect(rules[1:10])

#根据提升度对关联结果降序排序并查看前10项
rules.sorted = sort(rules, decreasing=TRUE, by="lift")


#加载包arulesViz， 画出关联规则的图形表示方法
library(arulesViz)
plot(rules.pruned)
plot(rules.pruned, method="graph", control=list(type="items"))
plot(rules.pruned, method="paracoord", control=list(reorder=TRUE))