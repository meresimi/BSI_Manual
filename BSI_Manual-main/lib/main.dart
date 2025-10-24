\
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'pages/calculator_page.dart';
import 'pages/rates_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/about_page.dart';
import 'services/rate_service.dart';
import 'services/db_service.dart';
import 'services/calculator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await DbService.create();
  final rates = await RateService.loadFromAssets('assets/data/rates.json');
  runApp(BsiApp(dbService: db, rateService: rates));
}

class BsiApp extends StatelessWidget {
  final DbService dbService;
  final RateService rateService;
  const BsiApp({super.key, required this.dbService, required this.rateService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DbService>.value(value: dbService),
        Provider<RateService>.value(value: rateService),
        ChangeNotifierProvider(create: (_) => CalculatorService(rateService)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BSI Manual',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2C7BE5)),
          useMaterial3: true,
          cardTheme: const CardTheme(
            elevation: 1.5,
            margin: EdgeInsets.all(8),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/calculator': (context) => const CalculatorPage(),
          '/rates': (context) => const RatesPage(),
          '/dashboard': (context) => const DashboardPage(),
          '/about': (context) => const AboutPage(),
        },
      ),
    );
  }
}
