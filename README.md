# Motorbike Shop - Flutter E-Commerce App
![design](https://github.com/user-attachments/assets/90ac7c96-8ec9-4696-88bb-5b94053e354a)

A complete e-commerce application for browsing and purchasing motorbikes, built with Flutter and GetX state management.

## ScreenSHots

![signup](https://github.com/user-attachments/assets/ea6f9fbc-edba-4a2c-ac66-3ba3b98342e1)
![login](https://github.com/user-attachments/assets/2b7dd317-3da9-480f-8779-6ce16ddf739f)
![home](https://github.com/user-attachments/assets/ea2f5932-4e6f-4188-9e75-e9758d3b1852)
![detail](https://github.com/user-attachments/assets/727710d8-0e95-4fb3-8fa4-f107be7baba3)
![cart](https://github.com/user-attachments/assets/286df1b2-9d77-4845-9722-6fe7551e09de)
![order](https://github.com/user-attachments/assets/b184a76a-f137-4f94-ad72-4fac3dce6fd1)

## Video
https://github.com/user-attachments/assets/2ceb0ccf-5328-40ba-8a4b-f50672d2d30a

## Features

- 🏍️ Browse motorbikes with detailed specifications
- 🔍 Search functionality to find specific models
- 🛒 Shopping cart with item management
- 🔐 User authentication (login/signup)
- 💳 Checkout process with multiple payment methods
- 📦 Order history tracking
- 🌙 Responsive UI with dark mode support (optional)

## Technologies Used

- **Flutter** - Cross-platform framework
- **GetX** - State management, navigation, and dependency injection
- **Cached Network Image** - For efficient image loading
- **Shimmer** - For loading placeholders
- **Sqflite** - Local database for orders (optional)

## Installation

1. **Prerequisites**
   - Flutter SDK (latest stable version)
   - Android Studio/VSCode with Flutter plugins
   - Android NDK version 27.0.12077973

2. **Setup**
   ```bash
   git clone https://github.com/yourusername/motorbike-shop.git
   cd motorbike-shop
   flutter pub get


lib/
├── controllers/          # GetX controllers
│   ├── auth_controller.dart
│   ├── cart_controller.dart
│   └── payment_controller.dart
├── models/              # Data models
│   ├── motorbike.dart
│   ├── order.dart
│   └── user.dart
├── screens/             # Application screens
│   ├── auth/            # Authentication screens
│   ├── cart/            # Cart and checkout
│   ├── motorbikes/      # Product browsing
│   └── orders/          # Order management
├── widgets/             # Reusable components
└── main.dart            # App entry point

Screens

    Authentication

        Login screen

        Signup screen

    Motorbike Catalog

        Grid view of available motorbikes

        Search functionality

        Product details screen

    Shopping Cart

        Add/remove items

        Quantity adjustment

        Total calculation

    Checkout

        Address input

        Payment method selection

        Order confirmation

    Order History

        List of past orders

        Order details view
