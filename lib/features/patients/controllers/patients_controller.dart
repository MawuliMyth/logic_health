import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../models/patients_model.dart';

// Assuming these are globally available or passed in
const String appId = 'heart-disease-predictor';

class PredictionController {
  final String apiUrl = "http://184.72.114.0:8000/predict";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Performs API call and prints result
  Future<Map<String, dynamic>?> getPrediction(HeartPredictionModel data) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data.toJson()),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        print("--- API REQUEST SENT ---");
        print(jsonEncode(data.toJson()));
        print("--- API RESPONSE RECEIVED ---");
        print(result);

        return result;
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception during API call: $e");
      return null;
    }
  }

  /// Implements Cloud Storage using Firestore (Rule 1, 2, 3 compliant)
  Future<void> saveToFirestore(
    Map<String, dynamic> apiResult,
    HeartPredictionModel inputData,
  ) async {
    try {
      // RULE 3: Auth Before Queries
      User? user = _auth.currentUser;
      if (user == null) {
        print("Authenticating anonymously...");
        UserCredential userCredential = await _auth.signInAnonymously();
        user = userCredential.user;
      }

      if (user == null) {
        print("Failed to authenticate user.");
        return;
      }

      // RULE 1: Strict Paths
      // Saving to public data so multiple users can see results, or switch to 'users' for private.
      final collectionPath = _db
          .collection('artifacts')
          .doc(appId)
          .collection('public')
          .doc('data')
          .collection('predictions');

      final dataToSave = {
        'userId': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
        'input': inputData.toJson(),
        'prediction_result': apiResult,
        'status': 'success',
      };

      await collectionPath.add(dataToSave);
      print(
        "Data successfully saved to Firestore path: /artifacts/$appId/public/data/predictions",
      );
    } catch (e) {
      print("Error saving to Firestore: $e");
    }
  }

  /// Optional: Fetch recent predictions (Rule 2: Simple query only)
  Stream<QuerySnapshot> getRecentPredictions() {
    // RULE 2: No complex queries (no orderBy/limit here to avoid index requirement errors)
    return _db
        .collection('artifacts')
        .doc(appId)
        .collection('public')
        .doc('data')
        .collection('predictions')
        .snapshots();
  }
}
