# fyber-api
A client application for testing Fyber offer Api

The app is built using rails using only the MVC structure and ActiveSupport tests.
I built 3 classes with tests to handle the Fyber request and ensure that the requests/responses are not tampered.
The controllers only use the OfferRequest and OfferResponse class to generate the request and response from params.
The view after the request is processed is updated async.

# Running Instructions

1- `bundle`

2- `rails s`

# Running tests

1- `rake test`
