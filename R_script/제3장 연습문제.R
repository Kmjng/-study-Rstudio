#################################
## <제3장 연습문제>
#################################   
#01. 본문에서 작성한 titanic 변수를 다음과 같은 단계로 처리하시오.

#[단계 1] "C:\ITWILL\5_R\R_Statistics\Outputs"폴더에 'titanic.csv'로 저장한다.
#힌트: write.csv() 함수 사용
write.csv(titanic, 
          "C:/ITWILL/5_R/R_Statistics/Outputs/titanic.csv",
          row.names=FALSE, quote = FALSE)

#[단계 2] 'titanic.csv' 파일을 titanicData 변수로 가져와서 결과를 확인하고, titanicData의 관측치와 칼럼수를 확인한다.
#힌트: str() 함수 사용
titanicData <- read.csv('C:/ITWILL/5_R/R_Statistics/Outputs/titanic.csv')
str(titanicData) # ...5 variables:...

#[단계 3] 1번, 3번 칼럼을 제외한 나머지 칼럼을 대상으로 상위 6개의 관측치를 확인한다. 
titanicData_1 <- head(subset(titanicData, select = -c(1,3)),6)
str(titanicData_1) # ...6 obs. of  3 variables...

# 02. R에서 제공하는 quakes 데이터셋을 대상으로 다음과 같이 처리하시오

data("quakes")
quakes # 지진 진앙지 데이터 셋 
str(quakes)
# 'data.frame':	1000 obs. of  5 variables:

# [단계1] 현재 경로에 row.names, quote 없이 "quakes_df.csv" 파일로 저장하기  
write.csv(quakes, "quakes_df.csv", row.names=FALSE, quote = FALSE)
# [단계2] quakes_data로 파일 읽어오기 
quakes_data <- read.csv("quakes_df.csv")
# [단계3] mag 변수를 대상으로 평균 계산하기 
mean(quakes_data$mag) # [1] 4.6204


# 03. 다음 Data를 대상으로 정규표현식을 적용하여 문자열을 처리하시오
Data <- c("2021-02-05 수입3000원","2021-02-06 수입4500원","2021-02-07 수입2500원")

library(stringr)


# [단계1] 일짜별 수입을 다음과 같이 출력하시오. 
# <출력 결과>  "3000원" "4500원" "2500원" 
# 힌트) str_extract_all()함수 이용  

# [단계2] 연속으로 2개 이상 나오는 모든 숫자를 제거하시오.  
# <출력 결과> "-- 수입원" "-- 수입원" "-- 수입원"  
# 힌트) str_replace_all()함수 이용   


# [단계3] 모든 '-'를 '/'로 치환하시오.
# <출력 결과>  "2021/02/05 수입3000원" "2021/02/06 수입4500원" "2021/02/07 수입2500원"  
# 힌트) str_replace_all()함수 이용 


# [단계4] 모든 원소를 쉼표(,)에 의해서 하나의 문자열로 합치시오. 
# <출력 결과>  "2021-02-05 수입3000원,2021-02-06 수입4500원,2021-02-07 수입2500원"
# 힌트) str_c()함수 이용


# 04. 오바마연설문(obama.txt)을 대상으로 다음 조건에 맞게 단어구름으로 시각화하시오.
# <조건1> 단어 길이 제한 : 2음절 ~ 14음절 
# <조건2> APPLAUSE, CHEERS 단어 제외 
# <조건3> 단어구름 시각화 대상 : 출현빈도수 3회 이상 

# 단계1 : text file read 
obama <-file(file.choose())  # obama.txt 파일 선택 
obama_data <- readLines(obama) # 줄 단위(문장 단위) 읽기
close(obama) # file 객체 닫기

print(obama_data)




