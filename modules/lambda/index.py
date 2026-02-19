import json
import os
import boto3

s3_client = boto3.client('s3')
bucket_name = os.environ.get('S3_BUCKET')
environment = os.environ.get('ENVIRONMENT', 'unknown')

def handler(event, context):
    """
    Lambda function handler
    Processes API Gateway requests and interacts with S3
    """
    
    # Get HTTP method and path
    http_method = event.get('httpMethod', 'GET')
    path = event.get('path', '/')
    
    # Simple routing
    if path == '/health':
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps({
                'status': 'healthy',
                'environment': environment,
                'service': 'lambda'
            })
        }
    
    elif path == '/info':
        # Get info about S3 bucket
        try:
            response = s3_client.list_objects_v2(Bucket=bucket_name, MaxKeys=1)
            object_count = response.get('KeyCount', 0)
        except Exception as e:
            object_count = 0
        
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps({
                'environment': environment,
                's3_bucket': bucket_name,
                'objects_in_bucket': object_count,
                'message': 'Lambda function is working!'
            })
        }
    
    elif path == '/' or path == '':
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps({
                'message': f'Hello from {environment} environment!',
                'environment': environment,
                'endpoints': {
                    '/health': 'Health check endpoint',
                    '/info': 'Get environment and S3 info'
                }
            })
        }
    
    else:
        return {
            'statusCode': 404,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps({
                'error': 'Not Found',
                'path': path
            })
        }
