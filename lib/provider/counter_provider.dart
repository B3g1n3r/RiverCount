import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterNotifier extends StateNotifier<int> {
  final String username;
  CounterNotifier(this.username) : super(0) {
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getInt('counter_$username') ?? 0;
  }

  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter_$username', state);
  }

  void increment() {
    state++;
    _saveCounter();
  }

  void decrement() {
    state--;
    _saveCounter();
  }

  void reset() {
    state = 0;
    _saveCounter();
  }
}

final counterProvider = StateNotifierProvider.family<CounterNotifier, int, String>(
    (ref, username) => CounterNotifier(username));
