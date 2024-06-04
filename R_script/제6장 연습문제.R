#################################
## <제6장 연습문제>
################################# 

# 01. dplyr 패키지에서 제공하는 함수를 이용하여 다음과 같이 단계별로 처리하시오. 
library(dplyr)

# 변수명 확인 
names(iris)
# [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species" 

# [단계1] iris의 꽃잎의 길이(Petal.Length) 칼럼을 대상으로 5.0 이상의 값만 필터링하여 q1에 저장하시오.
q1 <- 

# [단계2] 01번에서 만든 q1을 대상으로 1,3,5번 칼럼만 선택하여 q2에 저장하시오.
q2 <- 

# [단계3] 02번에서 만든 q2를 대상으로 1번 - 3번 칼럼의 차를 구해서 diff 파생변수를 만들고, q3에 저장하시오.
q3 <- 

# [단계4] 03번에서 만든 q3를 대상으로 꽃의 종(Species)별로 그룹화하여 Sepal.Length와 Petal.Length 변수의 평균을 계산하시오.
q4 <- 


# 02. datasets 패키지에서 제공하는 CO2 데이터셋을 대상으로 다음과 같은 <출력 결과>가 나타나도록 단계별로 처리하시오. 

# <결과 화면>
#           Type nonchilled  chilled
#1      Quebec   35.33333 31.75238
#2 Mississippi   25.95238 15.81429


library(datasets)
str(CO2) # 데이터셋 구조 보기 


# [단계1] 'Type','Treatment','uptake' 칼럼을 선택하여 df 이름으로 데이터프레임 생성하기 
# 힌트 : subset() 함수 이용 
df <- subset(CO2, select = c('Type','Treatment','uptake'))
df
# [단계2] 'Type'과 'Treatment' 칼럼을 행과 열로 지정하고, uptake' 칼럼의 평균으로 테이블 생성하기
# 힌트) dcast() 함수 이용 
install.packages('reshape2')
library(reshape2)
result <- dcast(df, Type ~ Treatment, mean)
# Using uptake as value column: use value.var to override.
result
# Type nonchilled  chilled
# 1      Quebec   35.33333 31.75238
# 2 Mississippi   25.95238 15.81429
