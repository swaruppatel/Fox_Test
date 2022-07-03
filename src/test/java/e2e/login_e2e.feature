@e2e
Feature: Verify login functionality


  Scenario Outline: Verify that user should be able to login with valid credentials

    * def id = function(){ return java.lang.System.currentTimeMillis() + '' }
    * json registerData = read('classpath:requestPayload/register.json')
    * set registerData.email = 'test'+id()+'@fox.com'
    * print "Email being used for register is: "+ registerData.email
    * call read('classpath:unit_test/register.feature'){registerData:#(registerData), expectedStatus:<ExpectedStatus>}
    * def registerEmail = registerResponse.email
    * json loginData = read('classpath:requestPayload/login.json')
    * set loginData.email = registerEmail
    * set loginData.password = registerData.password
    * call read('classpath:unit_test/login.feature'){loginData:#(loginData), expectedStatus:<ExpectedStatus>}
    * match loginResponse == <ExpectedBody>

    Examples:
      | ExpectedStatus | ExpectedBody                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
      | 200            | {"accessToken":"#string","tokenExpiration":"#number","profileId":"#string","encryptedProfileId":"#string","deviceId":"##string","linkedMVPD":"#string","email":"#string","accountType":"#string","userType":"#string","brand":"#string","platform":"#string","isVerified":"#boolean","newsLetter":"#boolean","hasSocialLogin":"#boolean","hasEmail":"#boolean","device":"#string","viewerId":"#string","unlinkedMVPD":"#string","dma":"#string","ipAddress":"#string","userAgent":"#string","gender":"#string","firstName":"#string","lastName":"#string"} |


  Scenario Outline: Verify error message when i/v users tries to login

    * def id = function(){ return java.lang.System.currentTimeMillis() + '' }
    * json registerData = read('classpath:requestPayload/register.json')
    * set registerData.email = 'test'+id()+'@fox.com'
    * print "Email being used for register is: "+ registerData.email
    * call read('classpath:unit_test/register.feature'){registerData:#(registerData), expectedStatus:200}
    * def registerEmail = registerResponse.email
    * json loginData = read('classpath:requestPayload/login.json')
    * set loginData.email = registerEmail
    * set loginData.password = <Password>
    * call read('classpath:unit_test/login.feature'){loginData:#(loginData), expectedStatus:<ExpectedStatus>}
    * match loginResponse == <ExpectedBody>

    Examples:
      | Password  | ExpectedStatus | ExpectedBody                                                                                                                                                                              |
      | 'invalid' | 401            | {"@context":"http://www.w3.org/ns/hydra/context.jsonld","@type":"Error","status":"401","statusCode":401,"errorCode":401,"message":"Invalid LoginId","detail":"Invalid login credentials"} |
    #      | 'invalid' | 401            | {"@context":"#string","@type":"#string","status":"#string","statusCode":"#number","errorCode":"#number","message":"#string","detail":"#string"}                                           |

  Scenario Outline: Verify that error message when request body keys are missing

    * json loginData = read('classpath:requestPayload/login.json')
    * remove loginData.email
    * remove loginData.password
    * call read('classpath:unit_test/login.feature'){loginData:<RequestBody>, expectedStatus:<ExpectedStatus>}
    * match loginResponse == <ExpectedBody>

    Examples:
      | RequestBody  | ExpectedStatus | ExpectedBody                                                                                                                                                                                             |
      | #(loginData) | 401            | {"@context":"http://www.w3.org/ns/hydra/context.jsonld","@type":"Error","status":"401","statusCode":401,"errorCode":401,"message":"Invalid LoginId","detail":"Invalid login credentials"}                |
      |              | 400            | {"@context":"http://www.w3.org/ns/hydra/context.jsonld","@type":"Error","status":"400","statusCode":400,"errorCode":400,"message":"Invalid Parameters.","detail":"Incomplete or Malformed Request Body"} |
    #      | #(loginData) | 401            | {"@context":"#string","@type":"#string","status":"#string","statusCode":"#number","errorCode":"#number","message":"#string","detail":"#string"} |
#      |              | 400            | {"@context":"#string","@type":"#string","status":"#string","statusCode":"#number","errorCode":"#number","message":"#string","detail":"#string"} |