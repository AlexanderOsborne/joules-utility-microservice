## Endpoints

- /utilities
  * returns a list of all available utilities

- /bills params required: meter_uid
  * returns a list of a users bills, includes start_date, end_date, kwh, meter_uid, and user_uid

- /new_user params required: email, utility
  * returns a url needed for user to authenticate their utility with our application.

- /get_meters params required: referral
  * returns meters for an authorized user.

