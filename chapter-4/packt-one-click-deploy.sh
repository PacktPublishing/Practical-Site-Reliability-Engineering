!/bin/bash
###########################################################
#Name: packt-one-click-deploy.sh
#Author: Shailender singh
#Purpose: Read Jenkins variable values and pass it to further scripts for deployment
#version:
#Team: Site Reliablity Engineering
######################################
APPLICATION_REGION="$Region" 
APPLICATION_VERSION="$Version" 
ENVIRONMENT="$Environment" 

packer build -var "application_region=$APPLICATION_REGION" -var "application_version=$APPLICATION_VERSION"  -var "environment=$ENVIRONMENT" packer-ec2-build-template.json