# chap09_Statistics_basic

#############################################
# 확률분포 함수 : ppt.15
#############################################

# 1. 확률질량함수 : 이산확률변수 x 크기 

# 이항분포 : 동전실험(ppt.18)
set.seed(12) # 시드 값
x <- rbinom(n=100, size=2, prob=0.5) # size=2 : 독립시행2회(동전 2회 시행) 


# 확률질량함수(PMF)    
pmf <- function(x){
  tab = table(x) # 빈도수 
  return(prop.table(tab)) # 빈도수의 비율 
}

# 함수 호출 
prop = pmf(x)

mass = names(prop) # 질량 : x의 고유한 정수

# 질량 vs 확률 시각화 
barplot(prop, xlab = "질량", ylab = "확률", 
        names.arg = mass, 
        main = "확률질량함수(PMF)") 



set.seed(12) # 시드 값

# 2. 확률밀도함수 : 연속확률변수 x 크기 
weight <- runif(n=1000, min = 45, max = 95)
weight

# 1) 각 계급을 밀도단위로 나타냄 
hist(weight, freq = FALSE) # 밀도단위 

# 2) 확률밀도함수(PDF) : 확률변수X의 크기(확률밀도) 추정  
pdf <- density(weight) 

# 3) 확률밀도분포곡선 : 추정된 대역폭과 x,y 통계로 분포곡선 시각화  
lines(pdf, col='red')

#############################################
# 정규분포 : ppt.23
#############################################
# 정규분포 : 좌우 대칭인 종모양의 연속확률분포  
# - 확률분포곡선(도수분포곡선)이 평균값을 중심으로 좌우대칭인 종 모양

set.seed(12)
height <- rnorm(n=1000, mean = 175, sd = 5)
height

# 1) 각 계급을 밀도단위로 나타냄 
hist(height, freq = FALSE) # 밀도단위 


# 2) 확률밀도함수(PDF) : : 확률변수X의 크기(확률밀도) 추정  
pdf <- density(height) # 커널밀도추정(KDE) : 적분값으로 확률밀도 추정   


# 3) 확률밀도분포곡선 : 추정된 대역폭과 x,y 통계로 분포곡선 시각화  
lines(pdf, col='red')


# 4) 정규분포곡선 추가 
x <- seq(159, 191, 0.1)
curve(dnorm(x, mean=mean(height), sd=sd(height)),
      col='blue', add = TRUE)

# 범례 추가 
legend(x=185, y=0.08, legend = "N(175,5^2)",
       fill='blue')


#########################################
## 표준정규분포 : ppt.33 
#########################################
# 표준정규분포(z분포) 
# - 모든 정규분포를 평균=0, 표준편차=1 로 표준화한 분포
# - 표준화공식 z = (X - mu) / sigma 


# 1) 정규분포 표본 추출 
n <- 1000
x <- rnorm(n, mean = 100, sd= 5) # 확률변수 x 

# 정규분포의 밀도분포곡선(확률밀도함수 이용) 
library(lattice)
densityplot( ~ x, col='red')

# 정규성 검정 : 귀무가설(H0) : 정규분포와 차이가 없다. 
shapiro.test(x) 


# 2) 표준정규분포 변환 : 표준화공식 z    
mu = mean(x) # 그리스 알파벳(모평균) 
z = (x - mu) / sd(x)

mean(z)
sd(z)


# 3) 표준편차 vs 확률 관계(ppt.35) 
# -1 ~ +1        68.26%
# -2 ~ +2        95.44%
# -3 ~ +3        99.74%
