#################################
## <제10장 연습문제>
################################# 

#01. 다음과 같은 6개 문항으로 작성된 설문지로 자료를 수집한 경우 각 문항별 척도를 쓰시오.  

# 1. 본인의 수능점수는 몇 점?  비율척도 
# 2. 응급실의 처치 시간은? 비율척도
# 3. 몇 층에 거주하나요? 서열척도 
# 4. 집 앞 가계에서 하루 평균 구입액은? 비율척도
# 5. 본인의 대학교 평균 학점은? 서열척도
# 6. 지난 5년간 서울지역의 겨울 평균 기온은? 등간척도 

#해석하는 방법)
#숫자형 변수(등간, 비율) : 숫자 의미(O), 절대0점 여부, 사칙연산 여부 
#문자형 변수(명목, 서열) : 숫자 의미(X), 순서 여부


# 데이터 셋 가져오기 
setwd("C:/ITWILL/5_R_Statistics/data")
pay_data <- read.csv(file = "pay_data.csv", header=TRUE)
head(pay_data) # 데이터셋 확인


#02. 주어진 데이터 셋의 명목형 변수를 대상으로 각 단계별로 빈도분석을 수행하시오. 

# 단계1> 명목척도인 상품유형(product_type) 변수를 대상으로 빈도분석을 수행하고, 
#  빈도분석 결과는 파이차트로 시각화하기 (단 색상은 각 범주별 무지개 색상 적용)
table(pay_data$product_type)
pie(table(pay_data$product_type), col = rainbow(5))

# 단계2> 명목척도인 지불방법(pay_method) 변수를 대상으로 빈도분석을 수행하고, 
# 빈도분석 결과를 막대차트로 각각 시각화하기 (단 색상은 각 범주별 무지개 색상 적용)
table(pay_data$pay_method)
barplot(table(pay_data$pay_method), col = rainbow(4))

# 단계3> 상품유형(product_type)변수를 행으로, 지불방법(pay_method) 변수를 열로 지정하여 교차분할표를 
# 작성하고, '3.신용카드'로 지불한 전체 상품 개수 계산하기  
tab <- table(pay_data$product_type, pay_data$pay_method)
tot <- sum(tab[,3])
tot # 200

#03. 주어진 데이터 셋의 비율척도를 대상으로 각 단계별로 기술통계 및 정규성을 검정하시오.

# 단계1> 비율척도인 지불금액(price) 변수를 대상으로 IQR 방식으로 이상치를 탐색한 후 제거하여 
#        data_df 데이터프레임 만들기(단 하한값 = 0)

# price 변수 추출 
price <- pay_data$price 


# IQR 계산식  
Q1 = quantile(price, 1/4)
Q3 = quantile(price, 3/4)
IQR = Q3 - Q1

outlier_step = 1.5*IQR

minValue = 0
maxValue = Q3 + outlier_step   
minValue; maxValue # 0 ~ 199553

data_df <- subset(pay_data, price >= 0 & price <= maxValue)
dim(data_df) # 399  4

# 단계2> 단계1에서 작성한 data_df의 price를 대상으로 대푯값(평균,중위수)과 비대칭도(왜도와 첨도)를 구하기  

library(moments) # 왜도/첨도 

price <-data_df$price 

# 1) 왜도 - 평균을 중심으로 기울어진 정도
skewness(price) # -0.1578487

# 2) 첨도 - 표준정규분포와 비교하여 얼마나 뽀족한가 측정 지표
kurtosis(price) #  1.4817

# 3) 히스토그램 확률밀도/표준정규분포 곡선 
hist(price)


# 단계3> price 변수에 대한 정규성 검정하기(힌트: shapiro.test() 이용)
shapiro.test(price) # W = 0.82679, p-value < 2.2e-16
# [해설] 매우 유의미한 수준에서 정규분포와 차이가 있다라고 볼 수 있다. 
