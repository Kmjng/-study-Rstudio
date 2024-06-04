#################################
## <제4-1장 연습문제>
#################################  

# 문) client를 대상으로 각 조건의 <완성결과>와 같이 처리하시오.[조건문]

# vector 준비 
name <-c("유관순","홍길동","이순신","신사임당","강호동")#고객명 
gender <- c("F","M","M","F","M")# 성별 
price <-c(65,50,45,75,55)# 구매금액 

# DataFrame 만들기 : 고객명, 성별, 구매금액
client <- data.frame(name, gender, price)
client
# name gender price
# 1   유관순      F    65
# 2   홍길동      M    50
# 3   이순신      M    45
# 4 신사임당      F    75
# 5   강호동      M    55

# <조건1> price가 65만원 이상인 고객은 "Best", 65만원 미만이면 
#  "Normal" 문자열을 client의 class 컬럼으로 추가하기 : 힌트) ifelse() 이용
# 주의: ifelse 사용법 유의할 것 
class <- ifelse(client$price >= 65, 'Best', 'Normal')
client

# DataFrame에 칼럼 추가 ★
client$class <- class

# <완성결과> 
#      name gender price  class  
#1   유관순     F    65    Best 
#2   홍길동     M    50  Normal  
#3   이순신     M    45  Normal 
#4 신사임당     F    75    Best   
#5   강호동     M    55  Normal 


# <조건2> class의 범주별 빈도수 출력하기 : 힌트) table 이용

# <완성결과> 
# Best Normal 
#    2      3


# <조건3> gender가 'M'이면 "Male", 'F'이면 "Female" 형식으로 client에
#  gender2 컬럼으로 추가하기 : 힌트) ifelse() 이용 
gender2 <- ifelse(client$gender =='M', 'Male', 'Female')
client$gender2 <- gender2
client
# <완성결과> 
#      name gender price  class gender2
#1   유관순      F    65   Best  Female
#2   홍길동      M    50 Normal    Male
#3   이순신      M    45 Normal    Male
#4 신사임당      F    75   Best  Female
#5   강호동      M    55 Normal    Male


# <조건4> gender2와 class 변수를 이용하여 교차분할표 작성하기 
# - 성별에 따른 구매패턴 확인 : 힌트) table() 이용

# <완성결과>
#       Best Normal
# Female   2      0
# Male     0      3
table(client$gender2, client$class)


# <조건5> 고객명의 음절길이가 4자 이상인 고객 자료 삭제 : 힌트) which 이용 
library(stringr) # str_length() : 문자열 길이 반환 

# <완성결과>
#    name gender price  class gender2
#1 유관순      F    65   Best  Female
#2 홍길동      M    50 Normal    Male
#3 이순신      M    45 Normal    Male
#5 강호동      M    55 Normal    Male
idx <- which(str_length(client$name) >=4 )
idx # 4 #4의 이름이 4자 이상임

new_client <- client[-idx,] # 4번을 빼라 ★★★
new_client



