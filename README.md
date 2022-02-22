# SDA-SE

DevOps Coding Challenge

This module Create a AWS Lambda function using Terraform and Python.

Make a python code first. We'll do this by creating a lambda function.py file in the same directory. To deploy to AWS Lambda, an archive file will be created from "lambda function.py."

Following that, you must build IAM roles and policies. This will determine what your function may access and do within your AWS account.
Create the "aws lambda function" resource after that.

The python script will be run on a regular basis using Event Bridge and cloudwatch events in this activity.

To accomplish this, build a "aws cloudwatch event rule" that will be applied to the event target. Then, using the rule you set earlier, construct a "aws cloudwatch event target" to run the function. Now we can provide "lambda-function-target" permission to use this code to launch an AWS lambda function.
