import 'package:flutter/material.dart';
import 'package:qonnected_app/helper/shared_preferences.dart';
import 'package:qonnected_app/page/initial_page.dart';
import 'package:qonnected_app/page/login.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
    if (mounted) {
      Get.offAll(LoginPage());
      // Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
  }

  @override
  void onAuthenticated(Session session) {
    if (mounted) {
      HelperSharedPreferences.storageProfile();
      HelperSharedPreferences.refreshStorage();
      Get.offAll(const InitialPage());

      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil('/initpage', (route) => false);
    }
  }

  @override
  void onPasswordRecovery(Session session) {}

  @override
  void onErrorAuthenticating(String message) {
    SnackBar(
      content: Text(message),
    );
  }
}
