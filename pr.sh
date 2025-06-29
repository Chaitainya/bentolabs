#!/bin/bash
#Author Chaitanya Geddam
echo "Selected Branch: " $1
echo "Target Branch: " $2
echo "PR Title: " $3
echo "Reviewer Requested: " $4

# To get the UUID of the reviewer use the below command
# curl -u "Chaitu8121:$BITBUCKET_PASS" "url" | grep "Raghu Kunchala"

kishor="81e8158f-5f89-4750-b571-8597e446fb18" #Kishor Kharade 
gopal="2fbcbbe3-6ba2-4c0b-88a6-39a6ca40c0ef" #Gopala Krishna
raghu="7615b986-7335-405e-82c1-d7d4d0336db6" #Raghu Kunchala
adnan="b117bf9b-5dfc-4efa-8a6e-4c58e2fe260d" #Adnan Ali Khan

export BITBUCKET_PASS="ATBB6FEDgBpPGMjZACGasEDCxSp5440E7150"

#reviewer=""
#if [[ "$4" -eq adnan ]]; then
 #  reviewer=$adnan
#elif [[ "$4" -eq kishor ]]; then
 #  reviewer=$kishor
#elif [[ "$4" -eq gopal ]]; then
 #  reviewer=$gopal
#elif [[ "$4" -eq raghu ]]; then
 #  reviewer=$raghu
#else
 #  echo "No reviewer found"
#fi

reviewer=$adnan

result=$(curl -s -o response.json -w "%{http_code}" -X POST -u "Chaitu8121:$BITBUCKET_PASS" \
  -H "Content-Type: application/json" \
  "https://api.bitbucket.org/2.0/repositories/assetmonk-engineering/prop-web-client-admin/pullrequests" \
  -d "{
    \"title\": \"$3\",
    \"source\": { \"branch\": { \"name\": \"$1\" } },
    \"destination\": { \"branch\": { \"name\": \"$2\" } },
    \"description\": \"\",
    \"close_source_branch\": false,
    \"reviewers\": [{ \"uuid\": \"{$reviewer}\" }]
  }")

if [[ "$result" -eq 201 ]]; then
  echo
  echo "Pull request created successfully!"
  echo "Reviewer: $reviewer"
else
  echo "Failed to create pull request. HTTP Status: $result"
  cat response.json  # Show error details
fi
