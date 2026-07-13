import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'core/database/isar_service.dart';
import 'features/dashboard/presentation/screens/dashboard_screen.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerSingleton<IsarService>(IsarService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<IsarService>(
      create: (context) => getIt<IsarService>(),
      child: MaterialApp(
        title: 'Lista Fácil',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            primary: Colors.indigo,
            secondary: Colors.indigoAccent,
          ),
        ),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.system, // Alterna automaticamente conforme o sistema do usuário
        home: const DashboardScreen(),
      ),
    );
  }
}
