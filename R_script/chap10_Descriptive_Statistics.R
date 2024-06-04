# chap10_Descriptive_Statistics

################################################
## 기술통계(Descriptive Statistics)
################################################
# 기술통계 : 자료를 요약하는 기초적인 통계량, 변수의 특성 파악 및 모집단 유추
# 대푯값 : 평균(Mean), 합계(Sum), 중위수(Median), 최빈수(mode), 사분위수(quartile) 등
# 산포도 : 분산(Variance), 표준편차(Standard deviation), 최소값(Minimum), 최대값(Maximum), 범위(Range) 등 
# 비대칭도 : 왜도(Skewness), 첨도(Kurtosis)


# - 실습파일 가져오기
setwd("C:/ITWILL/5_R_Statistics/data")
data <- read.csv("descriptive.csv", header=TRUE)

head(data) # 데이터셋 확인
# data Mart
#---------------------------------------------------------------------------------
# resident   gender      age	  level	      cost	   type    	 survey	   pass
# 거주지역   성별       나이  학력수준     생활비  학교유형  만족도    합격여부
# 명목(1~3)  명목(1,2)  비율  서열(1,2,3)  비율    명목(1,2) 등간(5점) 명목(1,2)
#---------------------------------------------------------------------------------
# 인구통계학변수 : 거주지역, 성별, 나이, 학력수준

# 1. 척도별 기술통계량

# 1) 명목/서열 척도 변수의 기술통계량
# - 명목상 의미없는 수치로 표현된 변수  : 성별(gender)   
summary(data$gender) # 최소,최대,중위수,평균 : 의미 없음 
table(data$gender) # 성별 빈도수

data <- subset(data,data$gender == 1 | data$gender == 2) # 성별 outlier 제거
x <- table(data$gender) # 성별에 대한 빈도수 저장
barplot(x) # 범주형(명목/서열척도) 시각화 -> 막대차트

prop.table(x) # 비율 계산 


# 2) 등간척도 변수의 기술통계량
# - 속성의 간격이 일정한 변수 : 만족도(survey) 
survey <- data$survey
survey

summary(survey) # 만족도(5점 척도)인 경우 의미 있음 
x <- table(survey) # 빈도수
x
# 1  2  3  4  5 
#20 72 61 25  7

# 등간척도 시각화 
pie(x)

# 3) 비율척도 변수의 기술통계량 : 생활비(cost)   
summary(data$cost) # 요약통계량 
mean(data$cost, na.rm = T) # NA
data$cost

# 데이터 정제 - 결측치 제거 및 outlier 제거
plot(data$cost)
data <- subset(data,data$cost >= 2 & data$cost <= 8) # 2 ~ 8 사이 

# cost변수 추출 
cost <- data$cost
cost


###  2. 대푯값 
# 1) 평균(Mean)
mean(cost) # 5.354032
# 평균이 극단치에 영향을 받는 경우 -> 중위수(median) 대체

# 2) 중위수(Median) : 정렬 -> 중앙값
median(cost) # 5.4  

length(cost) # 248
idx <- length(cost) / 2

cost_asc <- sort(cost) # 오름차순 정렬 
cost_asc # 2.1 ~ 7.9 

(cost_asc[idx] + cost_asc[idx+1]) / 2 #  5.4

# 3) 최빈수(mode) : 연속형변수 hist() 이용  
hist(cost) # 가장 높은 봉의 계급 : 6~6.5

# 4) 사분위수(quartile) 
quantile(cost, 1/4) # 1 사분위수 - 25%, 4.6
quantile(cost, 3/4) # 3 사분위수 - 75%, 6.2

# 왜도, 평균, 중위수, 최빈수 관계(PPT.28 참고)
# 평균(5.354032) < 중위수(5.4) < 최빈수(6~6.5) : 왜도 < 0
# 왼쪽꼬리분포 : 오른쪽으로 기울어짐 

###  3. 산포도 

x <- data$cost

# 1) 분산(Variance)
var(x) # 분산 : 1.296826

# 2) 표준편차(Standard deviation)
sqrt(var(x)) # 분산의 제곱근 = 표준편차 
sd(x) # 표준편차 : 1.138783

sd(x)^2 # 표준편차의 제곱 = 분산 

# 3) 최소값/최대값/범위 
min(x) # 최소값
max(x) # 최대값
range(x) # 범위(min ~ max)



### 4. 비대칭도 :  패키지 이용 
install.packages("moments")  # 왜도/첨도 위한 패키지 설치   
library(moments)

cost <- data$cost # 정제된 data

# 1) 왜도 - 평균을 중심으로 기울어진 정도
skewness(cost) # -0.297234 : 왜도 < 0 
# 0보다 크면 왼쪽 기울어짐
# 0보다 작으면 오른쪽 기울어짐

# 2) 첨도 - 표준정규분포와 비교하여 얼마나 뽀족한가 측정 지표
kurtosis(cost) # 2.674163 < 3      
# 정규분포 첨도 = 3

# 3) 히스토그램 : 대칭성 
hist(cost)

######################################
## 밀도분포곡선과 표준정규분포 곡선
######################################
# 단계1. 히스토그램 확률밀도/표준정규분포 곡선 
hist(cost, freq = F) # (확률)밀도 추정 
lines(density(cost), col='blue')

# 단계2. 표준정규분포 곡선 
x <- seq(0, 8, 0.1)
curve( dnorm(x, mean(cost), sd(cost)), col='red', add = T)

# 단계3. QQ-plot
qqnorm(cost, main = 'cost QQ-plot')
qqline(cost, col='red')

# 단계4. 정규성 검정 
shapiro.test(cost)


### 5. 기술통계 보고서 작성법
# - 빈도분석 : 논문에서 인구통계학적 특성 반영   

# 1) 거주지역 
data$resident2[data$resident == 1] <-"특별시"
data$resident2[data$resident >=2 & data$resident <=4] <-"광역시"
data$resident2[data$resident == 5] <-"시구군"

x<- table(data$resident2)
prop.table(x) # 비율 계산
y <-  prop.table(x)
round(y*100, 2) #백분율 적용(소수점 2자리)

# 2) 성별
data$gender2[data$gender== 1] <-"남자"
data$gender2[data$gender== 2] <-"여자"
x<- table(data$gender2)
prop.table(x) # 비율 계산
y <-  prop.table(x)
round(y*100, 2) #백분율 적용(소수점 2자리)

# 3) 나이
summary(data$age)# 40 ~ 69
data$age2[data$age <= 45] <-"중년층"
data$age2[data$age >=46 & data$age <=59] <-"장년층"
data$age2[data$age >= 60] <-"노년층"
x<- table(data$age2)
prop.table(x) # 비율 계산
y <-  prop.table(x)
round(y*100, 2) #백분율 적용(소수점 2자리)

# 4) 학력수준
data$level2[data$level== 1] <-"고졸"
data$level2[data$level== 2] <-"대졸"
data$level2[data$level== 3] <-"대학원졸"

x<- table(data$level2)
prop.table(x) # 비율 계산 
y <-  prop.table(x)
round(y*100, 2) #백분율 적용(소수점 2자리)

# 5) 합격여부
data$pass2[data$pass== 1] <-"합격"
data$pass2[data$pass== 2] <-"실패"
x<- table(data$pass2)
prop.table(x) # 비율 계산 : 0< x <1 사이의 값
y <-  prop.table(x)
round(y*100, 2) #백분율 적용(소수점 2자리)



