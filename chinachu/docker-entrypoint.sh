#!/bin/bash

# this script is useful for kubernetes
# creating symlinks from /chinachu (persistent) to /usr/local/chinachu/

EXE_DIR=/usr/local/chinachu
VOL_BASE_DIR=/chinachu
VOL_CONFIG_DIR=${VOL_BASE_DIR}/conf

VOL_CONFIG_JSON=${VOL_CONFIG_DIR}/config.json
VOL_RULES_JSON=${VOL_CONFIG_DIR}/rules.json

VOL_DATA_DIR=${VOL_BASE_DIR}/data
VOL_LOG_DIR=${VOL_BASE_DIR}/log

# recorded directory can be set in config.json
#VOL_REC_DIR=${VOL_BASE_DIR}/recorded

if [ -f ${VOL_CONFIG_JSON} ]; then
  ln -sf ${VOL_CONFIG_JSON} ${EXE_DIR}/config.json;
else
  echo "${VOL_CONFIG_JSON} NOT FOUND. continue"
fi

if [ -f $VOL_RULES_JSON ]; then
  ln -sf ${VOL_RULES_JSON} ${EXE_DIR}/rules.json;
else
  echo "${VOL_RULES_JSON} NOT FOUND. continue"
fi

if [ -e $VOL_DATA_DIR ]; then
  rm -rf ${EXE_DIR}/data
  ln -sf ${VOL_DATA_DIR}/ ${EXE_DIR}/data
else
  echo "${VOL_DATA_DIR} NOT FOUND. continue"
fi

if [ -e $VOL_LOG_DIR ]; then
  rm -rf ${EXE_DIR}/log
  ln -sf ${VOL_LOG_DIR}/ ${EXE_DIR}/log
else
  echo "${VOL_LOG_DIR} NOT FOUND. continue"
fi
