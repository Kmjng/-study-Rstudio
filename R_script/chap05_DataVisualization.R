# chap05_DataVisualization 

### 1. 이산형 변수 시각화 
# - 정수 단위로 나누어지는 변수
par("mar")
par(mar=c(1,1,1,1))



# 차트 자료 : 2021 ~ 2022년도 분기별 매출액 
chart_data <- c(305,450, 320, 460, 330, 480, 380, 520) 
names(chart_data) <- c("2021 1분기","2022 1분기","2021 2분기","2022 2분기","2021 3분기","2022 3분기","2021 4분기","2022 4분기")
str(chart_data)


# 1) 막대차트 

# [1] 세로막대차트 
help("barplot")

barplot(chart_data, ylim = c(0, 600),
        col = rainbow(8), 
        ylab = '매출액(단위:천원)', 
        xlab = "년도별 분기현황",
        main ="2021년 vs 2022년 분기별 매출현황")

# [2] 가로막대차트 : horiz = TRUE
barplot(chart_data, xlim = c(0, 600),
        horiz = TRUE, 
        col = rainbow(8), 
        ylab = '년도별 분기현황', 
        xlab = "매출액(단위:천원)",
        main ="2021년 vs 2022년 분기별 매출현황")

# [범례] 추가 
barplot(chart_data, ylim = c(0, 600),
        col = rainbow(8), 
        ylab = '매출액(단위:천원)', 
        xlab = "년도별 분기현황",
        main ="2021년 vs 2022년 분기별 매출현황",
        legend.text = names(chart_data),
        args.legend = list(x = 'topleft')) 

# [text] 추가 ★★★★
bp <- barplot(chart_data, ylim = c(0, 600),
              col = rainbow(8), 
              ylab = '매출액(단위:천원)', 
              xlab = "년도별 분기현황",
              main ="2021년 vs 2022년 분기별 매출현황")
# text 반영  
text(x = bp, y = chart_data + 20,
     labels = chart_data, col = "black", cex = 0.7)


# 1행 2열 차트 그리기
par(mfrow=c(1,2)) # 1행 2열 그래프 보기

VADeaths # 시골 vs 도시 출신 사망비율 
str(VADeaths) # num [1:5, 1:4]

# 왼쪽 : 개별막대 (beside형)
barplot(VADeaths, beside=T,col=rainbow(5),
        main="미국 버지니아주 하위계층 사망비율")
legend(19, 71, c("50-54","55-59","60-64","65-69","70-74"), 
       cex=0.8, fill=rainbow(5)) # 범례추가 

# 오른쪽 : 누적형 막대 
barplot(VADeaths, beside=F,col=rainbow(5),
        main="미국 버지니아주 하위계층 사망비율")

# 2) 점 차트 
help("dotchart")
par(mfrow=c(1,1))
dotchart(chart_data, color=c("green","red"), lcolor="black",
         pch=1:2, labels=names(chart_data), xlab="매출액",
         main="분기별 판매현황 점 차트 시각화", cex=1.2)

#pch : plotting characher-번호(1~30)

# 3) 파이 차트  
pie(chart_data, labels = names(chart_data), 
    border = 'blue', col = rainbow(8), cex=1.2)

title("분기별 판매현황", cex.main = 2) # 제목 별도 추가 함수 

###########################################
# 파이 차트 : 중복응답 반영 안됨(비율 제공)
###########################################
genre <- c(45, 25, 15, 30) # 100명 
names(genre) <- c("액션", "스릴러", "공포", "드라마")

pie(genre, labels = names(genre), col = rainbow(4))

# 레이블에 비율 표시  
ratio = round(genre / sum(genre) * 100, 2) # 비율 계산 
labels = names(genre) # 레이블 추출 

# new 레이블 작성 
new_labels = paste(labels,'\n', ratio) 

# 파이차트 : 비율 적용 
pie(genre, labels = new_labels, col = rainbow(4))


##################
###  2. 연속형 변수 시각화 
# - 연속된 값(실수값)을 갖는 변수

# 1) 상자그래프 
VADeaths # 1940년 버지니아의 1000명당 사망률

summary(VADeaths) # 요약통계량 
boxplot(VADeaths) 


# 2) 히스토그램 : 각 계급의 빈도수 
iris # 붗꽃 : R 기본 데이터셋 
str(iris) # 구조보기 
#'data.frame':	150 obs. of  5 variables:
#$ Sepal.Length: 꽃받침 길이 num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
#$ Sepal.Width : 꽃받침 넓이 num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
#$ Petal.Length: 꽃잎 길이 num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
#$ Petal.Width : 꽃잎 넓이 num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
#$ Species     : Factor w/ 3 levels "setosa","versicolor"


# [1] 일반 히스토그램 
hist(iris$Sepal.Length, xlab = '꽃받침 길이', 
     main = '붗꽃 꽃받침 길이')

# [2] 계급수 조정 
hist(iris$Sepal.Length, xlab = '꽃받침 길이',
     breaks = 30,  main = '붗꽃 꽃받침 길이')

# [3] 확률밀도함수(pdf) 
# 단계1 : 밀도 단위 변경 
hist(iris$Sepal.Width, xlab = '꽃받침 넓이',
     breaks = 30, freq = FALSE,
     main = '붗꽃 꽃받침 넓이')

# 단계2 : 확률밀도함수(pdf)  
lines(density(iris$Sepal.Width), col='red')

# [4] 정규분포 곡선
x <- seq(2.0, 4.4, 0.1)
curve(dnorm(x, mean = mean(iris$Sepal.Width), 
            sd = sd(iris$Sepal.Width)), col='blue', add = T)


# 3) 산점도 
# [1] 자료 2개
plot(iris$Petal.Length ~ iris$Sepal.Length) # (y ~ x)


# [2] 자료 1개 
price <- runif(100, min = 1, max = 100) # 1~100 난수 100개
plot(price)  


# [3] 산점도 유형(type)과 포인트(pch) 유형 
par(mfrow=c(2,2)) # 2행 2열 차트 그리기
#  pch : 연결점 문자타입(plotting characher)
plot(price, type="o", pch=5) # 빈 사각형
plot(price, type="o", pch=15)# 채워진 마름모
plot(price, type="o", pch=20, col="blue") #color 지정
plot(price, type="o", pch=20, col="orange", cex=1.5) #character expension(확대)


# [4] plot 2개 하나로 겹치기  
plot(iris$Sepal.Length, type = 'o', ann = FALSE, col='blue')
par(new = T) # 그래프 겹치기 
plot(iris$Petal.Length, type = 'o', axes = FALSE, 
     ann = FALSE, col='red')


# 제목 & 축 이름 추가
title(main = "꽃받침 길이와 꽃잎의 길이 비교")
title(xlab = "색인", col.lab='blue')
title(ylab = "길이", col.lab='red')
# 범례추가 
legend(x=0, y=7, legend = c("꽃받침 길이", "꽃잎의 길이"),
       col = c('blue', 'red'), lty = 1)


# [5] 만능차트 : 자료형에 맞게 차트 제공 
methods(plot)

# 시계열 자료 
WWWusage
plot(WWWusage) # 추세선 제공 



# 4) 중복 자료 시각화  
#install.packages("HistData") # Galton셋 제공 
library("HistData")
library(help="HistData")

str(Galton) # 부모 키와 자녀 키 데이터셋  

par(mfrow=c(1,3)) # 1행 3열 시각화 


# [1] 1개 격자 : 중복값 표시(x) 
plot(Galton$parent, Galton$child) 

# [2] 주파수 편차(jitter) 이용 :  중복값 표시(o) 
plot(jitter(Galton$parent,5), jitter(Galton$child,5))


# [3] 빈도수 가중치 이용 :  중복값 표시(o)   

# (1) 교차표  -> 데이프레임 변환 
tab <- table(Galton$parent, Galton$child)
df <- as.data.frame(tab) # 교차표 -> DF 변환 

# (2) 수치 자료 변환 
parent <- as.numeric(df$Var1)
child <- as.numeric(df$Var2)
freq <- as.numeric(df$Freq)

# (3) 중복 자료 시각화 
plot(parent, child, pch=21, bg="green", cex=0.15*freq)

# 5) 산점도 행렬(scatter matrix) : 변수 비교 
pairs(iris[,1:4])

# 꽃의 종별 산점도 
pairs(iris[iris$Species=="setosa",1:4]) 
pairs(iris[iris$Species=="versicolor",1:4])
pairs(iris[iris$Species=="virginica",1:4])


# 6) 차트 파일 저장 
setwd("C:/ITWILL/5_R_Statistics/output")

jpeg("iris.jpg", width = 720, height = 480) # open
pairs(iris[,1:4]) # 차트 
dev.off() # close

######################
#########################
### 3차원 산점도 
#########################
#install.packages('scatterplot3d')
library(scatterplot3d)

# 꽃의 종류별 dataset 분류  
iris_setosa = iris[iris$Species == 'setosa', ]
iris_versicolor = iris[iris$Species == 'versicolor', ]
iris_virginica = iris[iris$Species == 'virginica', ]

# scatterplot3d(밑변, 오른쪽변, 왼쪽변, type='n') # type='n' : 기본 산점도 제외 
d3 <- scatterplot3d(iris$Petal.Length, iris$Sepal.Length, iris$Sepal.Width, type='n')

d3$points3d(iris_setosa$Petal.Length, iris_setosa$Sepal.Length,
            iris_setosa$Sepal.Width, bg='orange', pch=21)

d3$points3d(iris_versicolor$Petal.Length, iris_versicolor$Sepal.Length,
            iris_versicolor$Sepal.Width, bg='blue', pch=23)

d3$points3d(iris_virginica$Petal.Length, iris_virginica$Sepal.Length,
            iris_virginica$Sepal.Width, bg='green', pch=25)








