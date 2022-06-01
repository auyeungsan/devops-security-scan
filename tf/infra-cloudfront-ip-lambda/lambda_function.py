import json

def lambda_handler(event, context):
    # TODO implement
    # maintenance = event["queryStringParameters"]['maintenance']
    # print(maintenance)
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }