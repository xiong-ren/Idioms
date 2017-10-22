##ignore warning messages
options(warn=-1)
library(RCurl)
library(XML)
library(stringr)



##读取首字母为A-z的成语
for (i in 1:26) {
urlbase <- "http://tools.2345.com/chengyu/"
url <-  paste(urlbase,LETTERS[i],"/",LETTERS[i],".htm",sep = "")
##url <- "http://tools.2345.com/chengyu/A/A.htm"
urlExists = url.exists(url)
if(urlExists){
  txt <- getURL(url,.encoding="gb2312")
  txt2 <- iconv(txt,"gb2312","UTF-8") #转码
  Encoding(txt2) #UTF-8
  doc <- htmlParse(txt2,asText = TRUE,encoding="UTF-8") #选择UTF-8进行网页的解析
  content <- xpathSApply(doc,'//div/ul/li/a[@title]',xmlValue)
  write.table(content, "A.txt", sep="\t",append = TRUE,quote = FALSE,col.names = FALSE,row.names = FALSE) 
  xpath <- '//div[@class="page"]/a'
  pagecontent <- xpathSApply(doc,xpath,xmlValue)
  total_page <- pagecontent[length(pagecontent)-1]
  
}  

for(j in 2:total_page)
{
  url <- paste(urlbase,LETTERS[i],"/",LETTERS[i],"_",j,".htm",sep = "")
  ##url <- paste("http://tools.2345.com/chengyu/A/A_",i,".htm",sep = "")
  txt <- getURL(url,.encoding="gb2312")
  txt2 <- iconv(txt,"gb2312","UTF-8") #转码
  Encoding(txt2) #UTF-8
  doc <- htmlParse(txt2,asText = TRUE,encoding="UTF-8") #选择UTF-8进行网页的解析
  content <- xpathSApply(doc,'//div/ul/li/a[@title]',xmlValue)
  write.table(content, "A.txt", sep="\t",append = TRUE,quote = FALSE,col.names = FALSE,row.names = FALSE) 
}
##print(LETTERS[i])
}







