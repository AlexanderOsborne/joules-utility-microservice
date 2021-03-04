# joules-utility-microservice

### About this App

Joules utility microservice consumes utilityAPI to provide realtime electricity stats for Run The Jules users.  Where a user can sign up and compare their electricity usage with their friends or to an anynomous average in their area!

This project is deployed on:

- [Heroku here](https://joules-microservice.herokuapp.com/)

## Versions

- Ruby 2.5.3

- Rails 5.2.4.3

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]


<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
      </ul>
       <ul>
        <li><a href="#endpoints">Endpoints</a></li>
      </ul>
    </li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Application

This application provides API endpoints for our Jules-API to consume, and fetches data from utilityAPI.

### Built With

* [Ruby](https://www.ruby-lang.org/en/)
* [Sinatra](http://sinatrarb.com/)
* [RSpec](https://github.com/rspec/rspec-rails)
* [UtilityAPI](https://utilityapi.com/)

<!-- GETTING STARTED -->
## Getting Started

### Installation

1. Fork and Clone the repo
   ```
   git clone https://github.com/run-the-jules/joules-utility-microservice.git
   ```
2. Install gems
     -- For list of Gems see [here](https://github.com/run-the-jules/joules-utility-microservice/blob/main/Gemfile)
   ```
   bundle install
   ```
3. Get your API key, you can request a demo [here](https://utilityapi.com/products#api)

4. Set API key with 
   ```
   export UTILITY_API_KEY='Your Key Here'
   ```

<!-- Endpoints -->
 ### Endpoints

A Postman collection can be imported [here](https://www.postman.com/collections/20d5baf623e611679c92) to test endpoints directly from the UtliityAPI.
 
1. Utilities
   ```
   get "/api/v1/utilities"
   ```
   
   This will return a list of all currently supported utilities in the following format
   ```
   ["{\"data\":[{\"id\":\"ACE\",\"utility_name\":\"Atlantic City Electric\"},   {\"id\":\"AEPOHIO\",\"utility_name\":\"American Electric Power Ohio\"},{\"id\":\"APS\",\"utility_name\":\"Arizona Public Service Company\"},{\"id\":\"AustinEnergy\"}"]
   ```
   
2. New User
   ```
   get "/api/v1/new_user"
   ```
   
   This request must include an email and utility param. It will verify a user and return a referral code that allows meters activation.
   ```
    {\"data\":{\"authorization_uid\":null,\"created\":\"2021-02-    27T19:19:55.504653+00:00\",\"customer_email\":\"\",\"disabled\":false,\"is_archived\":false,\"scope\":{},\"template_uid\":\"33ae3462\",\"uid\":\"222222\",\"updated\":\"2021-02-27T19:19:55.514430+00:00\",\"url\":\"https://utilityapi.com/authorize/customername?f=11014777-7efa-4aea-afac-96d032600cec\",\"user_email\":\"user@turing.io\",\"user_uid\":\"12121\",\"utility\":\"ACE\"}}"
   
3. Meters
   ```
   get "/api/v1/get_meters"
   ```

   This request must include a referral param. It will return a meter_uid allowing bill retrieval.

   ```
   "{\"data\":[{\"meter_uid\":\"711267\"}]}"
   ```
    
4. Bills
    ```
    get "/api/v1/bills"
    ```
   
   This request must include a meter_uid param. This param allows bill retrieval in the following format.
  
    ```
     "{\"data\":[{\"start_date\":\"2020-12-31T16:00:00.000000-08:00\",\"end_date\":\"2021-01-31T16:00:00.000000-08:00\",\"kwh\":743.0,\"meter_uid\":\"711267\",\"user_uid\":185072}}]}"
    ```

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

- Alexander Osborne - [Github](https://github.com/AlexanderOsborne) [LinkedIn](https://www.linkedin.com/in/alex-osborne/)
- Aiden Mendez - [Github](https://github.com/aidenmendez) [LinkedIn](https://www.linkedin.com/in/aiden-mendez/)
- Catherine Dean - [Github](https://github.com/catherinemdean15) [LinkedIn](https://www.linkedin.com/in/catherine-dean-57a92030/)
- James Fox-Collis - [Github](https://github.com/jlfoxcollis) [LinkedIn](https://www.linkedin.com/in/james-fox-collis/)
- Robert Heath - [Github](https://github.com/kaiheiongaku) [LinkedIn](https://www.linkedin.com/in/robert-heath-305bb34b/)
- Joe Jiang - [Github](https://github.com/ninesky00) [LinkedIn](https://www.linkedin.com/in/joe-jiang01/)


Project Link: [https://github.com/run-the-jules/joules-utility-microservice](https://github.com/run-the-jules/joules-utility-microservice)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [Img Shields](https://shields.io)
* [MIT Open Source License](https://opensource.org/licenses/MIT)
* [GitHub Pages](https://pages.github.com)






<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/run-the-jules/joules-utility-microservice.svg?style=for-the-badge
[contributors-url]: https://github.com/run-the-jules/joules-utility-microservice/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/run-the-jules/joules-utility-microservice.svg?style=for-the-badge
[forks-url]: https://github.com/run-the-jules/joules-utility-microservice/network/members
[stars-shield]: https://img.shields.io/github/stars/run-the-jules/joules-utility-microservice.svg?style=for-the-badge
[stars-url]: https://github.com/run-the-jules/joules-utility-microservice/stargazers
[issues-shield]: https://img.shields.io/github/issues/run-the-jules/joules-utility-microservice.svg?style=for-the-badge
[issues-url]: https://github.com/run-the-jules/joules-utility-microservice/issues
[product-screenshot]: images/screenshot.png
