#################################
## <제15장 연습문제>
################################# 

# 01. mpg의 엔진크기(displ)가 고속도록주행마일(hwy)에 어떤 영향을 미치는가?    
# <조건1> 단순회귀모델 생성 
# <조건2> 회귀선 시각화 
# <조건3> 회귀분석 결과 해석 : 모델 유의성검정, 설명력, x변수 유의성 검정  

library(ggplot2)
data(mpg) # 자동차연비 
str(mpg)

# 1. 단순회귀모델
model <- lm(hwy ~ displ, data = mpg)
model
# Coefficients:
# (Intercept)        displ  
#      35.698       -3.531  


# 2. 회귀선 시각화 
plot(hwy ~ displ, data = mpg)
abline(model, col='red')
# 음의 상관관계 

# 3. 회귀분석 결과 해석 
summary(model)
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  35.6977     0.7204   49.55   <2e-16 ***
#   displ        -3.5306     0.1945  -18.15   <2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 3.836 on 232 degrees of freedom
# Multiple R-squared:  0.5868,	Adjusted R-squared:  0.585 
# F-statistic: 329.5 on 1 and 232 DF,  p-value: < 2.2e-16
# <회귀분석 결과 해석>
# 모델 유의성검정 : p-value < 0.05 이므로 통계적으로 유의함 
# 설명력 : 0.585 
# x변수 유의성 검정 : 엔진크기는 고속도록주행마일에 강한 부(-) 영향력  

r <- cor(mpg$displ, mpg$hwy) # 상관계수 
r^2 # 0.5867867 : 결정계수


# 02. ggplot2패키지에서 제공하는 diamonds 데이터 셋을 대상으로 
# 다이아몬드의 무게(carat), 너비(table), 깊이(depth) 변수 중
# 다이아몬드의 가격(price)에 영향을 미치는 관계를 다중회귀분석을 
# 이용하여 다음과 같은 단계로 수행하시오.

library(ggplot2)
data(diamonds)
str(diamonds)


table(diamonds$cut)
#Fair      Good Very Good   Premium     Ideal 
#1610      4906     12082     13791     21551

# 단계1 : 컷의 품질(cut) 칼럼에서 'Good','Very Good','Fair' 만으로 서브셋 만들기 
dia_df <- subset(diamonds, cut %in% c('Good','Very Good','Fair'))
dim(dia_df) # 18598    10


# 단계2 : 다이아몬드 가격 결정에 가장 큰 영향을 미치는 변수는?
formula <- price ~ carat +  table + depth
model <- lm(formula, data=dia_df) 
summary(model) # 회귀분석 결과


# 단계3 : 다중회귀 분석 결과를 정(+)과 부(-) 관계로 해설

# <회귀분석 결과 해설>
# carat은 price에 정(+)의 영향을 미치고, 
# table과 depth는 부(-)의 영향을 미친다.



# 03. mpg 데이터셋을 대상으로 엔진크기(displ), 연식(year), 실린더수(cyl), 
# 구동방식(drv) 변수 중에서 도시주행마일(cty)에 영향을 미치는 관계를 
# 다중회귀분석을 이용하여 다음과 같은 단계로 수행하시오.

library(ggplot2)
data(mpg) # 자동차연비 


# 단계1 : subset 만들기 : displ, year, cyl, drv, cty
mpg_df <- subset(mpg, select = c('displ','year','cyl','drv','cty'))
mpg_df

# 단계2 : drv 변수 -> 더미변수 생성 
# (단, 구동 방식 3가지("f" "4" "r") 중에서 "r"을 base로 지정)
mpg_df$drv <- factor(mpg_df$drv, levels = c("r", "f", "4"))
mpg_df


# 단계3 : 다중선형회귀모델 생성 & 회귀계수 확인  
lm_model <- lm(cty ~ ., data = mpg_df)
lm_model

# 단계4 : 종속변수를 기준으로 각 독립변수의 관계 해설
summary(lm_model)


# 04. product 데이터셋을 이용하여 다중회귀분석을 이용한 기계학습 모델을 
# 다음과 같은 단계로 만들고 평가하시오.

# <사용할 변수> y변수 : 제품_만족도, x변수 : 제품_적절성, 제품_친밀도
setwd("C:/ITWILL/5_R_Statistics/data")
product <- read.csv("product.csv", header=TRUE)

set.seed(34) # 시드값 

# 단계1 : 학습데이터(train),검정데이터(test)를 7 : 3 비율로 샘플링
x <- sample(nrow(product), 0.7*nrow(product)) # 70% 추출 
train <- product[x, ]
test <- product[-x, ]

# 단계2 : 학습데이터 이용 회귀모델 생성 
model <- lm(제품_만족도 ~ 제품_적절성+제품_친밀도, data = train)
model

# 단계3 : 검정데이터 이용 모델 예측치 생성 
y_pred <- predict(model, test)
y_true <- test$제품_만족도

# 단계4 : 모델 평가 : MSE, 결정계수(R^2) 
MSE = mean((y_pred - y_true)^2)
R2 = cor(y_pred, y_true)^2
cat('MSE =',MSE)
cat('R2 score =', R2)










