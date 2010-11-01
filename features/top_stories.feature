Feature: Top Stories

  Scenario: Selecting a top story reveals the body
  
    Given the following top stories:
      | title                            | body                                         |
      | Explosives found in Yemen cargo  | constituted a credible terrorist threat      |
      | Cameron claims EU budget success | criticism he has agreed to an EU budget rise |
    When I select the story "Cameron claims EU budget success"
    Then I should see the body "criticism he has agreed to an EU budget rise"
    