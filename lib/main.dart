import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

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
  // State control variables
  bool isDarkMode = false;
  bool loading = false;
  double cadquotation = 0.0;
  String firstCurrency = 'BRL';
  String secondCurrency = 'CAD';
  double digitedValue = 0.0;
  double result = 0.0;

  // Controller to capture the TextField input text
  final TextEditingController inputController = TextEditingController();

  // Color palette constants
  final Color backgroundColorDarkMode = const Color(0xFF121212);
  final Color backgroundColorWhiteMode = const Color(0xFFE0E0E0);
  final Color textColorDarkMode = const Color(0xFFE0E0E0);
  final Color textColorWhiteMode = const Color(0xFF121212);

  // Function responsible for calculation logic based on selected currencies
  void calcularConversao() {
    if (firstCurrency == 'BRL') {
      result = digitedValue * cadquotation;
    } else {
      result = digitedValue / cadquotation;
    }
  }

  // Asynchronous function to fetch live quotation from API
  Future<void> getQuotation() async {
    setState(() {
      loading = true;
    });

    final Uri urlquotation = Uri.parse(
      'https://economia.awesomeapi.com.br/json/last/BRL-CAD',
    );

    try {
      final http.Response response = await http.get(urlquotation);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String valueText = data['BRLCAD']['bid'];

        setState(() {
          cadquotation = double.parse(valueText);
          loading = false;
        });
      } else {
        throw Exception('Error while loading the API');
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getQuotation();
  }

  @override
  Widget build(BuildContext context) {
    // Defines the dynamic color based on the current mode to reuse in TextFields
    final Color currentTextColor = isDarkMode
        ? textColorDarkMode
        : textColorWhiteMode;
    final Color currentBorderColor = isDarkMode
        ? Colors.white30
        : Colors.black38;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        color: isDarkMode ? backgroundColorDarkMode : backgroundColorWhiteMode,
        child: Column(
          children: [
            // Header section
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
                    const Icon(Icons.blur_on, color: Colors.transparent),
                  ],
                ),
              ),
            ),

            // Central card section (Main body)
            Expanded(
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  width: 380,
                  height: 240,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? backgroundColorDarkMode
                        : backgroundColorWhiteMode,
                    border: Border.all(
                      color: isDarkMode ? Colors.white24 : Colors.black,
                      width: .75,
                    ),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Currencies display and swap row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            firstCurrency,
                            style: TextStyle(
                              color: currentTextColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                final temp = firstCurrency;
                                firstCurrency = secondCurrency;
                                secondCurrency = temp;
                                calcularConversao();
                              });
                            },
                            icon: const Icon(Icons.swap_horiz),
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            secondCurrency,
                            style: TextStyle(
                              color: currentTextColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // Inputs and results row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // First field: Input where user types the amount
                          SizedBox(
                            width: 125,
                            child: TextField(
                              controller: inputController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: currentTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                hintText: '0.00',
                                hintStyle: const TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: currentBorderColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: currentTextColor,
                                  ),
                                ),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  digitedValue = double.tryParse(text) ?? 0.0;
                                  calcularConversao();
                                });
                              },
                            ),
                          ),

                          const SizedBox(width: 15),

                          Icon(
                            Icons.arrow_forward,
                            color: isDarkMode ? Colors.white54 : Colors.black54,
                          ),

                          const SizedBox(width: 15),

                          // Second field: Displays the conversion result (ReadOnly)
                          SizedBox(
                            width: 125,
                            child: loading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : TextField(
                                    textAlign: TextAlign.center,
                                    readOnly: true,
                                    style: TextStyle(
                                      color: currentTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: result.toStringAsFixed(2),
                                      hintStyle: TextStyle(
                                        color: currentTextColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: currentBorderColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: currentBorderColor,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button for Dark/Light mode toggle
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

// Function to handle opening the GitHub profile URL externally
Future<void> _launchURLGithub() async {
  final Uri url = Uri.parse('https://github.com/tiagotodescatto');
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}
