import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/patients_model.dart';

const String appId = 'heart-disease-predictor';

class PredictionController {
  final String apiUrl = "http://184.72.114.0:8000/predict";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getPrediction(HeartPredictionModel data) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("Exception during API call: $e");
      return null;
    }
  }

  Future<void> saveToFirestore(
    Map<String, dynamic> apiResult,
    HeartPredictionModel inputData,
  ) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        UserCredential userCredential = await _auth.signInAnonymously();
        user = userCredential.user;
      }

      if (user == null) return;

      final dataToSave = {
        'userId': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
        'input': inputData.toJson(),
        'prediction_result': apiResult,
        'status': 'success',
      };

      await _db.collection('predictions').add(dataToSave);
      debugPrint("Data saved successfully.");
    } catch (e) {
      debugPrint("Error saving to Firestore: $e");
    }
  }

  Future<void> deletePrediction(String docId) async {
    try {
      await _db.collection('predictions').doc(docId).delete();
      debugPrint("Document $docId deleted successfully.");
    } catch (e) {
      debugPrint("Error deleting document: $e");
      rethrow;
    }
  }

  Stream<QuerySnapshot> getRecentPredictions() {
    return _db
        .collection('predictions')
        .orderBy('timestamp', descending: true) // Newest at the top
        .snapshots();
  }
}
