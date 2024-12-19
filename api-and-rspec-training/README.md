# API and RSpec Training

Rails API backend for social media application with RSpec testing.

## Setup

### Prerequisites
- Ruby version: 7.2.2
- SQLite3
- Bundler

### Installation
```bash
# Install dependencies
bundle install

# Setup database
rails db:setup
```

### Running Tests
```bash
bundle exec rspec
```

## API Documentation

### Authentication
#### Login
- **POST** `/api/login`
  - Request Body:
    ```json
    {
      "username": "string",
      "password": "string"
    }
    ```
  - Response: 200 OK
    ```json
    {
      "id": "integer",
      "username": "string"
    }
    ```
  - Error: 401 Unauthorized
    ```json
    {
      "error": "Invalid username or password"
    }
    ```

#### Logout
- **DELETE** `/api/logout`
  - Response: 200 OK
    ```json
    {
      "message": "Successfully logged out"
    }
    ```

### Users
#### Get Current User
- **GET** `/api/users/me`
  - Response: 200 OK
    ```json
    {
      "id": "integer",
      "username": "string",
      "profile": "string"
    }
    ```
  - Error: 404 Not Found

#### Get User
- **GET** `/api/users/:id`
  - Response: 200 OK
    ```json
    {
      "id": "integer",
      "username": "string",
      "profile": "string"
    }
    ```
  - Error: 404 Not Found

#### Update User
- **PATCH/PUT** `/api/users/:id`
  - Request Body:
    ```json
    {
      "user": {
        "username": "string",
        "profile": "string"
      }
    }
    ```
  - Response: 200 OK
  - Errors:
    - 403 Forbidden: Not authorized
    - 422 Unprocessable Entity: Invalid parameters

### Posts
#### List Posts
- **GET** `/api/posts`
  - Response: 200 OK
    ```json
    {
      "posts": [
        {
          "id": "integer",
          "content": "string",
          "user": {
            "id": "integer",
            "username": "string"
          }
        }
      ]
    }
    ```

#### Create Post
- **POST** `/api/posts`
  - Request Body:
    ```json
    {
      "content": "string"
    }
    ```
  - Response: 201 Created
  - Error: 422 Unprocessable Entity

#### Get Post
- **GET** `/api/posts/:id`
  - Response: 200 OK
  - Error: 404 Not Found

### Social Interactions
#### Follow User
- **POST** `/api/users/:user_id/follow`
  - Response: 201 Created
  - Error: 422 Unprocessable Entity

#### Unfollow User
- **POST** `/api/users/:user_id/unfollow`
  - Response: 200 OK
  - Error: 404 Not Found

#### Like Post
- **POST** `/api/posts/:post_id/like`
  - Response: 201 Created
  - Error: 422 Unprocessable Entity

#### Unlike Post
- **DELETE** `/api/posts/:post_id/like`
  - Response: 200 OK
  - Error: 404 Not Found

#### Create Comment
- **POST** `/api/posts/:post_id/comments`
  - Request Body:
    ```json
    {
      "content": "string"
    }
    ```
  - Response: 201 Created
  - Error: 422 Unprocessable Entity

## Authentication
All endpoints except `/api/login` require authentication. Include the session cookie in all requests.

## Error Responses
All error responses follow the format:
```json
{
  "error": "Error message"
}
```
