Feature: User session
  Background:
    Given a registered user

  @user_session_end_to_end
  Scenario: End to end
    When the user is not signed in
      Then he cannot access the restricted area
    When the user signs in
      Then he can access the restricted area
    When the user signs out
      Then he cannot access the restricted area anymore
