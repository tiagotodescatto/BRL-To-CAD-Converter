# 🪙 BRL to CAD Converter

A sleek, modern, and responsive currency converter built with Flutter that fetches real-time exchange rates from the AwesomeAPI to convert Brazilian Real (BRL) to Canadian Dollar (CAD) and vice-versa.

---

## Preview:

https://github.com/user-attachments/assets/cb3f90fb-45f2-4e99-b6db-d895e269096b

---

## 🚀 Features

* **Real-Time Data:** Integrates with a public API using `http` and `async/await` to get up-to-the-minute currency rates.
* **Instant Conversion:** Calculates the exchange value in real-time as the user types (`onChanged` state management).
* **Bi-directional Swap:** Quickly invert the conversion direction (BRL → CAD or CAD → BRL) with a single tap.
* **Dynamic Theme:** Smooth animated transition between Light Mode and Dark Mode.
* **Clean UI:** Styled with the *Rubik* font, customized glassmorphism-like cards, and soft shadows.

---

## 🛠️ Tech Stack & Concepts Learned

* **Framework:** Flutter (Dart)
* **State Management:** `StatefulWidget` & `setState`
* **API Consumption:** `http` package for asynchronous requests
* **JSON Parsing:** `dart:convert` to decode server responses
* **Input Handling:** `TextEditingController` and user input parsing safely with `double.tryParse`

---

## 📦 Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/tiagotodescatto/YOUR-REPOSITORY-NAME.git](https://github.com/tiagotodescatto/YOUR-REPOSITORY-NAME.git)

2. **Navigate to the project folder:**
   ```bash
   cd BRL-To-CAD-Converter

3. **Install the dependencies:**
   ```bash
   flutter pub get

4. **Run the application:**
   ```bash
   flutter run
---

## 🌐 API Reference
This project consumes the free and public API provided by AwesomeAPI.

Endpoint used: https://economia.awesomeapi.com.br/json/last/BRL-CAD

---

## Developed with 💖 by Tiago Todescatto
