data "aws_region" "current" {}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "function.zip"
}

resource "aws_iam_role" "lambda_role" {
  name               = var.lambda_role_name
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_lambda_function" "lambda_function" {
  function_name    = var.lambda_function_name
  filename         = "function.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  runtime          = "python3.6"
  handler          = "lambda_function.lambda_handler"
  timeout          = var.timeout
}

resource "aws_cloudwatch_event_rule" "lambda_event_rule" {
  name                = var.event_rule_name
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "lambda-function-target" {
  target_id = var.event_target_id
  rule      = aws_cloudwatch_event_rule.lambda_event_rule.name
  arn       = aws_lambda_function.lambda_function.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_event_rule.arn
}
