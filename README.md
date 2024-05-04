# Reel Registry API

Reel Registry is an API built with Ruby on Rails for managing information about movies. It provides endpoints for registering movies, creating users, and supports pagination using Kaminari.

## Live

You can access it at the following link: [Live](https://reel-registry-42eba4ed2ec6.herokuapp.com/)

Explore and enjoy the API's functionality in real-time!

## Installation

1. Clone the repository:

```bash
git clone https://github.com/eugenio1590/reel-registry.git
```

2. Install dependencies:

```
bundle install
```

3. Set up the database:

```
rails db:create
rails db:migrate
rails db:seed
```

4. Set SECRET_KEY_BASE in your environment variables:

```
export SECRET_KEY_BASE=your_secret_key_base
```

## Running the Project

### Database Configuration

The project uses PostgreSQL as the database in production mode and SQLite for development and testing environments. You can configure the database settings in `config/database.yml`.

### Seeding Data

Seed data is provided to populate the database with initial records. You can find the seed data in `db/seeds.rb`. To load the seeds, run:

```
rails db:seed
```

To start the server, run:

```
rails server
```

The API will be available at http://localhost:3000.

## Tests

Tests are written using Minitest and FactoryBot. To run the tests, use:

```
rails test
```

## Architecture

The Reel Registry API follows a typical Ruby on Rails architecture, adhering to MVC (Model-View-Controller) design pattern for organization and separation of concerns.

- Models: Responsible for managing the data logic, including interactions with the database. Models represent the structure of the data and define relationships between different entities, such as movies and users.

- Controllers: Handle incoming requests, process the data, and determine the appropriate response. Controllers serve as the intermediaries between the models and views, executing business logic and orchestrating the flow of data.

- Policies: Policies, implemented using Pundit, control access to different resources based on user roles. They enforce authorization rules, ensuring that users can only perform actions they are authorized to do.

- Routes: Define the endpoints and their corresponding controller actions. Routes map HTTP requests to specific controller actions, directing the flow of traffic within the application.

The API primarily returns data in JSON format. Views are not utilized in the traditional sense, as the API responses are structured data instead of HTML. Instead, the controllers render JSON responses directly to the client, providing the necessary data for consumption by frontend applications or other services.

The architecture emphasizes modularity, scalability, and maintainability, enabling the application to evolve and accommodate future requirements seamlessly. Additionally, adherence to best practices and conventions ensures consistency and facilitates collaboration among developers.

## API Endpoints

Documentation about the endpoints available [here](https://documenter.getpostman.com/view/170902/2sA3JGe3es).

### Authentication

JWT (JSON Web Token) is used for authentication. Users need to include the token in the request headers for authorized endpoints.

### Authorization

Pundit is used for authorization. Policies are defined to control access to different resources based on user roles.

### Pagination

Kaminari is used for pagination. Pagination parameters can be included in the request query parameters to paginate through large datasets. Read more about it in the documentation.

### Error Handling

The API handles errors gracefully and provides appropriate error responses with descriptive messages.

### Support

Feel free to reach out if you have any questions or need further assistance!