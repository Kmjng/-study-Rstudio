#################################
## <제5장 연습문제>
################################# 

# 01. 다음 Bug_Metrics_Software 데이터셋을 이용하여 시각화하시오. 
install.packages('RSADBE')
library(RSADBE) # 패키지 로드  
data(Bug_Metrics_Software) # 데이터셋 로드 

str(Bug_Metrics_Software) # 데이터셋 구조보기 
# num [1:5, 1:5, 1:2] -> [행, 열, 면]

# 5개 소프트웨어 발표 전 각 버그 수와 발표 후 각 버그의 수 
before <- Bug_Metrics_Software[,,1] # 1면: 소프트웨어 발표 전
after <- Bug_Metrics_Software[,,2] # 2면: 소프트웨어 발표 후 


before # 소프트웨어 발표 전 버그 수
after # 소프트웨어 발표 후 버그 수

# 단계1) 소프트웨어 발표 전 버그 수를 대상으로 각 소프트웨어별 버그를
# beside형 세로막대 차트로 시각화하기(각 막대별 색상적용) 
par(mfrow=c(1,2))

barplot(before, beside=T,col=rainbow(5),
        main="소프트웨어 발표 전 버그 수",
        legend.text = row.names(before),
        args.legend = list(x = 'topright'))

# 단계2) 소프트웨어 발표 후 버그 수를 대상으로 각 소프트웨어별 버그를
# 누적형 가로막대 차트로 시각화하기(각 막대별 색상적용) 
barplot(after, beside=F,col=rainbow(5),
        main="소프트웨어 발표 후 버그 수",
        legend.text = row.names(after),
        args.legend = list(x = 'topright'))

# 02. quakes 데이터 셋을 대상으로 다음 조건에 맞게 시각화 하시오.
data(quakes) # 데이터셋 로드  
str(quakes) # 데이터셋 구조보기 


# 조건1) 1번 칼럼 : y축, 2번 컬럼 : x축 으로 산점도 시각화
plot(quakes$lat ~ quakes$long)

# 조건2) 5번 컬럼으로 색상 지정 : 힌트) col 속성
plot(quakes$lat ~ quakes$long, col=quakes$stations)

# 조건3) "지진의 진앙지 산점도 차트" 제목 추가 : 힌트) main 속성  
plot(quakes$lat ~ quakes$long, col=quakes$stations,
     main="지진의 진앙지 산점도 차트" )

# 조건4) "quakes.jpg" 파일명으로 차트 저장하기
# 작업 경로 : "C:/ITWILL/5_R_Statistics/output"
# 파일명 : quakes.jpg
 #픽셀 : 폭(720픽셀), 높이(480 픽셀)
setwd("C:/ITWILL/5_R_Statistics/output")

jpeg("quakes.jpg", width = 720, height = 480) # open
plot(quakes$lat ~ quakes$long, col=quakes$stations,
     main="지진의 진앙지 산점도 차트" ) # 차트 
dev.off() # close


# 03. iris3 데이터 셋을 대상으로 다음 조건에 맞게 산점도를 그리시오.

# 조건1) iris3 데이터 셋의 자료구조 확인 : 힌트) str() 
str(iris3) # 3차원 자료 
# num [1:50, 1:4, 1:3] 5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# - attr(*, "dimnames")=List of 3
# ..$ : NULL
# ..$ : chr [1:4] "Sepal L." "Sepal W." "Petal L." "Petal W."
# ..$ : chr [1:3] "Setosa" "Versicolor" "Virginica"

# 조건2) "Versicolor" 꽃의 종을 대상으로 산점도 행렬 : 힌트) pairs()  
Versicolor <- iris3[,,"Versicolor"]
pairs(Versicolor)


# 04. 각 년도별 물가상승률과 라면값 증가율을 비교하는 차트를 시각화하시오. 
# 시각화 결과 : "chap05_4번연습문제결과.png" 파일 참고 
# 힌트 : plot 2개 겹치기

setwd("C:/ITWILL/5_R_Statistics/data")

noodel = read.csv(file="noodle.csv")
str(noodel)
# 'data.frame':	28 obs. of  3 variables:
# $ year  : num  1980 1981 1982 1984 1985 ...
# $ price : int  0 5 10 15 20 25 30 35 40 45 ...
# $ noodle: int  0 0 3 3 6 6 9 9 12 12 ...

plot(noodel$year, noodel$price, ylim = c(0,500),
     type = 'o', ann = FALSE, col='blue')
# ylim : y축 범위 
# ann = FALSE : 축이름 제외

par(new = T) # 그래프 겹치기 
plot(noodel$year, noodel$noodle, ylim = c(0,500),
     type = 'o', axes = FALSE, ann = FALSE, col='red')
# axes = FALSE : 축눈금 제외

# 제목 & 축 이름 추가
title(main = "물가와 라면값 증가율 비교")
title(xlab = "년도", col.lab='blue')
title(ylab = "증가율", col.lab='red')
# 범례추가 
legend(x=1980, y=500, legend = c("물가", "라면값"),
       col = c('blue', 'red'), lty = 1)









