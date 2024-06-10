#################################
## <제13장 연습문제>
################################# 

# 01. 교육수준(education)과 흡연율(smoking) 간의 관련성을 분석하기 위한 가설을 수립하고, 
# 이를 토대로 가설을 검정하시오.[독립성 검정]

# 귀무가설 : 교육수준(education)과 흡연율(smoking)은 독립적이다. 
# 연구가설 : 교육수준(education)과 흡연율(smoking)은 독립적이 않다.(관련성) 

#<단계 1> 파일 가져오기
setwd("c:/ITWILL/5_R_Statistics/data")
smoke <- read.csv("smoke.csv", header=TRUE)
# 변수 보기
head(smoke) # education, smoking 변수

#<단계 2> education, smoking 변수 코딩변경   
# education(1,2,3) ->  education2(1:대졸, 2:고졸, 3:중졸) 
# smoking(1,2,3) -> smoking2(1:과다흡연, 2:보통흡연, 3:비흡연) 

# 1) education2 : education 변수 이용 코딩변경 
smoke$education2[smoke$education == 1] <- '1:대졸'
smoke$education2[smoke$education == 2] <- '2:고졸'
smoke$education2[smoke$education == 3] <- '3:중졸'
table(smoke$education2)

# 2) smoking2 : smoking 변수 이용 코딩변경
smoke$smoking2[smoke$smoking == 1] <- "1:과다흡연"
smoke$smoking2[smoke$smoking == 2] <- "2:보통흡연"
smoke$smoking2[smoke$smoking == 3] <- "3:비흡연"
table(smoke$smoking2) 


#<단계 3> 교차분할표 작성 : 코딩변경된 변수 이용  
table(smoke$education2, smoke$smoking2)

#          1:과다흡연 2:보통흡연 3:비흡연
# 1:대졸         51         92       68
# 2:고졸         22         21        9
# 3:중졸         43         28       21


#<단계 4> 독립성 검정(CrossTable 함수 이용)
CrossTable(smoke$education2, smoke$smoking2, chisq = TRUE)

#Pearson's Chi-squared test 
#------------------------------------------------------------
#Chi^2 =  18.91092     d.f. =  4     p =  0.0008182573 

#<단계 5> 검정결과 해석
# <해석1> p =  0.0008182573  < 0.05 : 기각 
# <해석1> Chi^2 =  18.91092 > 임계값(11.071) : 기각 

# [해설] 두 변수는 관련성이 있다라고 볼 수 있다.



# 02. 나이(age3)와 직위(position) 간의 관련성을 단계별로 분석하시오. [독립성 검정]
# 귀무가설 : 나이와 직위은 관련성이 없다.
# 대립가설 : 나이와 직위은 관련성이 있다.

#[단계 1] 파일 가져오기
data <- read.csv("cleanData.csv")
head(data)

#[단계 2] 변수 선택   
x <- data$position # 행 - 직위 변수 이용
y <- data$age2 # 열 - 나이 리코딩 변수 이용

table(x, y)

#[단계 3] 독립성 검정 : 힌트) chisq.test() 함수 이용 
chisq.test(x, y)
# X-squared = 287.9, df = 8, p-value < 2.2e-16

#[단계 4] 검정결과 해석 
# [해설] 매우 유의미한 수준에서 두 변수는 관련성 있다라고 보여진다. 


# 03. 직업유형에 따른 응답정도에 차이가 있는가를 단계별로 검정하시오.[동질성 검정]

# 귀무가설 : 직업유형에 따른 응답정도에 차이가 없다.
# 대립가설 : 직업유형에 따른 응답정도에 차이가 있다.

#[단계 1] 파일 가져오기
response <- read.csv("response.csv")
head(response) # 변수 보기
#   job response

# [단계 2] job, response 변수 리코딩 
# job(1,2,3) -> job2(1:학생, 2:직장인, 3:주부) 
# response(1,2,3) -> response2(1:무응답, 2:낮음, 3:높음)


# 1) job2 : job 변수 이용 리코딩
response$job2[response$job==1] <- "1:학생" 
response$job2[response$job==2] <- "2:직장인"
response$job2[response$job==3] <- "3:주부"

# 2) response2 : response 변수 이용 리코딩 
response$response2[response$response==1] <- "1:무응답" 
response$response2[response$response==2] <- "2:낮음" 
response$response2[response$response==3] <- "3:높음" 


# [단계 3] 교차분할표 작성
table(response$job2, response$response2)
#           1:무응답 2:낮음 3:높음
# 1:학생         25     37      8
# 2:직장인       10     62     53
# 3:주부          5     41     59

# [단계 4] 동질성 검정  
chisq.test(response$job2, response$response2)
# X-squared = 58.208, df = 4, p-value = 6.901e-12

# [단계 5] 검정결과 해석
# 매우 유의미한 수준에서 '직업유형에 따른 응답정도에 차이가 있다.'라고 볼 수 있다.







