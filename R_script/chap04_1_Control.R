# chap04_1_Control

# 1. 연산자 유형

# 1) 산술연산자 
num1 <- 100 # 피연산자1
num2 <- 20  # 피연산자2
result <- num1 + num2 # 덧셈
result # 120
result <- num1 - num2 # 뺄셈
result # 80
result <- num1 * num2 # 곱셈
result # 2000
result <- num1 / num2 # 나눗셈
result # 5

result <- num1 %% num2 # 나머지 계산 # 파이썬은 % 
result # 0

result <- num1^2 # 제곱 계산(num1 ** 2)
result # 10000
result <- num1^num2 # 100의 20승
result # 1e+40 -> 1 * 10의 40승과 동일한 결과


# 2) 관계연산자 
# (1) 동등비교 
boolean <- num1 == num2 # 두 변수의 값이 같은지 비교
boolean # FALSE
boolean <- num1 != num2 # 두 변수의 값이 다른지 비교
boolean # TRUE

# (2) 크기비교 
boolean <- num1 > num2 # num1값이 큰지 비교
boolean # TRUE
boolean <- num1 >= num2 # num1값이 크거나 같은지 비교 
boolean # TRUE
boolean <- num1 < num2 # num2 이 큰지 비교
boolean # FALSE
boolean <- num1 <= num2 # num2 이 크거나 같은지 비교
boolean # FALSE

# 3) 논리연산자(and, or, not, xor)
logical <- num1 >= 50 & num2 <=10 # 두 관계식이 같은지 판단 
logical # FALSE
logical <- num1 >= 50 | num2 <=10 # 두 관계식 중 하나라도 같은지 판단
logical # TRUE

logical <- !(num1 >= 50) # 관계식에 대한 부정 
logical # FALSE

x <- TRUE; y <- FALSE
xor(x,y) # [1] TRUE
x <- TRUE; y <- TRUE
xor(x,y) # FALSE



### 2. 조건문 : if(조건식), ifelse(조건식), which(조건식)

# 1) if 형식1 : 단일선택 
# if(조건식){
#    실행문 
# }else{
#   실행문
# }


x <- 50 # x <- 20

if(x >= 40){  
  x = x * 2
  cat("x =", x) # TRUE
}else{
  x = x + 2
  cat("x = ", x) # FALSE
}


# 2) if형식2 : 다중선택 
# 파이썬은 elif
# if(조건식1){
#    실행문1 
# }else if(조건식2){
#   실행문2
# }else{
#  실행문3
# }

# 다중선택 if문  
if(score>=90 & score <= 100){
  cat('A학점 : ', score)
}else if(score >= 80){
  cat('B학점 : ', score)
}else if(score >= 70){
  cat('C학점 : ', score) 
}else{
  cat('F학점 : ', score) 
}


# 3) ifelse(조건식, 참, 거짓)
# 한줄 
score <- c(75,85,65,NA,72,55)
ifelse(score >= 70, '합격', '불합격')
# [1] "합격"   "합격"   "불합격" NA "합격"   "불합격"

# ifelse를 통해 결측치를 평균으로 대체 
# is.na(score)
# [1] FALSE FALSE FALSE  TRUE
# [5] FALSE FALSE
ifelse(is.na(score), mean(score, na.rm=TRUE), score)

# 4) which()
x <- c(2,5,10:20, 30:50) # 벡터에서 위치 찾기 
which(x == 19) 

# 데이터프레임에서 이용 찾기 
no <- c(1:5)
name <-c("홍길동","이순신","강감찬","유관순","김유신")
score <- c(85,78,89,90,74)

exam <- data.frame(학번=no,이름=name,성적=score)

### 3. 반복문 : for(), while()

# 1) for
num <- 1:10

for(x in num){
  cat('x=', x, '\n')
}


for(x in num){
  if(x %% 2 == 0){ # 짝수 
    print(x)
  }else{ # 홀수 
    next  # skip (파이썬에서 pass와 같은 기능 )
  } 
}  

even <- 0 # 짝수 합 
odd <- 0 # 홀수 합 

for(x in num){
  if(x %% 2 == 0){ # 짝수 
    even <- even + x # 누적변수 
  }else{ # 홀수 
    odd <- odd + x
  } 
}  

cat('even=', even, ', odd=', odd)


# 학성관리 
kor <- c(65, 89, 96)
eng <- c(69,98,66)
mat <- c(55, 88, 85)
name <- c('홍길동', '이순신', '유관순')

student <- data.frame(name, kor, eng, mat)
student
# name kor eng mat
# 1 홍길동  65  69  55
# 2 이순신  89  98  88
# 3 유관순  96  66  85



# 총점과 평균 칼럼 추가 
tot <- student$kor + student$eng + student$mat
tot
student$tot <- tot
student$avg <- round(tot/3, 2)

student

# grade 칼럼 : for문 + index
size <- length(student$name) # 인원수 
avg <- student$avg # 평균값
avg # [1] 63.00 91.67 82.33

grade <- c() # 빈 벡터 : 등급 저장 
# 파이썬에서는 grade =[]


# 반복 + 조건 
for(i in avg){
  if(i >= 90){
    grade <- c(grade, 'A') # 벡터변수에 등급 누적
  }else if(i >= 80){
    grade <- c(grade, 'B')
  }else if(i >= 70){
    grade <- c(grade, 'C')
  }else{
    grade <- c(grade, 'F')
  }
}
grade # "F" "A" "B"

# 칼럼 추가 
student$grade <- grade
student



# 2) while

i = 0 # 초기화 

while (i < 10) {
  i <- i + 1 # 카운터 변수 
  cat(i, ' ') # 같은 라인 중복 출력 
}

# while문으로 x의 각 변량중 10의 배수만 y에 저장하기 
x <- 1:1000 # 1~1000
y <- c() # 빈 벡터 : 10의 배수 저장 
i <- 0 # 색인 역할   

while(i < length(x)) {
  i <- i + 1 # 카운터  
  if(i %% 10 == 0) {
    y <- c(y, x[i]) 
  }  
}

cat('y =', y)



