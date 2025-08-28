import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider.dart';
import '../provider/counter_provider.dart';
import 'login_page.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.read(authProvider)!; 
    final counter = ref.watch(counterProvider(username));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Counter - $username'),
        actions: [
          IconButton(
            tooltip: "Logout",
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await logout(ref);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Logged out")),
              );
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 8,
                shadowColor: theme.colorScheme.primary.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40.0,
                    horizontal: 48.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Counter Value',
                        style: theme.textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(scale: animation, child: child),
                        child: Text(
                          '$counter',
                          key: ValueKey(counter),
                          style: theme.textTheme.displayMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Wrap(
                spacing: 20,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add, color: Colors.green),
                    label: const Text('Increment',
                        style: TextStyle(color: Colors.green)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                    ),
                    onPressed: () =>
                        ref.read(counterProvider(username).notifier).increment(),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.remove, color: Colors.red),
                    label: const Text('Decrement',
                        style: TextStyle(color: Colors.red)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                    ),
                    onPressed: () =>
                        ref.read(counterProvider(username).notifier).decrement(),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      backgroundColor: theme.colorScheme.secondary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () =>
                        ref.read(counterProvider(username).notifier).reset(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
