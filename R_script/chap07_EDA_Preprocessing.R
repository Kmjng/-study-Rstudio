# # chap07_EDA_Preprocessing

## 탐색적데이터분석과 전처리 


# 1. 탐색적 데이터 조회 

# 실습 데이터 읽어오기
setwd("C:/ITWILL/5_R_Statistics/data")
dataset <- read.csv("dataset.csv", header=TRUE) # 헤더가 있는 경우
head(dataset) # 칼럼과 척도 관계 : ppt.8 참고 

# 1) 데이터 조회
# - 탐색적 데이터 분석을 위한 데이터 조회 

# (1) 데이터 셋 구조
names(dataset) # 변수명(컬럼)
attributes(dataset) # names(), class, row.names
str(dataset) # 데이터 구조보기
dim(dataset) # 차원보기 : 300 7
nrow(dataset) # 관측치 개수 : 300
ncol(dataset) # 변수 개수 : 7 

# (2) 데이터 셋 조회
dataset # print(dataset) 
View(dataset) # 뷰어창 출력

# 상위/하위 자료 보기 
head(dataset) 
tail(dataset) 

# (3) 칼럼 조회 
# 형식) dataframe$칼럼명   
dataset$age  # 1차원 : vector
dataset$price

# 형식) dataframe["칼럼명"] 
dataset["age"] # 2차원 : data.frame
dataset["price"] 

# 형식) dataframe[색인]   
dataset[2] # 두번째 컬럼
dataset[6] # 여섯번째 컬럼
dataset[3,] # 3번째 관찰치(행) 전체
dataset[,3] # 3번째 변수(열) 전체

# dataset에서 2개 이상 칼럼 조회
dataset[c("job","price")]
dataset[c(2,6)] 

dataset[c(1:3)] # 연속된 칼럼 
dataset[c(2,4:6,3,1)] 

# 2. 결측치(NA) 처리

# 1) 결측치 확인 
summary(dataset) 
table(is.na(dataset))

# 그래프 이용 결측치 확인 
install.packages("VIM")
library(VIM)

aggr(dataset, prop = FALSE, numbers = TRUE)


# 2) 결측치 제거  
dataset2 <- na.omit(dataset) # 전체 칼럼 기준

dataset3 <- subset(dataset, subset = !(is.na(price))) # 특정 칼럼 기준 


# 3) 결측데이터 처리(0 or 상수 대체)
x <- dataset$price # price vector 생성 
dataset$price2 = ifelse( !is.na(x), x, 0) # 결측치 0 대체

# 4) 결측데이터 처리(평균 or 중위수 대체)
x <- dataset$price # price vector 생성 
dataset$price3 = ifelse(!is.na(x), x, round(mean(x, na.rm=T), 2) ) # 평균대체


# 5) 결측치 기계학습 대체 : 다중대체법
install.packages('mice')
library(mice)

# 적용 데이터셋 : iris 30개 
iris_df <- head(iris, 30)

# 결측치 생성 
iris_df[1,1] <- NA # 5.1 
iris_df[3,3] <- NA # 1.3 

miceModel <- mice(iris_df) # m = 5 : 반복학습 5회 
iris_df2 <- complete(miceModel) # 예측 dataset 생성
# 3. 이상치 발견과 정제
# - 정상 범주에서 크게 벗어난 값 

# 1) 범주형 변수 이상치 처리
gender <- dataset$gender
gender

# outlier 확인
table(gender) # 빈도수
pie(table(gender)) # 파이 차트

# gender 변수 정제(1,2)
dataset <- subset(dataset, gender==1 | gender==2)
dataset # gender변수 데이터 정제
length(dataset$gender) # 297개 - 3개 정제됨
pie(table(dataset$gender))


# 2) 연속형 변수 이상치 처리
dataset$price # 세부데이터 보기

# (1) 정상범주(2~8) 이용 이상치 처리 
plot(dataset$price) # 산점도 
summary(dataset$price) # 범위확인

# price변수 정제(2~8)
dataset4 <- subset(dataset, price >= 2 & price <= 8)
boxplot(dataset4$age)

# (2) 상자그래프와 통계량 이용 이상치 처리      
boxplot(dataset$price)
# 일반적으로 정상범위에서 상하위 0.3% 이상치로 본다.

# 상자그래프와 통계량 
boxplot(dataset$price)$stats

# 이상치 대체 : 하한값/상한값으로 대체 
dataset5 <- na.omit(dataset) # 결측치 제거 

dataset5$price <- ifelse(dataset5$price < 2.1, 2.1, dataset5$price) # 하한값 대체 
dataset5$price <- ifelse(dataset5$price > 7.9, 7.9, dataset5$price) # 상한값 대체 


# (3) IQR(Inter Quantile Range)방식 이용 이상치 처리
# IQR = Q3 - Q1 
# 정상범위 : Q1 - 1.5 * IQR ~ Q3 + 1.5 * IQR 

dataset6 <- na.omit(dataset)

Q1 <- quantile(dataset6$price, 1/4) # 제1사분위수
Q3 <- quantile(dataset6$price, 3/4) # 제3사분위수 
IQR = Q3 - Q1 

outlier_step = 1.5 * IQR 
minVal <- Q1 - outlier_step 
maxVal <- Q3 + outlier_step 

# 이상치 제거 
clean_dataset6 <- subset(dataset6, price >= minVal & price <= maxVal) 
boxplot(clean_dataset6$price)

#######################################################
# 2024-05-23
# 4. 코딩 변경 : 변수변환 : 리코딩 하기
# - 데이터의 가독성, 척도 변경, 최초 코딩 내용 변경을 목적으로 수행


# 1) 데이터의 가독성
# 형식) data.frame$새칼럼명[조건식] <- 값 

setwd("C:/ITWILL/5_R_Statistics/data")
dataset <- read.csv("dataset.csv", header=TRUE) # 헤더 있는 경우
head(dataset) # 자료 확인 

dataset2 <- na.omit(dataset) # 결측치 제거 

dataset2$resident2[dataset2$resident == 1] <- "1.서울특별시"
dataset2$resident2[dataset2$resident == 2] <- "2.인천광역시"
dataset2$resident2[dataset2$resident == 3] <- "3.대전광역시"
dataset2$resident2[dataset2$resident == 4] <- "4.대구광역시"
dataset2$resident2[dataset2$resident == 5] <- "5.시구군"

# 2) 척도 변경 : 비율척도 -> 명목척도 
dataset2$age2[dataset2$age <= 30] <- "청년층"
dataset2$age2[dataset2$age > 30 & dataset2$age < 55] <- "중년층"
dataset2$age2[dataset2$age >= 55] <- "장년층"

table(dataset2$age2)
#장년층 중년층 청년층 
#  54     98     57


# 3) 역코딩 : 긍정순서(5->1)

survey <- dataset2$survey
# 브로드케스트 연산 
csurvey <- 6 - survey # 벡터 = 상수(scala) - 벡터(vector) 
csurvey[1:5]

# 벡터 값 수정 
dataset2$survey <- csurvey
head(dataset2)


# 5. 정제된 데이터 저장
setwd("C:/ITWILL/5_R_Statistics/output") # 경로 변경 

# (1) 정제된 데이터 저장
write.csv(dataset2,"cleanData.csv", quote=F, row.names=F) 

# (2) 정제된 데이터 불러오기 
new_data <- read.csv("cleanData.csv")
head(new_data)

# 6. 탐색적 분석을 위한 시각화 

# 데이터셋 불러오기
setwd("C:/ITWILL/5_R_Statistics/data")
new_data <- read.csv("new_data.csv", header=TRUE)
new_data 
str(new_data)

# 1) 명목척도(범주/서열) vs 명목척도(범주/서열) 
# - 거주지역과 성별 칼럼 시각화 
resident_gender <- table(new_data$resident2, new_data$gender2)
resident_gender
gender_resident <- table(new_data$gender2, new_data$resident2)
gender_resident

# - 성별에 따른 거주지역 분포 현황 
barplot(resident_gender, beside=T, horiz=T,
        col = rainbow(5),
        legend = row.names(resident_gender),
        main = '성별에 따른 거주지역 분포 현황') 
# row.names(resident_gender) # 행 이름 

# - 거주지역에 따른 성별 분포 현황 
barplot(gender_resident, beside=T, 
        col=rep(c(2, 4),5), horiz=T,
        legend=c("남자","여자"),
        main = '거주지역별 성별 분포 현황')  

# 2) 비율척도(연속) vs 명목척도(범주/서열)
# - 나이와 직업유형에 따른 시각화 
install.packages("lattice")  # 고급시각화 
library(lattice)

# 직업유형에 따른 나이 분포 현황   
densityplot( ~ age, data=new_data, groups = job2,
             plot.points=T, auto.key = T)
# plot.points=T : 밀도, auto.key = T : 범례 

# 3) 비율(연속) vs 명목(범주/서열) vs 명목(범주/서열)
# - 구매비용(연속):x칼럼 , 성별(명목):조건, 직급(서열):그룹   

# (1) 성별에 따른 직급별 구매비용 분석  
densityplot(~ price | factor(gender2), data=new_data, 
            groups = position2, plot.points=T, auto.key = T) 
# 격자 : 성별, 그룹 : 직급 

# (2) 직급에 따른 성별 구매비용 분석  
densityplot(~ price | factor(position2), data=new_data, 
            groups = gender2, plot.points=T, auto.key = T) 
# 격자 : 직급, 그룹 : 성별 



