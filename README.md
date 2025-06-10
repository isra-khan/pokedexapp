# pokedex


For help getting started with Flutter development, view the

# Pokedex App

A comprehensive mobile Pokedex application built with Flutter, featuring Firebase Authentication, real-time Pokemon data fetched from a public API, and robust state management using the Bloc pattern.

## ✨ Features

* **User Authentication:** Secure user sign-up and login powered by Firebase Authentication (Email/Password).
* **Pokemon Listing:** Browse a vast collection of Pokemon, displaying their names and basic information.
* **Pokemon Details:** Tap on any Pokemon to view detailed statistics, abilities, types, and more.
* **Real-time Data:** Fetches up-to-date Pokemon information from a public API.
* **Efficient State Management:** Leverages the **Bloc pattern** for predictable and scalable state management throughout the application.
* **Local Persistence:** Uses `shared_preferences` for lightweight local data storage (e.g., user session).
* **User-Friendly UI:** Clean and intuitive interface designed for a seamless user experience.

## 📱 Screenshots


<img src="https://github.com/user-attachments/assets/9112d8d2-ca75-4593-9118-fcfbd9a222bb" alt="Login Screen" width="200">
<img src="https://github.com/user-attachments/assets/a65f8a9a-185e-42d0-9579-f29bb8f3c21a" alt="Signup Screen" width="200">
<img src="https://github.com/user-attachments/assets/9cc9e7ad-24f8-4ff6-aa51-ad28fa1d27a6" alt="Pokemon List" width="200">
<img src="https://github.com/user-attachments/assets/fcac72dd-7aa0-4789-833d-1a783ea5f86e" alt="Pokemon Detail 1" width="200">
<img src="https://github.com/user-attachments/assets/baef6ee5-addc-4fb7-809e-7f931598114c" alt="Pokemon Detail 2" width="200">
<img src="https://github.com/user-attachments/assets/23e6fdb3-7c8b-4525-8eaa-9e36fd5b2d36" alt="Another Pokemon Detail" width="200">
## 🛠️ Technologies Used

* **Flutter:** Google's UI toolkit for building natively compiled applications .
* **Firebase Authentication:** For secure user sign-up and login.
* **Cloud Firestore:** A flexible, scalable NoSQL cloud database for storing and syncing data (if used for user profiles or custom data).§
* **Bloc / Flutter Bloc:** A popular state management library that helps implement the BLoC (Business Logic Component) pattern, separating business logic from UI.
* **Equatable:** Used with Bloc to simplify value equality comparisons.
* **HTTP Package:** For making network requests to the Pokemon API.
* **`flutter_form_builder` & `form_builder_validators`:** For robust form creation and validation.
* **`shared_preferences`:** For simple key-value pair storage.
* **`fluttertoast`:** For displaying toast messages.

## ⚡️ API Integration

This application fetches Pokemon data from a public API. While the exact API endpoint used within the app's code is dynamic, it follows a structure similar to:

