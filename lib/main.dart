import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Rubik'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isDarkMode = false;
  final Color backgroundColorDarkMode = const Color(0xFF121212);
  final Color backgroundColorWhiteMode = const Color(0xFFE0E0E0);
  final Color textColorDarkMode = const Color(0xFFE0E0E0);
  final Color textColorWhiteMode = const Color(0xFF121212);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        color: isDarkMode ? backgroundColorDarkMode : backgroundColorWhiteMode,
        child: Column(
          children: [
            //  header
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: 65,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: isDarkMode
                        ? [backgroundColorDarkMode, backgroundColorWhiteMode]
                        : [backgroundColorWhiteMode, backgroundColorDarkMode],
                  ),
                  border: Border.all(
                    color: isDarkMode ? Colors.white10 : Colors.black12,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _launchURLGithub,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            'https://avatars.githubusercontent.com/u/287279083?v=4',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'BRL to CAD Converter',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Icon(Icons.blur_on, color: Colors.transparent),
                  ],
                ),
              ),
            ),

            // central card (main body)
            Expanded(
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  width: 720,
                  height: 480,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? backgroundColorDarkMode
                        : backgroundColorWhiteMode,
                    border: Border.all(color: Colors.black, width: .75),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'La ele mil vezes',
                        style: TextStyle(
                          color: isDarkMode
                              ? textColorDarkMode
                              : textColorWhiteMode,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // dark mode button
      floatingActionButton: FloatingActionButton(
        child: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
        onPressed: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}

Future<void> _launchURLGithub() async {
  final Uri url = Uri.parse('https://github.com/tiagotodescatto');
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}
