@e2e
Feature: Verify register user

  Scenario Outline: Verify that user should be able to register with valid data

    * def id = function(){ return java.lang.System.currentTimeMillis() + '' }
    * json requestData = read('classpath:requestPayload/register.json')
    * set requestData.email = 'test'+id()+'@fox.com'
    * set requestData.gender = '<Gender>'
    * print "Email being used for register is: "+ requestData.email
    * call read('classpath:unit_test/register.feature'){registerData:#(requestData), expectedStatus:<ExpectedStatus>}
    * match registerResponse == <ExpectedBody>

    Examples:
      | Gender | ExpectedStatus | ExpectedBody                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
      | M      | 200            | {"accessToken":"#string","tokenExpiration":"#number","profileId":"#string","deviceId":"##string","email":"#string","accountType":"#string","userType":"#string","encryptedProfileId":"#string","brand":"#string","platform":"#string","isVerified":"#boolean","newsLetter":"#boolean","hasSocialLogin":"#boolean","hasEmail":"#boolean","device":"#string","viewerId":"#string","unlinkedMVPD":"#string","dma":"#string","ipAddress":"#string","userAgent":"#string","gender":"#string","firstName":"#string","lastName":"#string"} |
      | F      | 200            | {"accessToken":"#string","tokenExpiration":"#number","profileId":"#string","deviceId":"##string","email":"#string","accountType":"#string","userType":"#string","encryptedProfileId":"#string","brand":"#string","platform":"#string","isVerified":"#boolean","newsLetter":"#boolean","hasSocialLogin":"#boolean","hasEmail":"#boolean","device":"#string","viewerId":"#string","unlinkedMVPD":"#string","dma":"#string","ipAddress":"#string","userAgent":"#string","gender":"#string","firstName":"#string","lastName":"#string"} |


  Scenario Outline: Verify error message when trying to register with insufficient data

    * def id = function(){ return java.lang.System.currentTimeMillis() + '' }
    * json requestData = read('classpath:requestPayload/register.json')
    * set requestData.email = 'test'+id()+'@fox.com'
    * remove requestData.password
    * set requestData.gender = '<Gender>'
    * print "Email being used for register is: "+ requestData.email
    * call read('classpath:unit_test/register.feature'){registerData:#(requestData), expectedStatus:<ExpectedStatus>}
    * match registerResponse == <ExpectedBody>

    Examples:
      | Gender | ExpectedStatus | ExpectedBody                                                                                                                                                                             |
      | M      | 400            | {"@context":"http://www.w3.org/ns/hydra/context.jsonld","@type":"Error","status":"400","statusCode":400,"errorCode":400,"message":"Invalid Parameters.","detail":"password is required"} |
      | F      | 400            | {"@context":"http://www.w3.org/ns/hydra/context.jsonld","@type":"Error","status":"400","statusCode":400,"errorCode":400,"message":"Invalid Parameters.","detail":"password is required"} |

  Scenario Outline: Verify error message for i/v scenarios

    * def id = function(){ return java.lang.System.currentTimeMillis() + '' }
    * json requestData = read('classpath:requestPayload/register.json')
    * set requestData.email = 'test'+id()+'@fox.com'
    * print "Email being used for register is: "+ requestData.email
    * call read('classpath:unit_test/register.feature'){registerData:<RequestBody>, expectedStatus:<ExpectedStatus>}
    * match registerResponse == <ExpectedBody>

    Examples:
      | ExpectedStatus | RequestBody                                                                                      | ExpectedBody                                                                                                                                                                                                                                          |
#  existing user
      | 409            | {"email":"test23wr@fox.com","password":"fox123","gender":"M","firstName":"QA","lastName":"Test"} | {"@context":"http://www.w3.org/ns/hydra/context.jsonld","@type":"Error","status":"409","statusCode":409,"errorCode":409,"message":"Email is already registered","detail":"Invalid argument: Email is already registered"}                             |

#  i/v data in gender
      | 400            | {"email":"test23wr@fox.com","password":"fox123","gender":10,"firstName":"QA","lastName":"Test"}  | {"@context":"http://www.w3.org/ns/hydra/context.jsonld","@type":"Error","status":"400","statusCode":400,"errorCode":400,"message":"Invalid Parameters.","detail":"json: cannot unmarshal number into Go struct field Register.gender of type string"} |

  Scenario Outline: Verify error message for i/v scenarios 2

    * def id = function(){ return java.lang.System.currentTimeMillis() + '' }
    * json requestData = read('classpath:requestPayload/register.json')
    * set requestData.email = 'test'+id()+'@fox.com'
    * set requestData.password = '12345'
    * print "Email being used for register is: "+ requestData.email
    * call read('classpath:unit_test/register.feature'){registerData:#(requestData), expectedStatus:<ExpectedStatus>}
    * match registerResponse == <ExpectedBody>

    Examples:
      | ExpectedStatus | ExpectedBody                                                                                                                                                                                                                         |
      | 400            | {"@context":"http://www.w3.org/ns/hydra/context.jsonld","@type":"Error","status":"400","statusCode":400,"errorCode":400,"message":"Invalid Parameters.","detail":"Invalid argument: Invalid password. Need minimum of 6 characters"} |