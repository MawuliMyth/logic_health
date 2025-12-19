import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logic_health/features/auth/widgets/custom_button_widget.dart';
import 'package:logic_health/features/patients/views/prediction_result_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart'; // Ensure this is in pubspec.yaml

import '../controllers/prediction_controller.dart';
import '../models/patients_model.dart';
import '../widgets/custom_input_field.dart';

class PatientsView extends StatefulWidget {
  static String id = '/patients';

  const PatientsView({super.key});

  @override
  State<PatientsView> createState() => _PatientsViewState();
}

class _PatientsViewState extends State<PatientsView> {
  final _formKey = GlobalKey<FormState>();
  final PredictionController _predictionController = PredictionController();

  // Controllers
  final TextEditingController ageController = TextEditingController();
  final TextEditingController oldpeakController = TextEditingController();
  final TextEditingController restBPController = TextEditingController();
  final TextEditingController cholesterolController = TextEditingController();
  final TextEditingController maxHRController = TextEditingController();

  // State variables for dropdowns
  String? selectedSex;
  String? selectedChestPainType;
  String? selectedExerciseAngina;
  String? selectedSTSlope;
  String? selectedFastingBS;
  String? selectedRestingECG;

  bool _isLoading = false;

  @override
  void dispose() {
    // Always dispose controllers to save memory
    ageController.dispose();
    oldpeakController.dispose();
    restBPController.dispose();
    cholesterolController.dispose();
    maxHRController.dispose();
    super.dispose();
  }

  Future<void> _handlePrediction() async {
    bool isFormValid = _formKey.currentState?.validate() ?? false;

    bool isDropdownsValid =
        selectedSex != null &&
        selectedChestPainType != null &&
        selectedExerciseAngina != null &&
        selectedSTSlope != null &&
        selectedFastingBS != null &&
        selectedRestingECG != null;

    if (!isFormValid || !isDropdownsValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields and selections correctly.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final patientData = HeartPredictionModel.fromForm(
        age: ageController.text,
        sex: selectedSex!,
        chestPainType: selectedChestPainType!,
        restingBP: restBPController.text,
        cholesterol: cholesterolController.text,
        fastingBS: selectedFastingBS!,
        restingECG: selectedRestingECG!,
        thalch: maxHRController.text,
        exerciseAngina: selectedExerciseAngina!,
        oldPeak: oldpeakController.text,
        stSlope: selectedSTSlope!,
      );

      final result = await _predictionController.getPrediction(patientData);

      if (result != null) {
        // Save to Firestore
        await _predictionController.saveToFirestore(result, patientData);

        if (!mounted) return;

        showMaterialModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => PredictionResultModal(result: result),
        );
      } else {
        throw Exception("Failed to get response from the server.");
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF5F5),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.favorite, color: Colors.red, size: 30),
                      const SizedBox(width: 8),
                      Text(
                        'Patients',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Heart Disease Prediction',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xff818181)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'Add a New Patient Information',
                          style: GoogleFonts.poppins(fontSize: 13),
                        ),
                      ),
                      const Divider(color: Color(0xff818181), height: 1),

                      _buildSectionContainer(
                        title: 'Patient Information',
                        children: [
                          CustomInputField(
                            label: 'Age',
                            hintText: "Enter patient's age",
                            keyboardType: TextInputType.number,
                            controller: ageController,
                            validator: (v) =>
                                (v == null || v.isEmpty) ? 'Required' : null,
                          ),
                          CustomInputField(
                            label: 'Sex',
                            hintText: "Patient's sex",
                            options: const ['Male', 'Female'],
                            value: selectedSex,
                            onChanged: (val) =>
                                setState(() => selectedSex = val),
                          ),
                        ],
                      ),

                      _buildSectionContainer(
                        title: 'Symptoms & Conditions',
                        children: [
                          CustomInputField(
                            label: 'Chest Pain Type',
                            hintText: "Select chest pain type",
                            options: const [
                              'Typical Angina (Type 0)',
                              'Atypical Angina (Type 1)',
                              'Non-anginal Pain (Type 2)',
                              'Asymptomatic (Type 3)',
                            ],
                            value: selectedChestPainType,
                            onChanged: (val) =>
                                setState(() => selectedChestPainType = val),
                          ),
                          CustomInputField(
                            label: 'Exercise Angina',
                            hintText: "Select exang option",
                            options: const ['Yes', 'No'],
                            value: selectedExerciseAngina,
                            onChanged: (val) =>
                                setState(() => selectedExerciseAngina = val),
                          ),
                          CustomInputField(
                            label: 'OldPeak',
                            hintText: "Enter ST Depression",
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            controller: oldpeakController,
                            validator: (v) =>
                                (v == null || v.isEmpty) ? 'Required' : null,
                          ),
                          CustomInputField(
                            label: 'ST_Slope',
                            hintText: "Slope of peak exercise ST segment",
                            options: const [
                              'Upsloping (0)',
                              'Flat (1)',
                              'Downsloping (2)',
                            ],
                            value: selectedSTSlope,
                            onChanged: (val) =>
                                setState(() => selectedSTSlope = val),
                          ),
                        ],
                      ),

                      _buildSectionContainer(
                        title: 'Vital Signs & Measurements',
                        children: [
                          CustomInputField(
                            label: 'RestingBP',
                            hintText: "Enter patient’s resting BP level",
                            keyboardType: TextInputType.number,
                            controller: restBPController,
                            validator: (v) =>
                                (v == null || v.isEmpty) ? 'Required' : null,
                          ),
                          CustomInputField(
                            label: 'Cholesterol',
                            hintText: "Enter cholesterol",
                            keyboardType: TextInputType.number,
                            controller: cholesterolController,
                            validator: (v) =>
                                (v == null || v.isEmpty) ? 'Required' : null,
                          ),
                          CustomInputField(
                            label: 'Thalch',
                            hintText: "Enter max heart rate achieved",
                            keyboardType: TextInputType.number,
                            controller: maxHRController,
                            validator: (v) =>
                                (v == null || v.isEmpty) ? 'Required' : null,
                          ),
                        ],
                      ),

                      _buildSectionContainer(
                        title: 'Blood & Heart Function',
                        children: [
                          CustomInputField(
                            label: 'FastingBS',
                            hintText: "Fasting BS > 120 mg/dl?",
                            options: const ['Yes', 'No'],
                            value: selectedFastingBS,
                            onChanged: (val) =>
                                setState(() => selectedFastingBS = val),
                          ),
                          CustomInputField(
                            label: 'RestingECG',
                            hintText: "Select patient’s restingECG",
                            options: const [
                              'Normal (0)',
                              'ST-T Wave Abnormality (1)',
                              'Left Ventricular Hypertrophy (2)',
                            ],
                            value: selectedRestingECG,
                            onChanged: (val) =>
                                setState(() => selectedRestingECG = val),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.red),
                      )
                    : CustomButtonWidget(
                        text: 'Predict',
                        onPressed: _handlePrediction,
                      ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionContainer({
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xff818181)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // ...children,
          ],
        ),
      ),
    );
  }
}
