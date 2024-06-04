# chap08_DB_conn

########################################
## 정형데이터 처리(Oracle 자료처리) 
########################################

# 1. JDK설치 : RJDBC 패키지를 사용하기 위해서는 java 설치
# 최신버전 java 다운로드 : jdk-19_windows-x64_bin

# Oracle 연동 : Java 11 버전 이상 설치함
# Oracle21c 다운로드 https://www.oracle.com/java/technologies/downloads/


# 2. 패키지 설치
install.packages("rJava")  
install.packages("DBI")
install.packages("RJDBC")


# 3. 패키지 로딩
library(rJava) # R + Java 
library(DBI) # dbConnect 제공 

# JDK 설치 경로 
Sys.setenv(JAVA_HOME='C:/Program Files/Java/jdk-19') 
library(RJDBC) # JDBC 제공 : rJava에 의존적

# 4. Oracle 연동   
######################## Oracle 21c ###################################
# 단계1: driver 객체 
drv <- JDBC(driverClass="oracle.jdbc.driver.OracleDriver", 
            classPath="C:/app/itwill/product/21c/dbhomeXE/jdbc/lib/ojdbc8.jar")

# 단계2:  db연동(driver, url, user, password) 
conn <- dbConnect(drv=drv, 
                  url="jdbc:oracle:thin:@//127.0.0.1:1521/xe",
                  user="c##scott", 
                  password="tiger") # 오라클 계정과 비번 확인  
#####################################################################


# 5. db 테이블 조회 및 수정 

# 1) 전체 테이블 조회
query <- "select * from tab"
dbGetQuery(conn, query)  # db연결

# 2) 특정 테이블 조회 
dbGetQuery(conn, "select * from emp")

# 3) table 생성  
query <- "create table db_test(sid int, pwd char(4), 
           name varchar(25), age int)"
dbSendUpdate(conn, query) # table 생성   


# 4) DML명령어 : dbSendUpdate(conn, query)

# [1] insert문 
query <- "insert into DB_TEST values(1001, '1234', '홍길동', 35)"


# [2] update문 
query <- "update DB_TEST set name='김길동' where sid=1001"


# [3] delete문 
query <- "delete from DB_TEST where sid=1001"


# [4] table 삭제 
dbSendUpdate(conn, "drop table DB_TEST purge")



# 6. 테이블(table) 자료 처리

# 1) 테이블 가져오기
query <- "select * from emp"
emp <- dbGetQuery(conn, query) 

# 2) 숫자형 변환 
emp$SAL <- as.numeric(emp$SAL)
emp$COMM <- as.numeric(emp$COMM)
emp$DEPTNO <- as.numeric(emp$DEPTNO)

# 3) 통계함수  
mean(emp$SAL) # 2073.214
mean(emp$COMM, na.rm = T) # 550

# 4) 막대차트 시각화 : 전체 사원의 급여 정보  
barplot(emp$SAL, col = rainbow(length(emp$SAL)),
        main = '전체 사원의 급여 정보',
        names.arg = emp$ENAME)


# 5) 조건식으로 조회
query <- "select * from emp where sal >= 2500 and job ='MANAGER'"
manager_2500 <- dbGetQuery(conn, query)

# 6) 서브쿼리(subquery) 
query <- "select ename, sal, job from EMP where DEPTNO =
               (select DEPTNO from DEPT where DNAME='SALES')"
sales <- dbGetQuery(conn, query)

# 7) 테이블 조인(Table join)
query <- "select e.ename, e.job, d.*
          from EMP e, DEPT d
          where e.deptno = d.deptno and e.ename like '%M%'"
join_df <- dbGetQuery(conn, query)

# 8) group by & 집계함수 
query <- "select deptno, avg(sal) avg_sal, sum(sal) sum_sal  
          from emp
          group by deptno
          order by deptno"
result <- dbGetQuery(conn, query)


# 7. 테이블 저장 

1) R dataset -> table 저장
library(datasets)
str(mtcars)
dbWriteTable(conn, "mtcars", mtcars) # 테이블 저장

# 2)  file -> table save 
data <- read.csv(file.choose()) # data.csv 가져오기 

# [1] 날짜 자료 만들기 
library(stringr)

Date <- data$Date
year <- str_sub(Date, 1, 4)
month <- str_sub(Date, 5, 6)
day <- str_sub(Date, 7, 8)

# [2] 날짜 객체 생성 
sDate <- str_c(year,month,day, sep='-')
cDate <- as.Date(sDate, '%Y-%m-%d')
data$Date <- cDate
names(data) <- c('buy_date', 'user_id', 'buy')

# [3] table save
dbWriteTable(conn, 'product_tab', data) 


# db연결 종료 
dbDisconnect(conn) # TRUE
# db연결 종료 
dbDisconnect(conn) # TRUE

