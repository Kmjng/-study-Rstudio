# 수업내용 
# 1. 세션과 R명령문 실행  
# 2. 패키지 사용법 
# 3. 변수와 자료형
# 4. 자료형 변환  
# 5. 기본함수와 데이터셋 사용
# 6. 작업경로 


# 1. 세션과 R명령문 실행

# 1) 세션(session) : 현재 수행되는 R실행 환경  
sessionInfo() # {utils}라는 패키지에 포함됨
# R버전, OS 정보, 다국어(locale:), base packages(7개)

# 2) R명령문 2가지 

# (1) 줄 단위 : 
r <- rnorm(1000) # 정규분포를 따르는 난수 1000개 
print(r) # 콘솔 출력 
hist(r) # Plots (시각화)
mean(r) # 평균 
sd(r) # 표준편차

# (2) 블럭 단위 (한번에 드래그해서 실행)
# 결과물 pdf로 저장하기 
pdf("hist.pdf") # open
hist(r)
dev.off() # close


# 2. 패키지 사용법

# ※ 주의 : 컴퓨터 이름 '한글' - 패키지 설치 오류 발생 

# 1) 설치 가능한 패키지 확인 
dim(available.packages()) # Dimension 형태로 알려줌
# >> [1] 20640    17


# 2) 패키지 설치 : 기본 패키지 30개 이미 설치 
#install.packages('패키지명') 
install.packages('stringr')
# stringr뿐아니라 의존성 패키지까지 설치해줌 

# 3) 설치된 패키지 검색 
rownames(installed.packages()) 

# 4) 패키지 설치 경로 
.libPaths() # 패키지들의 물리적 경로를 알려줌
#[1] "C:/Users/itwill/AppData/Local/R/win-library/4.4" : 사용자 설치
#[2] "C:/Program Files/R/R-4.4.0/library" : 기본 패키지 30개 설치 경로



# 5) 패키지 사용 

# stringr 패키지 활용하기 
library(stringr) # 메모리로 올림 (인메모리)
library(help='stringr') # 패키지 정보 제공

string <- '홍길동35유관순25' # 객체 


str_extract_all(string, '[0-9]{2}') # '35','25'
str_extract_all(string, '[가-힣]{3}') # '홍길동','유관순'

# 6) 패키지 삭제 
remove.packages('패키지명') 
# 삭제 시 의존성패키지는 삭제되지 않는다. 


#---------------------#

# 3. 변수와 자료형 

# 1) 변수(참조변수) : 자료(객체)가 저장된 메모리 주소 

# 2) 변수 작성 규칙 
# - 시작 영문, 숫자 혼용, 특수문자(_, .) 
# - 주의 : 명령어, 패키지, 함수명 사용 불가 
# - 대문소자 구분 
# - 가장 최근 값으로 수정 

kor <- 90
mat <- 80
tot = kor + mat 
tot # print(tot)

# 단일 객체 vs 복수 객체 
name <- "홍길동" 
age <- 35

# 복수 객체 
names <- c("홍길동", "이순신", "유관순") 
ages <- c(35, 45, 25)

# 3) 자료형(data type) : 숫자형, 문자형, 논리형 등
int <- 1000
string <- '우리나라 대한민국'
boolean <- TRUE 

# mode(변수) #자료형 확인인 (파이썬에서는 .mode() 최빈수)
mode(int) # numeric
mode(string) # character
mode(boolean) # logical

# is.xxx(변수) -> T/F
is.numeric(int) # TRUE # 정수형이냐 
is.character(int) # FALSE # 
is.logical(boolean) # TRUE
is.na() # 결측치 여부 
score <-c(70,70, NA, 40)
is.na(score)
# [1] FALSE FALSE  TRUE FALSE


# 4. 자료형 변환(Casting)
# as.xxxx(변수)

# 1) 문자형 -> 숫자형 
x <- c(10, 20, 30, '40')
mode(x) # "character"
sum(x) # error
barplot(x) # error 

# 숫자형 변환 
num <- as.numeric(x) 


# 2) 요인형(Factor) 변환 
# 요인형은 범주형
# 범주형(category)변수 -> 가변수(dummy) 변환
# 기계학습에서 문자형 자료 -> 숫자형 자료 
# 예1) 회귀계열에서 독립변수(설명변수) 범주형 
# 예2) 트리계열에서 종속변수(반응변수) 범주형 

# 범주형 변수 
gender <- c("M","F","F","M","M")
gender # "M" "F" "F" "M" "M"
mode(gender) # >> character

# (1) 요인형 변환 ★★★★★
fgender <- as.factor(gender)
fgender
#[1] M F F M M
#Levels: F M

# (2) levels 재정의
# Levels; 요인형 변수가 가질 수 있는 각각의 범주
fgender <- factor(x=fgender, levels = c('M', 'F')) 
fgender
#[1] M F F M M
#Levels: M F
mode(fgender) # >> "numeric" 
# 요인형 변수를 
# numeric으로 처리하여 각 레벨을 숫자로 매핑

# (3) 요인형 변환시 주의사항 
num <- c(4, 2, 4, 2)
# 숫자형 -> 요인형  ★★★★
fnum <- as.factor(num)
fnum
# 요인형 -> 숫자형 : 잘못된 결과 
num2 <- as.numeric(fnum)
num2 # 2 1 2 1
# 요인형 -> 문자형 ★★★★
snum <- as.character(fnum) 

# 3) 날짜형 변환 
Sys.Date() # "2024-05-02"
Sys.time() # "2024-05-02 12:42:01 KST"

today <- "2024-05-02 12:42:01 KST"
mode(today) # "character"

# as.Date() ;시간 제외 날짜정보만 
ctoday <- as.Date(today, "%Y-%m-%d %H:%M:%S")
ctoday # >> "2024-05-02"
mode(ctoday) # "numeric"
class(ctoday) # "Date" 


# strptime() ; 날짜&시간 으로 변환 
ctoday2 = strptime(today, '%Y-%m-%d %H:%M:%S')
ctoday2
mode(ctoday2) # "list"
class(ctoday2) #  "POSIXlt" "POSIXt" 



# 영어식 날짜(주식정보) -> 한국식 날짜 변환 

edate <- '02-May-24' # 월 약자 : 2024-05-02

# 다국어 정보 확인 ★
Sys.getlocale()

# 다국어 정보 수정 : 영어권 
Sys.setlocale(locale = 'English_USA')
# 현재의 다국어 상태에서(지금은 영어) 다른 포맷으로 변경 가능 
kdate <- as.Date(edate, "%d-%b-%y")
kdate # "2024-05-02"

# 다시 다국어정보 변경해준다.
Sys.setlocale(locale = 'Korean_Korea')


# ----------------------# 

# 5. 기본함수와 데이터셋 사용

# 1) 기본함수 : 7개 base 패키지에서 제공하는 함수 
help(mean) # 함수 도움말 
args(mean) # 인수 보기 ★★★★ 
example(mean) # 예제 보기 

# 실습1
x <- c(0:10, 50) 
xm <- mean(x)
c(xm, mean(x, trim = 0.10))
# [1] 8.75 5.50

# 실습2
x2 <- c(0:10, 50, NA)
xm2 <- mean(x2, na.rm = TRUE) # na.rm 
c(xm2, mean(x, trim = 0.10))
# na.rm=FALSE면, [1]  NA 5.5
# na.rm=TRUE면,[1] 8.75 5.50


# 2) 기본 데이터셋 제공 
# 나일강 데이터셋 
data()
data(Nile) # 메모리 로딩 
print(Nile)
plot(Nile)
# 6. 작업경로 
getwd() # 현재 작업경로 확인 
# get working directory
# [1] "C:/ITWILL/5_R/R_Statistics/R_script"

setwd("C:/ITWILL/5_R/R_Statistics/data") # 작업경로 변경 

emp <- read.csv("emp.csv")
emp


