import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logic_health/features/auth/widgets/custom_button_widget.dart';

import '../widgets/custom_input_field.dart';

class PatientsView extends StatefulWidget {
  static String id = '/patients';

  const PatientsView({super.key});

  @override
  State<PatientsView> createState() => _PatientsViewState();
}

class _PatientsViewState extends State<PatientsView> {
  // Controllers and State variables
  final TextEditingController ageController = TextEditingController();
  final TextEditingController oldpeakController = TextEditingController();
  final TextEditingController restBPController = TextEditingController();
  final TextEditingController cholesterolController = TextEditingController();
  final TextEditingController maxHRController = TextEditingController();

  String? selectedSex;
  String? selectedChestPainType;
  String? selectedExerciseAngina;
  String? selectedSTSlope;
  String? selectedFastingBS;
  String? selectedRestingECG;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/logoI.png', height: 40),
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

                    Padding(
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
                              'Patient Information',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),

                            CustomInputField(
                              label: 'Age',
                              hintText: "Enter patient's age",
                              keyboardType: TextInputType.number,
                              controller: ageController,
                            ),

                            CustomInputField(
                              label: 'Sex',
                              hintText: "Patient's sex",
                              options: const ['Male', 'Female'],
                              value: selectedSex,
                              onChanged: (val) {
                                setState(() => selectedSex = val);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
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
                              'Symptoms & Conditions',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),

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
                              onChanged: (val) {
                                setState(() => selectedChestPainType = val);
                              },
                            ),
                            CustomInputField(
                              label: 'ExerciseAngina',
                              hintText: "Select exang option",
                              options: const ['Yes', 'No'],
                              value: selectedExerciseAngina,
                              onChanged: (val) {
                                setState(() => selectedExerciseAngina = val);
                              },
                            ),
                            CustomInputField(
                              label: 'OldPeak',
                              hintText: "Enter ST Depression",
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              controller: oldpeakController,
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
                              onChanged: (val) {
                                setState(() => selectedSTSlope = val);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
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
                              'Vital Signs & Measurements',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            CustomInputField(
                              label: 'RestingBP',
                              hintText: "Enter patient’s resting BP level",
                              keyboardType: TextInputType.number,
                              controller: restBPController,
                            ),

                            CustomInputField(
                              label: 'Cholesterol',
                              hintText: "Enter cholesterol",
                              keyboardType: TextInputType.number,
                              controller: cholesterolController,
                            ),

                            CustomInputField(
                              label: 'Thalch',
                              hintText: "Enter max heart rate achieved",
                              keyboardType: TextInputType.number,
                              controller: maxHRController,
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
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
                              'Blood-Related Tests',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            CustomInputField(
                              label: 'FastingBS',
                              hintText: "Fasting BS > 120 mg/dl?",
                              options: const ['Yes', 'No'],
                              value: selectedFastingBS,
                              onChanged: (val) {
                                setState(() => selectedFastingBS = val);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
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
                              'ECG & Heart Function Tests',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            CustomInputField(
                              label: 'RestingECG',
                              hintText: "Select patient’s restingECG",
                              options: const [
                                'Normal (0)',
                                'ST-T Wave Abnormality (1)',
                                'Left Ventricular Hypertrophy (2)',
                              ],
                              value: selectedRestingECG,
                              onChanged: (val) {
                                setState(() => selectedRestingECG = val);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Another container for other fields...
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomButtonWidget(text: 'Predict', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
