#install if necessary
install.packages('gtools')
#load library
library(gtools)
library(plyr)
#urn with 3 balls
x <- (c( 'PAL',  'PEA'  ,'PES',	'PFL',	'PPH',	'PSH',	'PSL',	'PTR',	'PTS',	'PWA',	'PWF',	'PWH',	'PWT',	'PWW',	'PWX',	'PEF',	'PNC'))
            for (j in 1:17)
                {
            dat<-(data.frame(combinations(n=17,r=j,v=x,repeats.allowed=F)))
          
            dat.sort = t(apply(dat, 1, sort))
            dat<-data.frame(dat[!duplicated(dat.sort),])
            Buffer<-data.frame(assign(paste0("b", j),dat ));
                }

h<-data.frame(rbind.fill(b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17))
h <- data.frame(lapply(h, as.character), stringsAsFactors=FALSE)
h[is.na(h)] <- ' '
#write.table(h, "c:/mydata.txt", sep="\t")
g<-data.frame(apply(h, 1, paste, collapse="+"))
g <- data.frame(lapply(g, as.character), stringsAsFactors=FALSE)

for (n in 1:nrow(g))
  {
  g[n,1]<-as.character(gsub('^[+]*|[+ ]*$', '', g[n,1]),quote=FALSE)
}

write.table(g, "c:/mydata.csv", sep="\t",col.names=FALSE,row.names=FALSE,quote=FALSE)
g<-read.csv('c:/mydata.csv',stringsAsFactors=FALSE,header=FALSE)
newg<-g
for (n in 1:nrow(g))
{
  g[n,1]<-as.character(gsub('^[ +]*|[+ ]*$', '', g[n,1]),quote=FALSE)
}

write.table(g, "c:/mydata.csv", sep="\t",col.names=FALSE,row.names=FALSE,quote=FALSE)
g<-read.csv('c:/mydata.csv',stringsAsFactors=FALSE,header=TRUE)
newg1<-data.frame(g)
newg<-data.frame(g)
newgbuffer<-data.frame(g)
    for(k in 1:nrow(g))
      {
      newg1[k,1]<-(as.character((gsub("(.*)(PAL)(.*)", "\\1\\3", g[3,1] ))))
      newg[k,1]<-(as.character((gsub("(.*)(PAL)(.*)", "\\2", g[3,1] ))))
       }



df1<-data.frame(lapply(df, as.character), stringsAsFactors=FALSE)

# 
column<-c("PES-PSA","PES","PWS","PWA","PES+PWA+PWH")
column[grep("PES+PSA",column)]

write.table(g, "c:/mydatanew.csv", sep="\t",col.names=FALSE,row.names=FALSE,quote=FALSE)


