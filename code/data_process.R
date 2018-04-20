library("dplyr")

setwd("C:/Users/834/Desktop/dm/assignment2")

data_bp = read.csv('Building_Permits.csv',header = T)

data_bp = select(data_bp,Current.Status,Structural.Notification,Number.of.Proposed.Stories,Fire.Only.Permit,TIDF.Compliance,Proposed.Construction.Type,Site.Permit)

#Structural Notification类型中，使用“given”代替数据Y，使用“notGiven”代替空白。
data_bp$Structural.Notification <- ifelse(data_bp$Structural.Notification == "Y", "given", "notGiven")


#Fire Only Permit类型中，使用“Fpermit”代替数据Y，使用“notFPermit”代替空白。
data_bp$Fire.Only.Permit <- ifelse(data_bp$Fire.Only.Permit == "Y", "Fpermit", "notFPermit")

#Site Permit类型中，使用“Spermit”代替数据Y，使用“notSPermit”代替空白。
data_bp$Site.Permit <- ifelse(data_bp$Site.Permit == "Y", "Spermit", "notSPermit")


#TIDF Compliance类型中，使用“yes”代替数据Y，使用“no”代替空白。
data_bp$TIDF.Compliance <- ifelse(data_bp$TIDF.Compliance == "Y", "yes", "no")


#Proposed Construction Type类型中，使用“first”代替数据1，使用“second”代替数据2，使用“third”代替数据3，使用“fourth”代替数据4，使用“fifth”代替数据5。
data_bp$Proposed.Construction.Type[is.na(data_bp$Proposed.Construction.Type)] <- 'noType'

data_bp[data_bp$Proposed.Construction.Type == '1','Proposed.Construction.Type'] = 'first'
data_bp[data_bp$Proposed.Construction.Type == '2','Proposed.Construction.Type'] = 'second'
data_bp[data_bp$Proposed.Construction.Type == '3','Proposed.Construction.Type'] = 'third'
data_bp[data_bp$Proposed.Construction.Type == '4','Proposed.Construction.Type'] = 'fourth'
data_bp[data_bp$Proposed.Construction.Type == '5','Proposed.Construction.Type'] = 'fifth'




#Number of Proposed Stories类型中，小于20的为“few”，大于20小于40的为“medium”，大于40的为“large”
data_bp$Number.of.Proposed.Stories[is.na(data_bp$Number.of.Proposed.Stories)] <- -1

data_bp[data_bp$Number.of.Proposed.Stories == -1,'Number.of.Proposed.Stories'] = 'unknown'
data_bp[data_bp$Number.of.Proposed.Stories >=  0.0 & data_bp$Number.of.Proposed.Stories< 20.0,'Number.of.Proposed.Stories'] = 'few'
data_bp[data_bp$Number.of.Proposed.Stories >= 20.0 & data_bp$Number.of.Proposed.Stories< 40.0 ,'Number.of.Proposed.Stories'] = 'medium'
data_bp[data_bp$Number.of.Proposed.Stories >= 40.0,'Number.of.Proposed.Stories'] = 'large'

write.csv(data_bp,file = "DATA_BP.csv",row.names = F)



