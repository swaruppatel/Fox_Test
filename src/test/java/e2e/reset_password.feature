@e2e
Feature: Verify register user

  Scenario Outline: Verify that valid users should be able to reset credentials

    * def id = function(){ return java.lang.System.currentTimeMillis() + '' }
    * json registerData = read('classpath:requestPayload/register.json')
    * set registerData.email = 'test'+id()+'@fox.com'
    * print "Email being used for register is: "+ registerData.email
    * call read('classpath:unit_test/register.feature'){registerData:#(registerData), expectedStatus:<ExpectedStatus>}
    * def registerEmail = registerResponse.email
    * json resetData = read('classpath:requestPayload/reset.json')
    * set resetData.email = registerEmail
    * call read('classpath:unit_test/reset.feature'){apiKey:"6E9S4bmcoNnZwVLOHywOv8PJEdu76cM9", resetData:#(resetData), expectedStatus:<ExpectedStatus>}
    * match resetResponse == <ExpectedBody>

    Examples:
      | ExpectedStatus | ExpectedBody                                                      |
      | 200            | {"message":"Reset Email Sent","detail":"Please check your inbox"} |
#      | 200            | {"message":"#string","detail":"#string"}                          |

  Scenario Outline: Verify error message for i/v scenarios

    * call read('classpath:unit_test/reset.feature'){apiKey:<ApiKey>, resetData:<RequestBody>, expectedStatus:<ExpectedStatus>}
    * match resetResponse == <ExpectedBody>

    Examples:
      | ExpectedStatus | ApiKey                           | RequestBody                                     | ExpectedBody                                                                            |
      | 400            |                                  | {"email":"test235wr@fox.com"}                   | {"errorType":"Bad Request","errorMessage":"missing brand configuration"}                |
      | 404            | 6E9S4bmcoNnZwVLOHywOv8PJEdu76cM9 | {"email":"invalidemail@fox.com"}                | {"errorType":"Not Found","errorMessage":"user not found"}                               |
      | 404            | 6E9S4bmcoNnZwVLOHywOv8PJEdu76cM9 | {}                                              | {"errorType":"Not Found","errorMessage":"error while looking for user"}                 |
      | 400            | 6E9S4bmcoNnZwVLOHywOv8PJEdu76cM9 |                                                 | {"errorType":"Bad Request","errorMessage":"invalidparams"}                              |
      | 400            | 6E9S4bmcoNnZwVLOHywOv8PJEdu76cM9 | {"email":"test235wr@fox.com", "password":"123"} | {"errorType":"Bad Request","errorMessage":"rate limit exceeded for request parameters"} |