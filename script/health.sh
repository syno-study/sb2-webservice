#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSPATH}/profile.sh
source ${ABSDIR}/switch.sh

IDEL_PORT=$(find_idle_port)

echo "> health check start"
echo "> IDEL_PORT: $IDEL_PORT"
echo "> curl -s http://localhost:$IDEL_PORT/profile"
sleep 10

for RETRY_COUNT in {1..10}
do
  RESPONSE=$(curl -s http://localhost:${IDLE_PORT}/profile)
  UP_COUNT=$(echo ${RESPONSE} | grep 'real' | wc -l)

  if [ ${UP_COUNT} -ge 1 ];
  then
      echo "> health check success"
      switch_proxy
      break
  else
      echo "> health check의 응답을 알수없거나 실행상태가 아닙니다."

  fi

  if [ ${RETRY_COUNT} -eq 10 ];
  then
    echo "> health check fail"
    exit 1
  fi
    echo "> healath check 연결 실패. 재시도..."
    sleep 10
  done