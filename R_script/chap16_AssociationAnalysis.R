# chap16_AssociationAnalysis

###################################################
# 1. 연관분석(Association Analysis) 기본 용어 
###################################################

# 특징
# - 데이터베이스에서 사건의 연관규칙을 찾는 무방향성 데이터마이닝 기법                                            
# - 무방향성(x -> y변수 없음) -> 비지도 학습에 의한 패턴 분석 방법
# - 사건과 사건 간 연관성(관계)를 찾는 방법(예:기저귀와 맥주)
# - A와 B 제품 동시 구매 패턴(지지도)
# - A 제품 구매 시 B 제품 구매 패턴(신뢰도)


# 예) 장바구니 분석 : 장바구니 정보를 트랜잭션(상품 거래 정보)이라고 하며,
# 트랜잭션 내의 연관성을 살펴보는 분석기법
# 분석절차 : 거래내역 -> 품목 관찰 -> 상품 연관성에 대한 규칙(Rule) 발견

# 활용분야
# - 대형 마트, 백화점, 쇼핑몰 등에서 고객의 장바구니에 들어있는 품목 간의 
#   관계를 탐구하는 용도
# ex) 고객들은 어떤 상품들을 동시에 구매하는가?
#   - 맥주를 구매한 고객은 주로 어떤 상품을 함께 구매하는가?


#########################################
# 1. 연관규칙 평가 척도
#########################################

# 연관규칙의 평가 척도
# 1. 지지도(support) : 전체자료에서 A를 구매하고 B를 구매하는 거래 비율 
#  A->B 지지도 식 
#  -> A와 B를 포함한 거래수 / 전체 거래수
#  -> n(A, B) : 두 항목(A,B)이 동시에 포함되는 거래수
#  -> n : 전체 거래 수

# 2. 신뢰도(confidence) : A가 포함된 거래 중에서 B를 포함한 거래의 비율(조건부 확률)
# A->B 신뢰도 식
#  -> A와 B를 포함한 거래수 / A를 포함한 거래수

# 3. 향상도(Lift) : 하위 항목들이 독립에서 얼마나 벗어나는지의 정도를 측정한 값
# 향상도 식
#  -> 신뢰도 / B가 포함될 거래율


# <트랜잭션 예 : 장바구니 6개>
# t1 : 라면,맥주,우유
# t2 : 라면,고기,우유
# t3 : 라면,과일,고기
# t4 : 고기,맥주,우유
# t5 : 라면,고기,우유
# t6 : 과일,우유

# 규칙(rule) 표현
# LHS     =>   RHS  
# {}      => {상품}   : 전체 거래에서 '상품'이 포함되는 거래
# {A상품} => {B상품}  : A상품이 포함된 거래에서 B상품이 포함된 거래  
# {A상품, 상품} => {B상품}  : A상품 집합이 포함된 거래에서 B상품이 포함된 거래  

# 규칙(rule) 예
#  LHS -> RHS                 지지도      신뢰도     향상도 
#  {}     -> {우유}         5/6=0.833    5/6=0.833   0.833/0.833(5/6)=1.000 
#  {맥주} -> {고기}         1/6=0.166    1/2=0.5     0.5/0.66(4/6)=0.75          
#  {라면,우유} -> {맥주}  

# 연관규칙 평가 : 지지도와 향상도 이용 
# 지지도 : 두 항목(item)의 조합으로 나올 수 있는 거래 비율(방향 없음)   
# 향상도 : 두 항목(item)의 연관성을 나타내는 비율(방향 있음) 
# 예) 우유와 빵의 향상도 = 3
#   -> 전체 고객이 빵을 구매할 확률보다, 우유를 구매한 사람들이 빵을 구매할 확률이 3배 높다.


###################################################
# 2. 연관분석 수행 절차 
###################################################

# 단계1. 연관성 규칙을 위한 패키지 설치 
#install.packages("arules") # association Rule 제공 
library(arules) 
# read.transactions(), apriori(), inspect() 제공 
# Adult/Groceries 데이터셋 제공

# 단계2. transaction 객체 생성(파일 이용)
setwd("C:/ITWILL/5_R_Statistics/data")
tran<- read.transactions("tran.txt", format="basket", sep=",")
tran

# transaction 데이터 보기
inspect(tran)

# 단계3. 연관규칙(rule) 생성 
# apriori(data, parameter=list(supp=0.1, conf=0.8, maxlen=10))
help("apriori") # support 0.1, confidence 0.8, and maxlen 10 

base_rule <- apriori(tran) # 기본 연관규칙 

# 연관성 규칙 평가 척도 이용 : 지지도와 신뢰도 적용 
rule1 <- apriori(tran, parameter = list(supp=0.3, conf=0.1)) # 16 rule
rule2 <- apriori(tran, parameter = list(supp=0.1, conf=0.1)) # 35 rule 
inspect(rule) # 규칙 보기
inspect(rule2) # 규칙 보기


# 단계4. 연관규칙 시각화   
#install.packages('arulesViz')
library(arulesViz)

plot(rule1, method = 'graph') # rule1 시각화 
plot(rule1, method = 'graph') # rule2 시각화 
# 각 연관규칙 별로 연관성 있는 항목(item) 끼리 묶여서 네트워크 형태로 시각화


# 단계5. 연관상품 해석 : 중심 상품 기준    
na <- subset(rule2, rhs %in% '라면') # 특정 상품으로 서브셋 만들기 

plot(na, method = 'graph') # 특정 상품과 관련된 상품 확인  

######################################
# 3. 식료품점(Groceries) 데이터셋 적용  
######################################
library(arules)

# 단계1. transactions 데이터 로드 & 탐색 
data("Groceries")  # 식료품점 데이터 메모리 로딩

Groceries  # 거래(트랜잭션)과 항목(상품)
# 실제 식료품점에서 1개월 동안 판매된 거래 데이터로 9835 트랜잭션과 169개 상품으로 구성

# transactions 데이터 탐색 
summary(Groceries) # 주요 항목(item)과 거래(transaction) 정보 확인 

itemFrequencyPlot(Groceries, topN=10) # 빈도수 높은 항목(item) 10개

# 단계2. 연관규칙(rule) 생성  
rules410 <- apriori(Groceries, parameter=list(supp=0.001, conf=0.8))
inspect(rules410)  # 410개 규칙 확인 


# 단계3. 연관규칙(rule) 시각화
library(arulesViz) # rules값 대상 그래프를 그리는 패키지

# 연관규칙 시각화 : LHS와 RHS 간의 연관규칙 행렬 그래프
plot(rules410, method="grouped") 

# 항목(상품) 최대 길이 3이내로 규칙 생성
rules29 <- apriori(Groceries, parameter=list(supp=0.001, conf=0.80, maxlen=3))
inspect(rules29) # 29개 규칙

# 향상도(lift) 기준 내림차순으로 규칙 정렬
rules29 <- sort(rules29, decreasing=T, by="lift") 
inspect(rules29) 

# 연관규칙 시각화 : LHS와 RHS 간의 연관규칙 네트워크 그래프
plot(rules29, method="graph")

# 단계4. 연관상품 해석 :  중심 상품 기준 

# (1) 전지우유(whole milk) 기준 subset  
wmilk <- subset(rules29, rhs %in% 'whole milk')
plot(wmilk, method="graph")

# 2. 기타 야채(other vegetables) 기준 subset
oveg <- subset(rules29, rhs %in% 'other vegetables')
plot(oveg, method="graph")
################################
# 4. Adult 데이터셋 적용
################################

# 단계1. transactions 데이터 로드 & 탐색 
data(Adult) # arules에서 제공되는 내장 데이터 로딩

Adult# 트랜잭션의 변수와 범주 보기
#transactions in sparse format with
#48842 transactions (rows) and
#115 items (columns)
################ Adult 데이터 셋 #################
# 32,000개의 관찰치와 15개의 변수로 구성되어 있음
# 종속변수에 의해서 년간 개인 수입이 5만달러 이상 인지를
# 예측하는 데이터 셋으로 transactions 데이터로 읽어온
# 경우 48,842행과 115 항목으로 구성된다.
##################################################
# 15개 변수 목록 :
# y변수 : > 50K, <= 50K.
# 나이 : 연속.
# 직업유형(workclass) : 개인, Self-emp-not-inc, Self-emp-inc, Federal-gov, Local-gov, State-gov, 무급, 무근로.
# fnlwgt : 교육수준(연속)
# 교육 : 학사, Some-college, 11th, HS-grad, Prof-school, Assoc-acdm, Assoc-voc, 9th, 7th-8th, 12th, Masters, 1st-4th, 10th, Doctorate, 5th-6th, Preschool.
# 교육수 : 연속.
# 결혼상태 : 기혼 -civ- 배우자, 이혼, 미혼, 별거, 사별, 기혼-배우자 부재, 기혼 -AF- 배우자.
# 직업 : 기술 지원, 공예 수리, 기타 서비스, 판매, 경영진, 전문직, 핸들러 청소부, 기계 작업 검사, 임시 사무원, 농업 낚시, 운송 이동, 개인 주택- serv, 보호 -serv, Armed-Forces.
# 관계 : 아내, 자녀, 남편, 비 가족, 기타 친척, 미혼.
# 인종(race) : 백인, 아시아-태평양-섬, 아메리카-인도-에스키모, 기타, 흑인.
# 성별 : 여성, 남성.
# 자본이득(capital-gain) : 연속.
# 자본손실(capital-loss) : 연속.
# 주당시간(hours-per-week) : 연속.
# 출신국가(native-country) : 미국, 캄보디아, 영국, 푸에르토 리코, 캐나다, 독일 등 


# 주요 항목(item)과 거래 정보 
summary(Adult)

# 단계2. 연관규칙(rule) 생성
ar1 <- apriori(Adult, parameter = list(supp=0.1, conf=0.8))
ar2 <- apriori(Adult, parameter = list(supp=0.2)) # 지도도 높임
ar3 <- apriori(Adult, parameter = list(supp=0.2, conf=0.95)) # 신뢰도 높임
ar4 <- apriori(Adult, parameter = list(supp=0.3, conf=0.95)) # 신뢰도 높임
ar5 <- apriori(Adult, parameter = list(supp=0.35, conf=0.95)) # 신뢰도 높임
ar6 <- apriori(Adult, parameter = list(supp=0.4, conf=0.95)) # 신뢰도 높임


# 연관규칙 결과보기
inspect(head(ar6)) # 상위 6개 규칙 제공 -> inspect() 적용

# confidence(신뢰도) 기준 내림차순 정렬 상위 6개 출력
inspect(head(sort(ar6, decreasing=T)), by="confidence")

# lift(향상도) 기준 내림차순 정렬 상위 6개 출력
inspect(head(sort(ar6, decreasing=T)), by="lift") 

# 단계3. 연관규칙(rule) 시각화
plot(ar4, method="graph") # ar4 연관규칙 네트워크 그래프
plot(ar5, method="graph") # ar5 연관규칙 네트워크 그래프


# 단계4. 연관상품 해석 :  중심 상품 기준 
# (1) 'income=small' 기준 
income <- subset(ar5, lhs %in% 'income=small')
inspect(income)
plot(income, method='graph')

# (2) 'capital-loss=None' 기준 
capital_loss <- subset(ar5, rhs %in% 'capital-loss=None')
inspect(capital_loss)
plot(capital_loss, method="graph")

