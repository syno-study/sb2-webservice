#!/bin/bash

REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=springboot2-webservice

cd $REPOSITORY/$PROJECT_NAME/

echo "> Build 파일복사"
cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo ">현재 구동중인 PID 확인 "
CURRENT_PID=$(pgrep -fl springboot2-webservice | grep jar | awk '{print $1}')

echo ">현재구동중인 애플리케이션 pid: $CURRENT_PID"
if [ -z "$CURRENT_PID" ]; then
	echo ">현재구동중인 애플리케이션이 없으므로 종료하지 않습니다."
else
	echo ">kill -15 $CURRENT_PID"
	kill -15 $CURRENT_PID
	sleep 5
fi

echo "> 새 애플리케이션 배포"
JAR_NAME=$(ls -tr $REPOSITORY/ |grep *.jar | tail -n 1)

echo "> JAR NAME: $JAR_NAME"

echo "> $JAR_NAME 에 실행권한 추가"
chmod +x $JAR_NAME

echo "> $JAR_NAME 실행"
nohup java -jar -Dspring.config.location=classpath:/application.yml,/home/ec2-user/app/application-oauth.yml,/home/ec2-user/app/application-real-db.yml -Dspring.profiles.active=real  $REPOSITORY/$JAR_NAME 2>&1 &