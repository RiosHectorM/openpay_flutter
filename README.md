# OpenPay Clients and Markets Management

## Overview

This Flutter application is designed for seamless management of clients using CRUD operations and provides a comprehensive view of OpenPay markets based on geographic coordinates (latitude and longitude). Leveraging the OpenPay API, the app allows users to create, edit, list, and delete clients while offering the ability to explore nearby markets.

## Features

- **Client Management:**
  - Create, edit, list, and delete clients with ease.
- **Market Exploration:**
  - View OpenPay markets based on geographic coordinates.
- **Geographic Coordinates:**
  - Utilizes preloaded city data with corresponding latitude and longitude values.
  - Dynamically retrieves the nearest markets by calling the OpenPay API.

## Getting Started

Follow these steps to set up and run the project locally:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/RiosHectorM/openpay_flutter.git

   ```

2. **Navigate to the project directory:**

   ```bash
   cd openpay_flutter

   ```

3. **Install dependencies:**

   ```bash
   flutter pub get
   ```

4. **Run the application:**

   ```bash
   flutter run
   ```

## Usage

1. Open the application on your preferred Flutter-compatible environment.
2. Navigate through the user-friendly interface to manage clients and explore OpenPay markets.
3. Interact with the app to create, edit, list, or delete clients as needed.

## Dependencies

- **Flutter:** v3.16.2
- **Dart:** v3.2.2
- **dio:** ^5.4.0
- **flutter_dotenv:** ^5.1.0
- **go_router:** ^12.1.1

## Dev Dependencies

- **flutter_lints:** ^2.0.0

## Configuration

Before running the application, ensure you have an API key for authentication. You will receive the API key via email. Create a `.env` file at the root of the project and add the API key:

```dotenv
API_KEY=your_received_api_key
```
