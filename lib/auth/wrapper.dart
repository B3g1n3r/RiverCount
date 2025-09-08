import 'package:bytelogik_assessment/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:bytelogik_assessment/pages/counter_page.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider.dart';


class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    if (user != null) {
      return const CounterPage();
    } else {
      return LoginPage();
    }
  }
}
