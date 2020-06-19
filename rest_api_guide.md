# RESTful APIs overview

Thryft is built on a micro-services architecture. Each microservice will have a specific set of response codes and 
inputs/outputs. In order for the different microservices to communicate with each other, we will need to follow a certain
standard for the response codes.

### Response codes reference

Whenever we want to implement a response code, find the correct code to use from the following page: 
https://developer.mozilla.org/en-US/docs/Web/HTTP/Status

Also note that since we are working with shopify's API very often, we may run into some of their response codes: https://shopify.dev/concepts/about-apis/response-codes

### Response codes currently in use

These are the response codes that Thryft are currently using. To be updated with each new response code that we are using.

- **200**: operation successful
- **400**: invalid parameters in request
- **500**: server side error (please submit issue)


### RESTful API naming conventions 

As far as possible, we will follow the naming conventions laid out here: 

https://restfulapi.net/resource-naming/

If you see any routes that are not following these conventions, submit an issue.