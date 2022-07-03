Feature: Unit level feature to login

  Scenario: Scenario to login user

    Given url loginUrl
    And headers {"x-api-key":"DEFAULT", "Postman-Token": "dd063a04-d4fa-4ed4-aa6f-363a887f94e3", "Content-Type":"application/json"}
#    * json requestData = read('classpath:requestPayload/register.json')
    * def requestData = loginData
    * print ">>>>>>>>>>>>. login data>>>>>. "+ requestData
    And request requestData
    When method POST
    * def loginResponse = response
    Then assert responseStatus == expectedStatus