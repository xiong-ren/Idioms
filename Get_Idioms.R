Idioms <- read.table(file = "A.txt")
Vector_Idioms <- as.vector(as.matrix(Idioms))

getlastKey <- function(input_idioms)
{
  key <- str_sub(input_idioms, start = -1)
  return(key)
}

getfirstKeys <- function(input_idioms)
{
  key <- str_sub(input_idioms, start = 1,end = 1)
  return(key)
}


keys <- getfirstKeys(Vector_Idioms)

lookupIdioms <- function (find_idioms,max_found = 5) {
  if(length(which(Vector_Idioms == find_idioms))==0) stop ("你输入的不是成语")
  key <- getlastKey(find_idioms)
  found <- which(keys == key)
  if (length(found) > max_found) return(Vector_Idioms[found[1:max_found]])
  if (length(found) <= max_found) return(Vector_Idioms[found])
  if (length(found) == 0) return("没有找到可以接龙的成语")
}
my_idioms <- "日久见人心"
lookupIdioms(my_idioms,max_found = 5)


