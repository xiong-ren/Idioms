##ignore warning messages
options(warn=-1)
library(RCurl)
library(XML)
library(stringr)

get_idioms <- function (url)
{
  ##判断网址是否存在
  urlExists = url.exists(url)
  if(urlExists){
    ##指定网页编码
    EncodedUrl <- getURL(url,.encoding="gb2312")
    #目标编码
    TargetEncodedUrl <- iconv(EncodedUrl,"gb2312","UTF-8") 
    ##转码
    Encoding(TargetEncodedUrl) 
    #选择UTF-8进行网页的解析
    parsed_doc <- htmlParse(TargetEncodedUrl,asText = TRUE,encoding="UTF-8") 
    idioms <- xpathSApply(parsed_doc,'//div/ul/li/a[@title]',xmlValue)
    return(idioms)
  }  
}

get_total_page <- function(url)
{
  ##判断网址是否存在
  urlExists = url.exists(url)
  if(urlExists){
    ##指定网页编码
    EncodedUrl <- getURL(url,.encoding="gb2312")
    #目标编码
    TargetEncodedUrl <- iconv(EncodedUrl,"gb2312","UTF-8") 
    ##转码
    Encoding(TargetEncodedUrl) 
    parsed_doc <- htmlParse(TargetEncodedUrl,asText = TRUE,encoding="UTF-8") #选择UTF-8进行网页的解析
    xpath <- '//div[@class="page"]/a[last()-1]'
    ##总页数据
    total_page <-as.numeric(xpathSApply(parsed_doc,xpath,xmlValue))
    return(total_page)
  }  
  return(0)
}


get_urls <- function()
{
  urls <- c()
  for ( i in 1:26)
  {
    urlbase <- "http://tools.2345.com/chengyu/"
    ##拼接每个字母开头成语的第一页的网址
    url <-  paste(urlbase,LETTERS[i],"/",LETTERS[i],".htm",sep = "")
    urls <-c(urls,url)
    total_page <- get_total_page(url)
    if(total_page >=2)
    {
      for(k in 2:total_page)
      {
        url <- paste(urlbase,LETTERS[i],"/",LETTERS[i],"_",k,".htm",sep = "")
        urls <- c(urls,url)
      }
    }
  }
  return (urls)
}

get_urls <- function()
{
  urls <- c()
  for ( i in 1:26)
  {
    print(c("I = ",LETTERS[i]))
    urlbase <- "http://tools.2345.com/chengyu/"
    ##拼接每个字母开头成语的第一页的网址
    url <-  paste(urlbase,LETTERS[i],"/",LETTERS[i],".htm",sep = "")
    urls <-c(urls,url)
    print(url)
    total_page <- get_total_page(url)
    print(total_page)
    if(total_page >=2)
    {
      for(k in 2:total_page)
      { print(c("k = ",k))
        url <- paste(urlbase,LETTERS[i],"/",LETTERS[i],"_",k,".htm",sep = "")
        urls <- c(urls,url)
        print(url)
      }
    }
    ##print(urls)
  }
  return (urls)
}

urls <- get_urls()
for (k in 1:length(urls))
{
  idioms <- get_idioms(urls[k])
  write.table(idioms, "A_Z.txt", sep="\t",append = TRUE,quote = FALSE,col.names = FALSE,row.names = FALSE)
}
















