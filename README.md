# rick_morty

# Rick and Morty Characters Mobile App

This is a Flutter application that displays characters from the Rick and Morty universe using the public Rick and Morty GraphQL API. The app includes features such as character listing, pagination, and filtering by character status.

## Features

- **Character List**: Fetches and displays a list of characters from the Rick and Morty API.
- **Character Details**: Displays character details including name, image, status, and species.
- **Pagination**: Loads more characters as the user scrolls.
- **Filtering**: Allows users to filter characters by status (Alive, Dead, Unknown) using a dropdown menu.
- **Splash Screen**: Displays a splash screen with a Rick and Morty image when the app starts.

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (Channel stable, 2.5.0 or later)
- [Dart](https://dart.dev/get-dart) (2.14.0 or later)

### Installation

1. **Clone the repository**:

   ```sh
   git clone https://github.com/your-username/rick-morty-characters-app.git
   cd rick-morty-characters-app
   ```

### Assets

assets/rick_and_morty.png: Image used in the splash screen.

### Tests

Tests are located in the test directory and include unit tests for the CharacterBloc logic using bloc_test and mockito.

### Running Tests

    ```sh
    flutter test
