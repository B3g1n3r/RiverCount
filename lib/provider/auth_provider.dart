import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/user_repository.dart';

final authProvider = StateProvider<String?>((ref) => null);

Future<void> login(String username, String password, WidgetRef ref) async {

  final success = await UserRepository.logIn(username, password);
  if (success) {
    ref.read(authProvider.notifier).state = username;
  } else {
    ref.read(authProvider.notifier).state = null;
  }
}

Future<void> logout(WidgetRef ref) async {
  await UserRepository.logOut();
  ref.read(authProvider.notifier).state = null; 
}

Future<bool> register(String username, String password, WidgetRef ref) async {
  final success = await UserRepository.signUp(username, password);
  if (success) {
    ref.read(authProvider.notifier).state = username;
  }
  return success;
}
