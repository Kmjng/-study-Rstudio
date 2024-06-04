#################################
## <제4-2장 연습문제>
#################################   


# 문1) 다음 사원정보(EMP)는 '입사년도이름급여'순으로 3명의 사원 정보가 기록되어 있다. 
#  이 자료를 이용하여 다음과 같은 <출력 결과>가 나타나도록 함수를 완성하시오. 

#  <출력 결과>
# 전체 급여 평균 : 260

# 사원정보 
EMP <- c("2014홍길동220", "2020이순신300", "2010유관순260")

library(stringr) 
# 각 사원의 급여 추출 : str_extract_all(EMP, '패턴') 함수 이용 
year_lst <- str_extract_all(EMP, '[0-9]{4}')
mode(year_lst) # list 

name_lst <- str_extract_all(EMP, '[가-힣]{3}')
name_lst

pay_lst <- str_extract_all(EMP, '[0-9]{3}$') 
# $ 는 '접미어' ★★★
pay_lst

# 급여 평균 계산 함수 
emp_pay <- function(EMP) {  
  pay_vector <- unlist(str_extract_all(EMP, '[0-9]{3}') )
  pays <- as.numeric(pay_vector)
  cat('전체 급여 평균:', mean(pays))
  
}


# 급여 평균 계산 함수 호출 
emp_pay(EMP) # 사원정보(EMP) 실인수   



# 02. 정규분포(평균=5, 표준편차=2)를 따르는 난수 10개를 생성한 후 정수 반올림한 결과가 짝수인 경우만
# 벡터 변수에 저장하고 출력하시오.

# <출력결과>
# 난수 : 3.879049 4.539645 8.117417 5.141017 5.258575 8.43013 5.921832 2.469878 3.626294 4.108676
# 정수 반올림한 짝수 : 4 8 8 6 2 4 4
set.seed(123) # seed값 
x <- rnorm(7, mean=5, sd=2)

result <- c() 

for(num in x){
  if(round(num) %% 2 == 0 ){ #짝수 여부 
    # 정수 반올림한 짝수 저장
    result <- c(result, round(num)) # 빈벡터 저장 
    }
}

cat('난수:', x, '\n')
cat('정수 반올림한 짝수:', result)

# 정수 반올림한 짝수: 2 4 4 6 6 4 8 8 6
