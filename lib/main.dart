import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/data_page.dart';
import 'screens/contact_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        // custom color scheme
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
            primary: Color(0xFF004D40), // dark green
            onPrimary: Colors.white,
            secondary: Color(0xFF626058), // greyish color
          onSecondary: Colors.white,
          error: Color(0xFFB00020),
          onError: Colors.white,
          surface: Color(0xFFFFFFFF),
          onSurface: Colors.black,
        ),
        // custom text theme
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.0,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.0,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        // dark theme color scheme
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF69F0AE), // light green
          onPrimary: Colors.black,
            secondary: Color(0xFF004D40), // dark green
          onSecondary: Colors.black,
          error: Color(0xFFB00020),
          onError: Colors.black,
          surface: Color(0xFF1E1E1E),
          onSurface: Colors.white,
        ),
        // inheriting the same text theme with adjusted colors for dark mode
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.0,
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.0,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
            color: Colors.white,
          ),
        ),
      ),
      themeMode: ThemeMode.system, //system decide between light and dark
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        const HomePage(),
        const DataPage(),
        const ContactPage(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.data_array),
            label: 'Data',
          ),
          NavigationDestination(
            icon: Icon(Icons.contact_page),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}
