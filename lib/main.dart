import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['URL']!,
    anonKey: dotenv.env['ANON_KEY']!
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Instruments',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SupaEmailAuth(
          redirectTo: kIsWeb ? null : 'com.example.supabase_test://callback',
          onSignInComplete: (response) {
            if (response.session != null) {
              // Successful login
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          onSignUpComplete: (response) {
            if (response.user != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account created! Please log in.')),
              );
            }
          },
          metadataFields: [
            MetaDataField(
              prefixIcon: const Icon(Icons.person),
              label: 'Username',
              key: 'username',
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter something';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}