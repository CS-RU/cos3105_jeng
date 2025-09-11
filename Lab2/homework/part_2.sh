#!/bin/bash

# ข้อความแนะนำ
echo "Sending test email with Mailtrap API..."

# ตั้งค่าตามบัญชี Mailtrap ของคุณ
API_TOKEN="83ea3492a96f402ad5920a73ec432ead"
SANDBOX_ID="4009396"

curl --location --request POST "https://sandbox.api.mailtrap.io/api/send/$SANDBOX_ID" \
  --header "Authorization: Bearer $API_TOKEN" \
  --header "Content-Type: application/json" \
  --data-raw '{
    "from": {
      "email": "sender@example.com",
      "name": "Mailtrap Test"
    },
    "to": [
      {
        "email": "receiver@example.com"
      }
    ],
    "subject": "You are awesome!",
    "text": "Congrats for sending test email with Mailtrap!",
    "category": "Integration Test"
  }'
