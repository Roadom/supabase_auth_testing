import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:flutter/foundation.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SupaEmailAuth(
          redirectTo: kIsWeb ? null : 'io.mydomain.myapp://callback',
          onSignInComplete: (response) {
          },
          onSignUpComplete: (response) {
          },
          metadataFields: [],
        )
      ),
    );
  }
}



