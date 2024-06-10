chap15_LinearRegression

######################################################
# 회귀분석(Regression Analysis)
######################################################
# - 독립변수(설명변수)가 종속변수(반응변수)에 미치는 영향 분석

###################################
## 1. 단순회귀분석 
###################################
# - 독립변수와 종속변수가 1개인 경우

# 1) 데이터셋 : 점수와 지능지수 
setwd("C:/ITWILL/5_R_Statistics/data")
score_iq <- read.csv('score_iq.csv')
str(score_iq) # 'data.frame':	150 obs. of  6 variables:

head(score_iq)


# 2) 단순선형회귀 모델 생성  
# 형식) lm(formula= y ~ x 변수, data)
model <- lm(score ~ iq, data = score_iq) # (y ~ x)
model # 회귀계수

#  회귀분석 model의 12개 속성  
names(model)
# "coefficients" : 회귀계수 
# "residuals" : 오차(잔차) 
# "fitted.values" : 적합치  


# 3) 회귀모델 예측치 : 미지의 x값 -> y예측  
y_pred <- predict(model, data.frame(iq=150)) 


# 4) 단순선형회귀 시각화
plot(score_iq$iq, score_iq$score) # 산점도 
abline(model, col='red') # 회귀선 


# 5) 선형회귀 분석 결과 해석 
summary(model)
# <분석절차>
# 1. 모델 통계적 유의성 검정 : F-검정 p-value < 0.05
# 2. 모델 설명력 : R-squared(1수렴 정도)
# 3. X변수의 유의성 검정 :  t-검정 p-value, * 강도 

############################
## 회귀계수 vs 결정계수 
############################
# - 회귀계수(re coefficient) : X의 기울기 
# - 결정계수(R-squared:R^2) : 회귀모형에서 설명력을 보여주는 지표
# R^2 = SSR / SST 
# 전체제곱합(SST) = sum((y - y예측치평균)^2)
# 회귀제곱합(SSR) = sum((y예측치 - y예측치평균)^2)

###################################
## 2. 다중회귀분석
###################################
# - 여러 개의 독립변수 -> 종속변수에 미치는 영향 분석

# 1) score_iq dataset 이용 
str(score_iq) # 'data.frame':	150 obs. of  6 variables:
# 'data.frame':	150 obs. of  6 variables:
# $ sid    : int  10001 10002 10003 10004 10005 10006 10007 10008 10009 10010 ...
# $ score  : int  90 75 77 83 65 80 83 70 87 79 ...
# $ iq     : int  140 125 120 135 105 123 132 115 128 131 ...
# $ academy: int  2 1 1 2 0 3 3 1 4 2 ...
# $ game   : int  1 3 0 3 4 1 4 1 0 2 ...
# $ tv     : int  0 3 4 2 4 1 1 3 0 3 ...

# 1) 변수 선택 
y = score_iq$score # 종속변수
x1 = score_iq$iq # 독립변수1
x2 = score_iq$academy # 독립변수2
x3 = score_iq$tv # 독립변수3

df <- data.frame(x1, x2, x3, y)

model2 <- lm(formula=y ~ x1 + x2 + x3, data=df)
model2 <- lm(formula=y ~ ., data=df) # . : y를 제외한 나머지 x변수 

# 계수 확인 
model2


# 다중회귀분석 결과 
summary(model2)

# 2) 102개 직업군 평판 dataset 이용 
#install.packages("car") # 다중공선성 문제 확인  
library(car)

Prestige # car 제공 dataset
class(Prestige) #  "data.frame"
names(Prestige) # 변수 추출 : 6개 
row.names(Prestige) # 행 이름 -> 102 직업군 이름 


# 102개 직업군의 평판 : 교육수준,수입,여성비율,평판(프레스티지),센서스(인구수=직원수)
str(Prestige)

# 종속변수 : income 
# 독립변수 : education + women + prestige 
model3 <- lm(income ~ education + women + prestige, data = Prestige)
model3

#선형회귀 분석 결과  
summary(model3)


# 다중회귀분석 회귀선 시각화 
install.packages('psych')
library(psych)

newdata <- Prestige[c(2,1,3:4)] # income 기준 

# stars : 상관계수 유의성, lm : 회귀선, ci : 회귀선 신뢰구간 
pairs.panels(newdata, stars = TRUE, lm = TRUE, ci = TRUE)

###################################
## 3. 변수 선택법 
###################################
# Stepwise : 전진선택법, 후진제거법, 단계선택법

# 전진선택법 : model에 독립변수 한 개씩 추가
# 후진제거법 : 중요도가 낮은 독립변수 한 개씩 제거
# 단계선택법 : 전진선택법 + 후진제거법

# 실습 dataset 
newdata <- Prestige[-6] # type 제외 

# 선형회귀모델 
model <- lm(income ~ ., data = newdata)

# 효과적인 변수 선택법
library(MASS)

step <- stepAIC(model, direction = 'both') # 단계선택법

# AIC 지수값이 가장 작은 모델 선택
# AIC(Akaike information criterion) : 모형의 복잡도에 벌점을 주는 방식으로 모델 성능 평가 기준 



###################################
# 4. 다중공선성
###################################
# - 독립변수 간의 강한 상관관계로 인해서 회귀분석의 결과를 신뢰할 수 없는 현상
# - 한 독립변수의 값이 증가할 때 다른 독립변수의 값이 증가하거나 감소하는 현상

# - 결정계수 : 회귀모형에서 설명력의 지표
# R^2 = SSR / SST = 1 - SSE/SST

# 회귀제곱합(SSR:Sum of Square Regression) = sum((y'- y_bar)^2)
# 총제곱합(SST:Sum of Square Total) = sum((y - y_bar)^2) 
# 오차제곱합(SSE:Sum of Square Error) = sum((y - y')^2)


# 분산팽창요인(VIF) = 1 / (1 - R^2)
# 결정계수의 값이 1과 가까워지면 VIF값도 커져서 다중공선성 존재가능성 높다.
# - 생년월일과 나이를 독립변수로 갖는 경우
# - 해결방안 : 강한 상관관계를 갖는 독립변수 제거

# (1) 다중공선성 문제 확인
#install.packages('car')
library(car)

# iris 이용 선형회귀모델 
model <- lm(formula=Sepal.Length ~ Sepal.Width+Petal.Length+Petal.Width, data=iris)
vif(model)

sqrt(vif(model)) > 2 # root(VIF)가 2 이상인 것은 다중공선성 문제 의심 


# (2) iris 변수 간의 상관계수 구하기
cor(iris[,-5]) # 변수간의 상관계수 보기
# 상관성이 높은 제거 대상 변수 탐색

summary(model) # Adjusted R-squared:  0.8557 
# Residual standard error: 0.3145

# (3) 변수 제거(3번) -> 설명력 낮아짐 
model2 <- lm(formula=Sepal.Length ~ Sepal.Width+Petal.Length, data=iris)
summary(model2) # Adjusted R-squared:  0.838 
# Residual standard error: 0.3333

# (4) 변수 제거(4번) -> 설명력 더 낮아짐 
model3 <- lm(formula=Sepal.Length ~ Sepal.Width+Petal.Width, data=iris)
summary(model3) # Adjusted R-squared:  0.7033

####################################
## 5. 더미변수 사용 
####################################
# - 범주형 변수를 독립변수로 사용하기 위해서 더미변수 생성
# - 범주형 변수는 기울기 영향 없음(절편에만 영향을 미침)
# - 범주형 변수의 범주가 n개인 경우 n-1개 파생변수 생성
# ex) 혈액형 : A, B, O, AB

#               x1    x2    x3  
#         A      1     0     0
#         B      0     1     0
#         O      0     0     1
#         AB     0     0     0 (기준)

# Factor형 -> dummy 생성 역할 

# 의료비 예측
# - 의료보험 가입자 1,338명을 대상으로 한 데이터 셋으로 의료비 인상 예측 

# 1. 데이터 셋 가져오기 - insurance.csv
insurance <- read.csv('C:/ITWILL/5_R_Statis/data/insurance.csv', header = T)
str(insurance) # sex, smoker 명목척도 -> Factor 형변환(숫자형 의미 적용) 
#'data.frame':	1338 obs. of  7 variables:
#$ age     : 나이 : int  19 18 28 33 32 31 46 37 37 60 ...
#$ sex     : 성별 :(x1) Factor w/ 2 levels "female","male": 1 2 2 2 2 1 1 1 2 1 ...
#$ bmi     : 비도만 지수 : num  27.9 33.8 33 22.7 28.9 ...
#$ children: 자녀수 : int  0 1 3 0 0 0 1 3 2 0 ...
#$ smoker  : 흡연 여부 :(x2) Factor w/ 2 levels "no","yes": 2 1 1 1 1 1 1 1 1 1 ...
#$ region  : 지역 Factor w/ 4 levels "northeast","northwest",..: 4 3 3 2 2 3 3 2 1 2 ...
#$ charges : 의료비(y) : num  16885


###################################
### 2개 범주를 갖는 독립변수 사용 
###################################

# 2. 회귀모델 생성 : 성별(sex) 더미변수 사용  
insurance2 <- insurance[, -c(5:6)] # 흡연, 지역 제외 
head(insurance2) # age sex bmi children charges

model_ins <- lm(charges ~ ., data=insurance2)
model_ins # 절편과 기울기 보기 
# (Intercept)      age      sexmale          bmi     children  
# -7460.0        241.3       1321.7        326.8        533.2 

# [해설] sexmale : 남자가 여자에 비해서 1321.7 의료비 증가


summary(model_ins)
# (Intercept) -7459.97    1773.72  -4.206 2.77e-05 ***
#   age           241.26      22.27  10.835  < 2e-16 ***
#   sexmale      1321.72     622.00   2.125   0.0338 *  
#   bmi           326.76      51.30   6.369 2.61e-10 ***
#   children      533.17     257.94   2.067   0.0389 * 


###################################
### 4개 범주를 갖는 독립변수 사용 
###################################
insurance3 <- insurance[,-c(2, 5)]

model_ins <- lm(charges ~ region, data=insurance3) 
model_ins # 절편과 기울기 보기
# (Intercept)  regionnorthwest  regionsoutheast  regionsouthwest  
# 13406.4           -988.8           1329.0          -1059.4 

##########################################
##  6. 선형회귀분석 잔차검정과 모형진단
##########################################

# 1. 변수 선택  
# 2. 회귀모델 
# 3. 다중공선성 검사 
# 4. 모형의 잔차검정 
#   1) 잔차의 등분산성 검정
#   2) 잔차의 정규성 검정 
#   3) 잔차의 독립성(자기상관) 검정 

names(iris)

# 1. 변수 선택  : y:Sepal.Length <- x:Sepal.Width,Petal.Length,Petal.Width
formula = Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width


# 2. 회귀모델  
model <- lm(formula = formula,  data=iris)

# 3. 다중공선성 검사 -> 변수제거 또는 차원축소 
library(car)
sqrt(vif(model)) > 2 # TRUE 

# 독립변수 제거 & 모델 생성 
formula = Sepal.Length ~ Sepal.Width + Petal.Length 
model <- lm(formula = formula,  data=iris)


# 모델 잔차(오차) 추출 
res <- model$residuals # 잔차(오차)


# 4. 모형의 잔차검정
plot(model)
#Hit <Return> to see next plot: 잔차 vs 적합값 -> 패턴없이 무작위 분포(포물선 분포 좋지않은 적합) 
#Hit <Return> to see next plot: Normal Q-Q -> 정규분포 : 대각선이면 잔차의 정규성 
#Hit <Return> to see next plot: 척도 vs 위치 -> y축 : 표준화한 잔차 : 중심을 기준으로 고루 분포 
#Hit <Return> to see next plot: 잔차 vs 영향력 -> 이상치 관찰  

# (1) 잔차 선형성 검정 
plot(model, which =  1) 

# (2) 잔차 정규성 검정 
plot(model, which =  2)  

# 정규성 시각화  
hist(res, freq = F) 
qqnorm(res)


# (3) 잔차 등분산성 검정 
plot(model, which = 3) 

# (4) 잔차의 독립성(자기상관 검정 : Durbin-Watson)  
install.packages('lmtest')
library(lmtest) # 자기상관 진단 패키지 설치 
dwtest(model) 

######################################
## 7. 기계학습(Machine learning)
######################################
# - 훈련셋으로 학습된 모델을 평가셋으로 평가하여 예측모델을 만드는 기법  

# 1) 훈련셋과 평가셋 분류
x <- sample(nrow(iris), 0.7*nrow(iris)) # 전체중 70%만 추출

train <- iris[x, ] # 훈련셋 추출
test <- iris[-x, ] # 평가셋 추출

# 2) model 생성 : 훈련셋 이용 
lm_model <- lm(formula=Sepal.Length ~ Sepal.Width + Petal.Length, data=train)

# 3) model 예측치 : 평가셋 이용 
y_pred <- predict(lm_model, test) # test에는 훈련에 사용되는 변수가 반드시 포함 
y_true <- test$Sepal.Length # 관측치(정답)


# 4) model 평가 : 예측치와 관측치 이용 
err <- y_pred - y_true
MSE = mean(err ^ 2) 
