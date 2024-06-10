# chap14_CorrelationAnalysis

######################################
# 1. 피어슨(Pearson) 상관계수
######################################

setwd("C:/ITWILL/5_R_Statistics/data")
product <- read.csv("product.csv")
head(product) # 친밀도 적절성 만족도(등간척도 - 5점 척도)

# 기술통계량
summary(product) # 요약통계량

sd(product$제품_친밀도); sd(product$제품_적절성); sd(product$제품_만족도)
# 변수 간의 상관관계 분석 
# 형식) cor(x,y, method) # x변수, y변수, method(pearson): 방법

# 1) 상관계수(coefficient of correlation) : 두 변량 X,Y 사이의 상관관계 정도를 나타내는 수치(계수)
cor(product$제품_친밀도, product$제품_적절성) # 0.4992086 -> 다소 높은 양의 상관관계

cor(product$제품_친밀도, product$제품_만족도) # 0.467145 -> 다소 높은 양의 상관관계

# 전체 변수 간 상관계수 보기
cor(product, method="pearson") # 피어슨 상관계수 - default

# 방향성 있는 색생으로 표현 - 동일 색상으로 그룹화 표시 및 색의 농도 
install.packages("corrgram")   
library(corrgram)
corrgram(product) # 색상 적용 - 동일 색상으로 그룹화 표시
corrgram(product, upper.panel=panel.conf) # 수치(상관계수) 추가(위쪽)
corrgram(product, lower.panel=panel.conf) # 수치(상관계수) 추가(아래쪽)

# 차트에 곡선과 별표 추가
install.packages("PerformanceAnalytics") 
library(PerformanceAnalytics) 

# 상관성,p값(*),정규분포 시각화 - 모수 검정 조건 
chart.Correlation(product, histogram=TRUE) 

# 상관계수 행렬 시각화 
install.packages('corrplot')
library(corrplot) # 상관계수 시각화 
corrplot( cor(product, method="pearson") )

# 2) 공분산(covariance) : 두 변량 X,Y의 관계를 나타내는 양
cov(product)

cov2cor(cov(product)) # 공분산 행렬 -> 상관계수 행렬 변환(기존 상관계수와 동일함) 

# 3) 상관계수 vs 공분산
# [1] 공분산 : 두 확률변수 간의 분산(평균에서 퍼짐 정도)를 나타내는 통계
#  - Cov(X,Y) = sum( (X-𝒙_bar) * (Y-𝒚_bar) ) / n
#  - 문제점 : 값이 큰 변수에 영향을 받는다.(값 큰 변수가 상관성 높음) : 

# [2] 상관계수 : 공분산을 각각의 표준편차로 나눈어 정규화한 통계
#   - 공분산 문제점 해결 
#   - 부호는 공분산과 동일, 값은 절대값 1을 넘지 않음(-1 ~ 1)    
#   - Corr(X, Y) = Cov(X,Y) / std(X) * std(Y)



######################################
# 2. 스피어만(Spearman) 상관계수
######################################
# - 서열척도 변수를 대상으로 단조 증가 또는 하강하는 관계를 나타내는 계수 

# 예) 국어성적 석차와 영어성적 석차의 관계
# cor(국어성적_석차, 영어성적_석차, method = "spearman") 

# 점수 
set.seed(345)
kor_score <- round(runif(10, min=50, max = 90))
eng_score <- round(runif(10, min=40, max = 75))

# 점수 석차 
kor_score_rank <- sort(kor_score)
eng_score_rank <- sort(eng_score)

# 스피어만 상관계수 
cor(kor_score_rank, eng_score_rank, method = "spearman") #  0.9939024
