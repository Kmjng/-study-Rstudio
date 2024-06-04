# chap06_DataHandling_Sampling

################################################
# 1. dplyr 패키지 활용
################################################

# dplyr 패키지와 
install.packages("dplyr") # plyr 패키지 업그레이드 
library(dplyr)

# 1) %>% : 파이프 연산자 : df 조작에 필요한 함수 나열 기능
# 형식) df %>% func1() %>% func2()
iris %>% head() %>% filter(Sepal.Length >= 5.0) 


# 2) tibble() 함수 : 콘솔 크기에 맞는 데이터 구성
iris_df <- tibble(iris) # 콘솔 크기에 맞는 데이터 구성 
iris_df

# 3) filter() 함수 : 행 추출
# 형식) df %>% filter(필터조건)
iris %>% filter(Sepal.Width > 3) %>% head()


# 4) arrange()함수 : 칼럼 기준 정렬 
# 형식) df %>% arrange(칼럼명)
iris %>% arrange(Sepal.Width) %>% head() # 오름차순 
iris %>% arrange(Sepal.Width) %>% tail()


# 5) select()함수 : 열 선택
# 형식) df %>% select(칼럼명)
iris %>% select(Sepal.Length:Petal.Length, Species) %>% head() 


# 6) mutate() 함수 : 파생변수(변형) 생성
# 형식) df %>% mutate(변수 = 식)
iris %>% mutate(diff = Sepal.Length - Sepal.Width) %>% head()


# 7) summarise()함수 : 통계 
# 형식) df %>% summarise(변수 = 내장함수)
iris %>% summarise(col1_avg = mean(Sepal.Length),
                   col2_sd = sd(Sepal.Width))


# 8) group_by()함수 : 집단변수 이용 그룹화 
# 형식) df %>% group_by(집단변수)
iris_grp <- iris %>% group_by(Species)

# 그룹별 통계 
summarise(iris_grp, mean(Sepal.Length))


# 9) left_join() 함수 : 왼쪽 dataframe의 x칼럼 기준 열 합치기  
df1 <- data.frame(x=1:5, y=rnorm(5))
df2 <- data.frame(x=c(1:3,5:6), z=rnorm(5))

df_join <- left_join(df1, df2, by='x') # x칼럼 기준 : right_join()


# 10) right_join() 함수 : 오른쪽 dataframe의  x칼럼 기준 열 합치기 
df_join <- right_join(df1, df2, by='x') # 결과 동일 


# 2개 데이터프레임 생성 
df1 <- data.frame(x=1:5, y=rnorm(5))
df2 <- data.frame(x=6:10, y=rnorm(5))

# 11) bind_rows() : 행 합치기 
df_rows <- bind_rows(df1, df2)


# 12) bind_cols() : 열 합치기 
df_cols <- bind_cols(df1, df2)


######################################################
# 2. reshape2 패키지 활용
######################################################
install.packages('reshape2')
library(reshape2)

# 1) dcast()함수 이용 : 긴 형식 -> 넓은 형식 변경
# - '긴 형식'(Long format)을 '넓은 형식'(wide format)으로 모양 변경

data <- read.csv(file=file.choose()) # data.csv
data

# data.csv 데이터 셋 구성 - 22개 관측치, 3개 변수
# Date : 구매날짜
# Customer : 고객ID
# Buy : 구매수량

# (1) '넓은 형식'(wide format)으로 변형
# 형식) dcast(데이터셋, row ~ col, FUNC)
# 앞변수 : 행 구성, 뒷변수 : 칼럼 구성

wide <- dcast(data, Customer_ID ~ Date, sum) # 구매합계 
wide # Buy 칼럼을 이용해서 교차셀에 합 표시 

wide2 <- dcast(data, Customer_ID ~ Date, length) # 구매회수 
wide2

# 2) melt() 함수 이용 : 넓은 형식 -> 긴 형식 변경
#   형식) melt(data, id='열이름')

# - 긴 형식 변경
long <- melt(wide, id='Customer_ID') 
long

# id변수를 기준으로 넓은 형식이 긴 형식으로 변경

# 칼럼명 수정
colnames(long) <- c("Customer_ID", "Date", "Buy")   
head(long)


# 3) acast() 함수 : 3차원 형식으로 변경
# 형식) acast(dataset, 행~열~면) 
data('airquality') # airquality  New York Air Quality Measurements
airquality
str(airquality) # data.frame':	153 obs. of  6 variables:

# [월, 일] 기준으로 나머지 4개 칼럼을 묶어서 long 형식 변경 
air_melt <- melt(airquality, id=c("Month", "Day"), na.rm=TRUE) # 결측치 제외
dim(air_melt) # 568 4

# [일, 월, variable] 칼럼을 3차원 형식으로 변형   
air_acast<- acast(air_melt, Day ~ Month ~ variable) # [31,5,4]



### 3. Data_Sampling

# 1. sample(n, size)
sample(x=10:20, size=5, replace = FALSE) # 비복원
sample(c(10:20, 30:40), size=10, replace = TRUE) # 복원추출 


# 2. up/down 샘플링  
# - 복원추출 방식 y변수의 비율을 맞추는 샘플링 방식 

install.packages('caret')
library(caret)

weather <- read.csv('C:/ITWILL/5_R/R_Statistics/data/weather.csv')
dim(weather) # 366  15
str(weather) 
table(weather$RainTomorrow)


# y변수 요인형 변경 
weather$RainTomorrow <- as.factor(weather$RainTomorrow)
str(weather) # $ RainTomorrow : Factor

# y변수 제외 
weather_df <- subset(weather, select = -RainTomorrow)
dim(weather_df) # 366  14

# Up sample
up_weather <- upSample(weather_df, weather$RainTomorrow)
str(up_weather) # 600


# Down sample
down_weather <- downSample(weather_df, weather$RainTomorrow)
str(down_weather) # 132 obs

table(down_weather$Class)

