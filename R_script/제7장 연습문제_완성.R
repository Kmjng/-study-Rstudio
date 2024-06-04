#################################
## <제7장 연습문제>
################################# 

# 01. mtcars 데이터셋의 qsec(1/4마일 소요시간) 변수를 대상으로
#  boxplot에서 제공하는 정상범주의 통계를 이용하여 이상치를 제거한 후
#  new_mtcars로 저장하고, 정제결과를 확인하시오.

# install.packages('ggplot2')
library(ggplot2)
str(mtcars) # 'data.frame':	32 obs. of  11 variables:


# [단계1] 이상치 통계 : 힌트) boxplot()$stats
boxplot(mtcars$qsec)$stats
#       [,1]
# [1,] 14.500
# [2,] 16.885
# [3,] 17.710
# [4,] 18.900
# [5,] 20.220

# [단계2] 이상치 제거 후 저장 
new_mtcars <- subset(mtcars, subset = qsec>=14.5 & qsec <= 20.22) 


# [단계3] 정제 결과 확인 : 힌트) boxplot() 
boxplot(new_mtcars$qsec)


# 02. mpg 데이터셋의 hwy 변수를 대상으로 IQR 방식으로 이상치를 
#  제거한 후 new_mpg로 저장하고 boxplot()으로 정제결과를 확인하시오.  

library(ggplot2)
str(mpg) # 자동차연비 관련 데이터셋 

hwy <- mpg$hwy # 고속도로 주행마일수 
 
# [단계1] IQR 계산 
IQR <- quantile(hwy, 3/4) - quantile(hwy, 1/4)

# [단계2] outlier_step = 1.5 * IQR
outlier_step = 1.5 * IQR

# [단계3] 정상범위 최솟값과 최댓값  
minVal <- quantile(hwy, 1/4) - outlier_step
maxVal <- quantile(hwy, 3/4) + outlier_step


# [단계4] 이상치 제거후 저장  
new_mpg <- subset(mpg, subset = hwy >= minVal & hwy <= maxVal) 


# [단계5] 정제 결과 확인 : 힌트) boxplot() 
boxplot(new_mpg$hwy)


# 03. 본문에서 생성된 dataset2의 resident 칼럼을 대상으로 NA 값을 제거한 후 new_data 변수에 저장하시오.
new_data <- NA


# 04. 본문에서 생성된 dataset2의 직급(position) 칼럼을 대상으로 1급 -> 5급, 5급 -> 1급 형식으로
# 역코딩하여 position2 칼럼에 추가하시오.
dataset2$position2 <- NA


# 05. dataset2의 gender 칼럼을 대상으로 1->"남자", 2->"여자" 형태로 코딩 변경하여 
# gender2 칼럼에 추가하고, 파이 차트로 결과를 확인하시오.
dataset2$gender2 <- NA


# 06. 나이를 30세 이하 -> 1, 31~55 -> 2, 56이상 -> 3 으로 리코딩하여 age3 칼럼에 추가한 후 
# age, age2, age3 칼럼만 확인하시오.
dataset2$age3 <- NA



