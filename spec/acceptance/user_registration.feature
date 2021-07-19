Feature: User registration

  @user_registration
  Scenario: User registers and logs in automatiacally
    Background:
      Given no user in the system
    When the user sends a registration request
      Then create a new user
      And return the auth data
      And return the user data
    When the user requests a restricted resource
      Then the access is granted

  @user_registration_fails
  Scenario: User can't register with wrong input data
    Background:
      Given no user in the system
    When the user sends a registration request
      Then the request is denied
      And return the validaiton errors
