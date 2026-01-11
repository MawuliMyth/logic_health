Logic Health 🩺
Logic Health is a Flutter-based healthcare application designed to provide users with instant heart health risk assessments. By leveraging machine learning and real-time data synchronization, users can input biological data, receive risk predictions, and manage their health history securely.

🚀 Features
Heart Risk Prediction: Connects to a specialized FastAPI/ML backend to predict risk levels based on user-provided biological parameters.

User History: A personalized history view that displays previous prediction results.

Secure Data Management: Integrated with Firebase Auth and Firestore to ensure users only see their own data.

Interactive UI: Modern design using Google Fonts (Poppins), custom modals, and swipe-to-delete functionality.


🛠 Tech Stack
Frontend: Flutter (Dart)

Backend Database: Google Firebase Firestore

Authentication: Firebase Auth

Machine Learning API: FastAPI (Deployed on AWS/EC2)

State Management: Controller-based logic separation

📂 Project Structure
lib/
├── patients/
│   ├── controllers/      # Business logic (PredictionController.dart)
│   ├── models/           # Data models (UserModel.dart, HeartPredictionModel.dart)
│   └── views/            # UI screens (HistoryView.dart, PredictionResultModal.dart)
├── main.dart             # App entry point
└── firebase_options.dart # Firebase configuration
