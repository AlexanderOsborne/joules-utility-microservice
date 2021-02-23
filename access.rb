access_token: dd616a877c6d4a05b5a1b467d2a8fd74


curl -X POST \
    -H 'Authorization: Bearer dd616a877c6d4a05b5a1b467d2a8fd74' \
    'https://utilityapi.com/api/v2/forms'

uid: 142959


curl -X POST \
-H 'Authorization: Bearer dd616a877c6d4a05b5a1b467d2a8fd74' \
-d '{"utility": "DEMO", "scenario": "residential"}' \
'https://utilityapi.com/api/v2/forms/142959/test-submit'

referral: 185966

curl -X GET \
    -H 'Authorization: Bearer dd616a877c6d4a05b5a1b467d2a8fd74' \
    'https://utilityapi.com/api/v2/authorizations?referrals=185966&include=meters'


meter uid: 710562

curl -X POST \
    -H 'Authorization: Bearer dd616a877c6d4a05b5a1b467d2a8fd74' \
    -d '{"meters": ["710562"]}' \
    'https://utilityapi.com/api/v2/meters/historical-collection'


success: true


curl -X GET \
    -H 'Authorization: Bearer dd616a877c6d4a05b5a1b467d2a8fd74' \
    'https://utilityapi.com/api/v2/meters/710562'


    curl -X GET \
    -H 'Authorization: Bearer dd616a877c6d4a05b5a1b467d2a8fd74' \
    'https://utilityapi.com/api/v2/bills?meters=710562'
