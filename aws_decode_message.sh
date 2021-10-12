PROFILE=$1
MESSAGE=$2

aws --profile $PROFILE sts decode-authorization-message --encoded-message $MESSAGE --query DecodedMessage --output text | jq '.'
