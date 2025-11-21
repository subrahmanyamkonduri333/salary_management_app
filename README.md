# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Application dependencies
  Ruby: 3.2.9
  Rails: 8.1.1
  Database: SQLite
  Testing: RSpec, FactoryBot

* How to run the test suite
  bundle exec rspec

* AI used (based on the expectations)
  Tools: ChatGPT (To prompt the requirement using TDD approach)

  # First created the application as API only
  # Added required gems like RSpec & FactoryBot to Gemfile & installation
  # Given the below prompt in ChatGPT
    # Step-1:
      # Prompt: For the below requirement, scaffold the code and write failing test cases using RSpec using TDD principle
        * Copy Pasted requirement
        * Added the provided data into the application
      # Tested the RSpecs to check TDD behaviour. All the tests were failing.
    # Step-2:
      # Prompt: Now, write the passing implementation, add factories (factorybot)
        * Added the provided data
      # Tested the RSpecs to check all were success or not, and they Succeeded.
    # Step-3:
      # Prompt: Now, improve the test coverage and add request specs for invalid inputs
        * Added the provided data
      # Tested the RSpecs to check all were success or not with the refactoring and more invalid inputs, and they Succeeded.
  # Tested the application by creating the test data using postman and verified APIs response. They are working as expected. (Whenever required few minor changes in the entire above flow to add required gems and fix the issues in code to make all the suggested changes of ChatGPT work in an expected manner).