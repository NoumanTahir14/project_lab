# Motorbike Shop - Flutter E-Commerce App

A complete e-commerce application for browsing and purchasing motorbikes, built with Flutter and GetX state management.

assets/images/login.png
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
