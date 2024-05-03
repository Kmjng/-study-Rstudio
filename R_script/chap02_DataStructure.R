### chap02_DataStructure

#############################
## 제2장 자료구조의 유형 
#############################

### 1. Vector 자료구조 
# - 동일한 자료형을 갖는 1차원 배열구조
# - 생성 함수 : c(), seq(), rep()

# 1) c(값1, 값2, ...) 함수
var1 <- c(23,-12, 10:20)
var1
# >> 23 -12  10  11  12  13  14  15  16  17  18  19  20
length(var1) # 13 
mode(var1) # numeric # 수치형
sum(var1) # 176
mean(var1) # 13.53846


# 2) seq(from, to, by) 함수 
var2 =seq(1, 10, 2)
mode(var2) # numeric
var2 # 1 3 5 7 9


# 3) rep(x, times | each) 함수 # 반복 repeat
var3 <- rep(1:3, times=3) # 123을 3번 반복 
var3 # 1 2 3 1 2 3 1 2 3 

var4 <- rep(1:3, each=3)
var4 # 1 1 1 2 2 2 3 3 3 


# 4) 색인(index) 참조  
# 변수명[n] ; n = 1~n
print(var1)
var1[10] # 17 (10번의 요소)
var1[-c(5,10)] # (나머지 요소들 참조)
var1[5:10] # 5~10번 요소들 참조

# 조건 색인 ; 대괄호 안에 조건식 
var1[var1 >= 15]
# 23 15 16 17 18 19 20

# 논리연산자 사용 : &(and), |(or), !(not)
# 파이썬의 pandas와 동일
var1[!(var1 >15)] # !(조건)

# 함수 사용 
var1[seq(from=2, to=length(var1), 2)]
# 2번째 ~ 끝까지 2간격으로 


### 2.Matrix 자료구조
# - 동일 자료형을 갖는 2차원 배열
# - 생성함수 : matrix, rbind, cbind
# - 처리함수 : apply
# - 동일 자료형을 갖는 2차원 배열 
# - 생성함수 : matrix, rbind, cbind
# - 처리함수 : apply

 
mat1 <- matrix(data=1:10, nrow=2, 
               ncol=5, byrow=TRUE) # byrow=TRUE ; 열 부터 채움 
mat1
#[,1] [,2] [,3] [,4] [,5]
#[1,]    1    2    3    4    5
#[2,]    6    7    8    9   10

x1 = 1:5 # c(1:5) 과 동일 
x2 = 6:10 # c(6:10) 과 동일 

mat2 = matrix(data = x1+x2, nrow=2, 
              ncol=5, byrow=TRUE)
mat2 # x1+x2 각각 원소를 더해서 계산 (내부 계산)

# cbind (column으로 bind)
mat3 = cbind(x1,x2)
mat3
#     x1 x2 
#[1,]  1  6
#[2,]  2  7
#[3,]  3  8
#[4,]  4  9
#[5,]  5 10

# rbind (row로 bind )
mat4 = rbind(x1,x2)
mat4
#[,1] [,2] [,3] [,4] [,5]
#x1    1    2    3    4    5
#x2    6    7    8    9   10


# 4) 색인(index) 참조 
mat1[1,] # 1행 전체 
mat1[,2] # 2열 전체  #[1] 2 7
mat1[1,2] # 원소 하나 
mat1[, c(2:3)]

# 5) apply(data, 행/열, Func) 함수 
# 행 단위 = 열 축 
# 열 단위 = 행 축

# 두번째 인수 ; 1: 행, 2: 열 ★★★
result = apply(mat1, 1, mean) # mean 평균 함수 #괄호 x 
result # >> 3 8 (1행 평균과 2행 평균)  

result2 = apply(mat1, 2, mean) # mean 평균 함수 #괄호 x 
result2 # >> 3.5 4.5 5.5 6.5 7.5 


### 3. Array 자료구조 
# - 동일 자료형을 갖는 3차원 배열
# - 생성함수 : array

# array(data, dim) ★★★★
arr3d = array(1:12 , dim= c(3,2,2)) # 3행2열 2면 
# 주의: 파이썬은 (면,행,렬)

# 색인 사용 
arr3d[,,2] # 2면

arr3d[c(1:3),,1] # 1~3행, 1면 


# 데이터셋 
data('iris3') # memory load
dim(iris3)
# 50 4 3 # 50*4 3면 
str(iris3)
#..$ : NULL  => 행 이름 없음 
#..$ : chr [1:4] "Sepal L." "Sepal W." "Petal L." "Petal W."
#..$ : chr [1:3] "Setosa" "Versicolor" "Virginica"
