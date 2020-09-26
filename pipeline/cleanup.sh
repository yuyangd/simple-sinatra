#!/bin/bash

aws s3 rm s3://${ACCOUNTID}-${STACKNAME} --recursive
aws s3 rb s3://${ACCOUNTID}-${STACKNAME} --force
aws cloudformation delete-stack \
	--stack-name ${STACKNAME}