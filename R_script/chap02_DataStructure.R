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

# 2024-05-07

### 4.DataFrame 자료구조 
# - 서로 다른 자료형을 갖는 컬럼으로 구성 
# - 생성함수 : data.frame
# - 처리함수 : apply

# 1) vector 생성 
eno <- 1:3 # c(1:3) 와 동일 
ename <- c("hong", "lee", "yoo")
age <- c(35, 45, 25)
pay <- c(250, 350, 250)
# 2) DataFrame 생성
emp <- data.frame(eno, ename, age, pay)
emp
# eno ename age pay
# 1   1  hong  35 250
# 2   2   lee  45 350
# 3   3   yoo  25 250

# 특정 칼럼 참조하는 방법 
# DF$칼럼명
pay <- emp$pay
pay # [1] 250 350 250


str(emp)
# 'data.frame':	3 obs. of  4 variables:
#   $ eno  : int  1 2 3
# $ ename: chr  "hong" "lee" "yoo"
# $ age  : num  35 45 25
# $ pay  : num  250 350 250


#DF[row, col]
emp[1,] # 1행 전체 #  hong 사원정보 

# apply(X, MARGIN = , FUN = )
apply(emp[,3:4], MARGIN = 2, FUN= mean)
# MARGIN = 2 ; 열에 대해 
# age      pay 
# 35.0000 283.3333 


### 5. List 자료구조 

# R에서는 파이썬의 dict가 List임 ★★★★
# - 키와 값 쌍으로 구성된 자료 구조(키를 통해서 값 참조)  
# - 생성 함수 : list(key1=value, key2=value, ...)
#  - 각 키별로 다른 자료형의 값을 갖는다. 
# - 처리 함수 : unlist, do.call, lapply, sapply

# 1) list(key=value) 형식 
member <- list(name="홍길동",
               age=35, address="한양",
               gender="남자", htype="아파트")

member
# $name
# [1] "홍길동"
# 
# $age
# [1] 35 ....

# key -> value 참조 
member$name # '홍길동'
member$age <- 45 # 값 수정 

# 2) list(value) 형식 : key 생략 
# [[1]] 을 기본 key로 제공

member2 <- list("홍길동",35, "한양")


# 3) key = value(n) 형식 
lst3 <- list(name=c("홍길동", "유관순"),
             age=c(35, 25),
             gender=c('M', 'F'))


# 4) 다양한 자료구조(vector, matrix, array) 
lst4 <- list(one = c('one','two', 'three'),
             two = matrix(1:9, nrow=3),
             three = array(1:12, c(2,3,2)))



# 5) list 처리 함수
# 중첩 리스트 (multi-list) 
multi_list <- list(r1 = list(1,2,3),
                   r2 = list(10,20,30),
                   r3 = list(100,200,300))
multi_list

# [1] do.call(func, object) : list -> matrix 변환 
# 리스트를 2차원 행렬로 변환
# do.call(함수, 객체)
do.call(rbind, multi_list)
# [,1] [,2] [,3]
# r1 1    2    3   
# r2 10   20   30  
# r3 100  200  300 

# [2] unlist(x) : list -> vector 변환 
# 리스트를 1차원 벡터로 변환 
x <- list(1:10)

# [3] list 처리 함수 : lapply, sapply
a <- list(1:5)
b <- list(6:10)
lapply(c(a,b), max) # 5 10 

### 6. 서브셋(subset) 만들기 
x <- 1:5
y <- 6:10
z <- letters[1:5] # "a" "b" "c" "d" "e"

# 실습용 데이터프레임 작성 
df <- data.frame(x, y, z)


help("subset") # subset 도움말 
# subset(x, subset, select, drop = FALSE, ...)

df2 <- subset(df, select = y:z ) #select= c(y:z)
df2

# 조건식으로 서브셋 선택
df3 <- subset(df, subset = y>=8 )

# 조건식 2
# 칼럼명 %in% (list)
df4 <- subset(df, subset = z %in% c('a','c','e'))


# example 
data("iris") # Rstudio 제공 제공 

str(iris) # 붓꽃 데이터셋 
# 'data.frame':	150 obs. of  5 variables:
# $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...     꽃받침 길이 
# $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...   꽃받침 넓이   
# $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...  꽃잎 길이 
# $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...  꽃잎 넓이 
# $ Species     : Factor w/ 3 levels "setosa","versicolor",..:      꽃의종 : 요인형 
# Factor 는 범주형을 의미함 
mode(iris) # "list"

iris_df <- subset(iris, select= c(Sepal.Length, Petal.Length, Species))
mode(iris_df)

mean(iris_df$Petal.Length) # 3.758

iris_df2 <- subset(iris_df, 
                   subset= Petal.Length >=mean(iris_df$Petal.Length))


