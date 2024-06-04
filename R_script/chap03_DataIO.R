# chap03_DataIO_String

### 1. 데이터 불러오기

# 1) 키보드 입력 : 소량의 자료 
num <- scan() # 숫자 입력 
# 한번더 엔터 누르면 저장됨
sum(num)

# 2) 칼럼 단위 파일 읽기 
# - 칼럼 단위 구분 : csv, excel file
getwd() # 현재 경로 확인 
setwd("C:/ITWILL/5_R/R_Statistics/data") # 파일 경로 지정 

# ★★★★★★★
# [1] read.table() : 칼럼 구분(공백 or 특수문자)

# 칼럼명 없는 경우 
st <- read.table('student.txt') # 제목 없음 
st
# V1   V2  V3 V4
# 1 101 hong 175 65
# 2 201  lee 185 85
# 3 301  kim 173 60
# 4 401 park 180 70

# 칼럼명 있는 경우 & 한글 인코딩 적용  
# 첫번째 줄을 header로 가져옴 
st1 <- read.table('student1.txt', header = TRUE, , encoding="UTF-8")
st1

# 칼럼명 있는 경우 & 한글 인코딩 & 구분자(;) 적용 
st2 <- read.table('student2.txt', header = TRUE,  
                  encoding="UTF-8", sep = ";")
st2

# [2] read.csv() : 칼럼 구분(콤마)
st3 <- read.csv('student3.txt', na.strings = c("&","-"))
st3

# na.strings 는 특수문자를 결측치로 ★
# 번호  이름  키 몸무게
# 1  101  hong 175     65
# 2  201   lee 185     85
# 3  301   kim 173     NA
# 4  401  park  NA     70
mean(st3$키, na.rm = TRUE) # [1] 177.6667


########엑셀 파일 불러오기 ############
# [3] read.excel() : 패키지 설치 
install.packages('readxl') # 패키지 설치
library(readxl) # in memory
st_excel <- read_excel('studentexcel.xlsx') # excel 파일 열기 
st_excel

# 인터넷 파일 불러오기 : 데이터 셋 제공 사이트 
# http://www.public.iastate.edu/~hofmann/data_in_r_sortable.html - Datasets in R packages
# https://vincentarelbundock.github.io/Rdatasets/datasets.html
# https://r-dir.com/reference/datasets.html - Dataset site
# http://www.rdatamining.com/resources/data


##########csv 파일 불러오기 
titanic <- read.csv('https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv')
# 자료 구조 확인 
str(titanic) # 'data.frame':..

# 3) 줄 단위 파일 읽기 : text file - readLines(file)
tax = file("tax.txt", encoding="UTF-8") 
text <- readLines(tax) # 줄 단위(문장 단위) 읽기 

print(text)

table(titanic$sex) # 범주형 빈도수 확인 
# man women 
# 869   447 

# 교차 분할표 
table(titanic$sex, titanic$survived)
# no yes
# man   694 175
# women 123 324


################### 
### 2. 데이터 저장(출력)하기

# 1) 화면 출력 
x <- 100
y <- 200
z = x + y
cat('z=', z)
# 문자열과 변수 함께 출력하려면 cat함수 써야함 ★


# 변수 or 수식 
print(z)
print( x + y )


# 2) 파일 데이터 저장 

# (1) write.csv()
df <- subset(titanic, select = c(class, sex, survived) )

write.csv(df, 'titanic.csv', row.names=FALSE,  quote=FALSE)
# row.names = FALSE ; 행 이름(숫자) 제외 
# quote = FALSE ; 따옴표 제외 


# (2) write_xlsx()
install.packages('writexl') 
library(writexl)
st_excel # 위에서 연 엑셀 파일 
write_xlsx(st_excel, path = "st_excel.xlsx")


# (3) text file 저장  
file <- file('text_data.txt', encoding="UTF-8") # 파일 쓰기 객체 
writeLines(텍스트, 파일객체) # 줄 단위 저장 
close(file) # file 객체 닫기


####################
# 2024-05-09 
####################
### 3. 문자열 처리 & 정규표현식(메타문자)
# - 정규표현식 : 메타문자 등을 이용하여 패턴을 지정하는 표현식
# - 메타문자 : 패턴을 지정하는 약속된 기호 

#install.packages('stringr')
library(stringr)


# 형식) str_extract('문자열', '패턴')
str_extract('###232&^%^', '[0-9]{3}') 
# [1] "232"

# str_extract_all은 리스트 형식으로 저장 
str_extract_all('###232&^%^234**$$', '[0-9]{3}')
# [[1]]  ; 기본 key 
# [1] "232" "234" ; values들 


# 1) 반복관련 메타문자 : [x]: x1개 일치, {n} : n개 연속 
string <- "hong35lee45kang55유관순25이사도시55"

# (1) 숫자 추출 
ages <- str_extract_all(string, '[0-9]{2}')
ages
# [[1]]
# [1] "35" "45" "55" "25" "55"

# list -> vector 
ages <-unlist(ages)
ages # key제외 값들 vector로 저장 
# [1] "35" "45" "55" "25" "55"

# string -> num 
age <-as.numeric(ages)
age
# [1] 35 45 55 25 55
mode(age) # numeric

# num이니까 연산 가능~ 
mean(age) # 43

# (2) 영문 추출 
str_extract_all(string, '[a-z]{3,}')
# {3,} : 적어도 3자 이상 

# 3) 한글 이름 추출 
str_extract_all(string, '[가-힣]{3,}')


# 2) 접두어/접미어 메타문자 : ^, $
email <- "kpjiju@naver.com" # "id@호스트이름.최상도메인 
str_extract_all(email, '^[a-z]\\w{3,}@\\w{3,}.com$')
# \\w : 단어(숫자,영문,한글 혼용)
# \\d : 숫자 


# 3) 부정 메타문자 : [^x]
str_extract_all(string, '[^0-9]{3,}') 


# 4) 문자열 길이
str_length(string) 


# 5) 문자열 교체 
str_replace_all(string, '[0-9]{2}', '-')


# 6) 문자열 분리(split) 
string2 <- "홍길동,이순신,유관순"
names <- str_split(string2, ",")

vnames <-unlist(names)
# 7) 단어 -> 문장 
sent <- str_c(vnames, collapse = ' ')
# collapse는 구분자



### 4. 텍스트 마이닝 : 토픽분석(단어구름 시각화)

# 단계1 : text file read : trump.txt
trump <-file(file.choose())  # trump.txt
trump_data <- readLines(trump) # 줄 단위(문장 단위) 읽기
close(trump) # file 객체 닫기


# 단계2 : 말뭉치 생성 & 문서단어행렬
install.packages("tm") # 텍스트 마이닝 도구  
library('tm') # in memory 로딩

# 1) 말뭉치(코퍼스:Corpus) 생성 : 자연어 처리를 위한 문서 집합
myCorpus <- Corpus(VectorSource(trump_data)) # (hangle_text) 
# corpus 내용 보기
inspect(myCorpus[1]) # 첫번째 문장 :  As Prepared for Delivery - 

# (2) 문장부호 제거 
myCorpus_pre <- tm_map(myCorpus, removePunctuation) # 문장부호 제거
myCorpus_pre <- tm_map(myCorpus_pre, removeNumbers) # 수치 제거
myCorpus_pre <-tm_map(myCorpus_pre, removeWords, stopwords('english')) # 불용어제거

# (3) 문서 단어 행렬(sparse matrix)
# 2~15음절 
DTM <- DocumentTermMatrix(myCorpus_pre, 
                          control=list(wordLengths=c(2,15))) # 단어길이 제한 
DTM # 문서단어행렬 
# <<DocumentTermMatrix (documents: 24, terms: 541)>>
# Non-/sparse entries: 993/11991
# Sparsity           : 92% -> 희소비율 
# Maximal term length: 14  -> 최대음절 길이 
# Weighting          : term frequency (tf)

# 단계3 : 단어 빈도수 구하기

# (1) 문서단어행렬 -> DataFrame 변환
myDTM <- as.data.frame(as.matrix(DTM)) 

# (2) 단어빈도수 : 열단위 합계 > 내림차순 정렬
word_count <- sort(colSums(myDTM), decreasing=TRUE) # 각 단어 합계 -> 내림 정렬 
word_count[1:10] # top10 단어  


# 단계4 : 단어구름 시각화(빈도수, 색상, 랜덤, 회전 등)

# (1) 단어 추출 
myName <- names(word_count)  

# (2) 단어와 빈도수로 data.frame 생성
word_df <- data.frame(word=myName, freq=word_count) 

# (3) 단어 색상과 글꼴 지정
pal <- brewer.pal(12,"Paired") # 12가지 색상 pal <- brewer.pal(9,"Set1") # Set1~ Set3

#install.packages("wordcloud") # 단어구름 시각화  패키지 설치  
library('wordcloud') # in memory 

# (4) 단어 구름 시각화: 크기,최소빈도수,순서,회전,색상,글꼴 지정  
x11() # 윈도우 창 

# 단어구름 시각화 
wordcloud(word_df$word, word_df$freq, 
          scale=c(3,1), min.freq=2, random.order=F, 
          rot.per=.1, colors=pal, family="malgun")


##########################
## Top10 단어 비율 시각화  
##########################

# 1) 상위 10개 토픽추출
topWord <- head(sort(word_count, decreasing=T), 10) # 상위 10개 토픽추출 

# 2) 파일 차트 생성 
pie(topWord, col=rainbow(10), radius=1) 
# radius=1 : 반지름 지정 - 확대 기능  

# 3) 빈도수 백분율 적용 
pct <- round(topWord/sum(topWord)*100, 1) # 백분율

# 4) 단어와 백분율 하나로 합친다.
label <- paste(names(topWord), "\n", pct, "%")

# 5) 파이차트에 단어와 백분율을 레이블로 적용 
pie(topWord, main="Trump 대통령 후보 연설문", 
    col=rainbow(10), cex=0.8, labels=label)
