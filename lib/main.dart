import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logic_health/features/auth/views/login_view.dart';
import 'package:logic_health/features/dashboard/views/home_bot_view.dart';
import 'package:logic_health/features/profile/views/privacy_view.dart';
import 'package:logic_health/features/profile/views/profile_details_view.dart';
import 'package:provider/provider.dart';

import 'features/auth/provider/auth_provider.dart';
import 'features/dashboard/views/dashboard_view.dart';
import 'features/patients/views/patients_view.dart';
import 'features/profile/views/about_view.dart';
import 'features/profile/views/history_view.dart';
import 'features/profile/views/profile_view.dart';
import 'features/profile/views/terms_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthProvider>(
          builder: (context, auth, child) {
            if (auth.isAuthenticated) {
              return const HomeBotView();
            } else {
              return const LoginView();
            }
          },
        ),
        routes: {
          LoginView.id: (context) => const LoginView(),
          DashboardView.id: (context) => DashboardView(),
          PatientsView.id: (context) => const PatientsView(),
          ProfileView.id: (context) => const ProfileView(),
          HomeBotView.id: (context) => const HomeBotView(),
          ProfileDetailsView.id: (context) => const ProfileDetailsView(),
          HistoryView.id: (context) => const HistoryView(),
          PrivacyView.id: (context) => const PrivacyView(),
          TermsView.id: (context) => const TermsView(),
          AboutView.id: (context) => const AboutView(),
        },
      ),
    );
  }
}
