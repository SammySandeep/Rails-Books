# Ruby on Rails Books Application

This Rails application is used to notify third-party APIs of any data changes.

## Getting started

Prerequisites
Before you begin, ensure you have the following installed on your system:
   
    Ruby version :- 3.2.2
    Rails version :- 7.0.6

Clone this repository to your local machine:

    ```bash
    > git clone https://github.com/SammySandeep/rails-books.git
    ```

Navigate to the project directory

    ```bash
    > cd rails-books 
    ```

Install the required gems

    ```bash
    > bundle install 
    ```
    
Setup the database 

    ```bash
    > rails db:create
    > rails db:migrate
    ```

Create a .env file at the root of your Rails project:
    
    # .env
    THIRD_PARTY_API_ENDPOINTS='your_api_endpoint_here'
    jwt_secret='your_jwt_secret'

Start the Rails server on port 3000:

    ```bash
    > rails server
    ```  

Start the Sidekiq background processing worker by running:

    ```bash
    > bundle exec sidekiq
    ```

This application uses RSpec for testing. Run tests with:

    ```bash
    > rspec
    ```

Open your web browser and go to http://localhost:3000/. Now, whenever new data is stored or updated in the Book model, all configured endpoints (as per the THIRD_PARTY_API_ENDPOINTS environment variable) will be notified of the changes. You have to set the JWT secret environment variable, which is used to encode and decode the token. To notify the third-party APIs follow the documentation :- https://github.com/SammySandeep/Notification-API