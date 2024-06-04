# chap04_2_Function

### 1. 사용자정의함수 

# 함수명 <- function([인수]){
#   실행문1
#   실행문2
#   [return(값)] # 대괄호는 생략가능을 의미
# }


# 1) 인수(매개변수)가 없는 함수 
f1 <- function(){
  cat('인수가 없는 함수')
}

x=4
# 2) 인수가 있는 경우 
f2 <- function(x){ # x : 가인수
  cat('x의 값 =', x, '\n')
  print(x^2)
  return(x^2)
}
f2(x)
# x의 값 = 4 
# [1] 16
# [1] 16


# 3) 반환(리턴)값이 있는 함수 
f3 <- function(x, y){
  add <- x + y
  return(add) # 파이썬과 다르게 리턴 하나만 가능
}



# 예1) 표본분산, 표본표준편차를 구하는 함수를 정의하기 
# 표본분산 식 : var = sum((x - 산술평균)^2) / (n-1)
# 표본표준편차 식 : sd = sqrt(var)

x <- c(7, 5, 12, 9, 15, 6)

# 산술평균 함수 
avg <- function(x){
  return(sum(x) / length(x))
}

# 분산과 표준편차 함수 
var_sd <- function(x){    
  a <- avg(x) # 1. 산술평균     
  var <- sum((x - a)^2) / (length(x)-1) # 2. 분산     
  sd <- sqrt(var) # 3. 표준편차
  cat('var = ', var, '\n')
  cat('sd = ', sd)
}



# 예2) 구구단 출력 함수 정의하기  
gugu <- function(dan){
  cat('***', dan,'단 **\n')
  for(i in 1:9){
    cat(dan,'*',i,'=', dan*i, '\n')
  }
}

###########################################
### 2. R 주요 내장함수 

# 1) 기술통계함수 
data = sample(x=1:10, size=10, replace = T) # 자료 
data # x: 모집단, size: 표본수, replace: 복원(T), 비복원(F)
#[1]  3  8 10  7  4  1  2  4
#[9]  9  3
min(data)                   # 최소값
max(data)                   # 최대값
range(data)                  # 범위
mean(data)                   # 평균
median(data)                # 중위수
sum(data)                   # 합계
prod(data)                  # 데이터의 곱
summary(data)               # 요약통계량 
var(data)                   # 분산 
sd(data)                    # 표준편차
sqrt(var(data))             # 분산 제곱근 
sd(data)**2                 # 표준편차의 제곱 

factorial(5) # 팩토리얼=120(1*2*3*4*5)


# 2) 반올림 관련 함수 
x <- c(1.5, 2.5, -1.3, 2.6, 3.5, 4.6)
ceiling(x) # x보다 큰 정수 : 2  3 -1  3  4 5
floor(x) # x보다 작은 정수 : 1  2 -2  2  3 4
round(x) # 2  2 -1  3  4  5 : 하스켈 반올림(Round-to-even 방식) 

# 3) 로그 & 지수 함수 
log2(8) # 자연로그 : 밑수 2 : 8은 2의 몇승? 3
log(8) # 자연로그 : 밑수 e : 8은 e의 몇승? 2.079442
log10(10) # 상용로그 : 밑수 10 : 10은 10의 몇승? 1

# 지수 함수 : 무리수 e에 대한 거듭제곱값 
exp(2.0794) # 7.999668


# 4) 행렬관련 함수
x <- matrix(1:9, nrow = 3, ncol = 3, byrow = T) # 3x3 정방행렬 
y <- matrix(1:3, nrow = 3) # 3x1 행렬  
ncol(x) # 3 : 열 수 반환 
nrow(x) # 3 : 행 수 반환 
t(x) # x의 전치행렬 반환


# 5) 선형대수학(linear algebra) 

# (1) 대각행렬 : 대각선 값 반환
diag(x) # 행렬 x의 대각행렬 

# (2) 행렬곱 : x,y의 행과 열의 곱의 합 
mat <- x %*% y 
dim(mat) # 3 1
dim(x) # 3 3
dim(y) # 3 1

# (3) 행렬식 : 좌대각과 우대각의 곱의 차
x2 <- matrix(1:4, nrow = 2)
det(x2) # determinant


# (4) 특이값 분해(행렬분해 : Matrix Factorization) - 특이값으로 행과 열 분해 
# - 특이값으로 행렬A 분해 

# 행렬A
A <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2)
A # 2x3
#      [,1] [,2] [,3]
#[1,]    1    3    5
#[2,]    2    4    6

# 특이값으로 행렬 분해 
SVD <- svd(A)
SVD # $d, $u, $v 세 개가 나옴 : 특이값, 행의특징, 열의특징 
# [,1]       [,2]
# [1,] -0.2298477  0.8834610
# [2,] -0.5247448  0.2407825
# [3,] -0.8196419 -0.4018960


# 근사 행렬 계산식 : A_pred = u @ diag(d) @ t(v)
A_pred = SVD$u %*% diag(SVD$d) %*% t(SVD$v)
A_pred



# 6) 난수 & 확률분포 
# 연속확률분포 : 주어진 구간에서 나올 수 있는 셀 수 없는 값 
# 이산확률분포 : 주어진 구간에서 나올 수 있는 셀 수 있는 값 

# (1) 정규분포를 따르는 난수 : 연속확률분포
# 형식) rnorm(n, mean=0, sd=1)
n <- 1000
r <- rnorm(n, mean=0, sd=1) 


# (2) 균등분포를 따르는 난수 : 연속확률분포
# 형식) runif(n, min=0, max=1)
r2 <- runif(n, min = 0, max = 1)  

hist(r2) # 균등분포 확인 


# (3) 이항분포를 따르는 난수 : 이산확률분포
# 형식) rbinom(n, size, prob)  
# n: 표본 수, size: 시행횟수, prob: 성공확률 

# size=1 : 베르누이분포  
r3_1 <- rbinom(n=10, size = 1, prob = 0.5) 
r3_1  # [1] 1 0 1 0 0 0 0 0 0 0

# size = n : 이항분포  
r3_2 <- rbinom(n=10, size = 10, prob = 0.5) 
r3_2  # [1] 6 6 5 6 6 6 7 2 8 6



