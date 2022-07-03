Feature: Unit level feature to register user

  Scenario: Scenario to register user

    Given url registerUrl
    And headers {"x-api-key":"DEFAULT", "Postman-Token": "a74249b3-97f1-45c0-999c-66d7841bed8a", "Content-Type":"application/json"}
#    * json requestData = read('classpath:requestPayload/register.json')
    * def requestData = registerData
    And request requestData
    When method Post
    * def registerResponse = response
    Then assert responseStatus == expectedStatus



    