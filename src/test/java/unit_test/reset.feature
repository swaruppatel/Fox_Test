Feature: Unit level feature to perform reset credential

  Scenario: Scenario to reset credentials

    Given url resetUrl
    And headers {"x-api-key":#(apiKey), "Postman-Token": "dd063a04-d4fa-4ed4-aa6f-363a887f94e3", "Content-Type":"application/json"}
#    * json requestData = read('classpath:requestPayload/register.json')
    * def requestData = resetData
    And request requestData
    When method POST
    * def resetResponse = response
    Then assert responseStatus == expectedStatus

