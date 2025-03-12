module "api_gateway" {
    source = "git@github.com:ucopacme/terraform-aws-apigateway.git"
    name = join("-", [local.tags["ucop:environment"], "quicksight"])
    region = "us-west-2"
    allowed_ips = ["10.48.0.0/15", "128.48.0.0/16"]

    stage_name = "prod"

    api_resources = {
        embed_dashboard = {
            path_part = "quicksight"
            methods = ["GET"]
            gateway_type = "AWS_PROXY" # OPTIONAL, defaults to "AWS"
            lambda_function_arn = module.qs_anonymous_embed_lambda.function_arn
            lambda_function_name = module.qs_anonymous_embed_lambda.function_name
        }
    }
}