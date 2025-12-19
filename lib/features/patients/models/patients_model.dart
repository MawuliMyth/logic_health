class HeartPredictionModel {
  final int age;
  final String sex;
  final String chestPainType;
  final int restingBP;
  final int cholesterol;
  final int fastingBS;
  final String restingECG;
  final int thalch;
  final String exerciseAngina;
  final double oldPeak;
  final String stSlope;

  HeartPredictionModel({
    required this.age,
    required this.sex,
    required this.chestPainType,
    required this.restingBP,
    required this.cholesterol,
    required this.fastingBS,
    required this.restingECG,
    required this.thalch,
    required this.exerciseAngina,
    required this.oldPeak,
    required this.stSlope,
  });

  factory HeartPredictionModel.fromForm({
    required String age,
    required String sex,
    required String chestPainType,
    required String restingBP,
    required String cholesterol,
    required String fastingBS,
    required String restingECG,
    required String thalch,
    required String exerciseAngina,
    required String oldPeak,
    required String stSlope,
  }) {
    return HeartPredictionModel(
      age: int.tryParse(age) ?? 0,
      sex: sex, // "Male" or "Female" as per your sample
      chestPainType: _mapChestPain(chestPainType),
      restingBP: int.tryParse(restingBP) ?? 0,
      cholesterol: int.tryParse(cholesterol) ?? 0,
      fastingBS: fastingBS == 'Yes' ? 1 : 0,
      restingECG: _mapECG(restingECG),
      thalch: int.tryParse(thalch) ?? 0,
      exerciseAngina: exerciseAngina == 'Yes' ? 'Y' : 'N',
      oldPeak: double.tryParse(oldPeak) ?? 0.0,
      stSlope: _mapSlope(stSlope),
    );
  }

  static String _mapChestPain(String val) {
    if (val.contains('Type 0')) return 'TA';
    if (val.contains('Type 1')) return 'ATA';
    if (val.contains('Type 2')) return 'NAP';
    return 'ASY';
  }

  static String _mapECG(String val) {
    if (val.contains('(0)')) return 'Normal';
    if (val.contains('(1)')) return 'ST';
    return 'LVH';
  }

  static String _mapSlope(String val) {
    if (val.contains('(0)')) return 'Up';
    if (val.contains('(1)')) return 'Flat';
    return 'Down';
  }

  Map<String, dynamic> toJson() {
    return {
      "Age": age,
      "Sex": sex,
      "ChestPainType": chestPainType,
      "RestingBP": restingBP,
      "Cholesterol": cholesterol,
      "FastingBS": fastingBS,
      "RestingECG": restingECG,
      "thalch": thalch,
      "ExerciseAngina": exerciseAngina,
      "OldPeak": oldPeak,
      "ST_Slope": stSlope,
    };
  }
}
