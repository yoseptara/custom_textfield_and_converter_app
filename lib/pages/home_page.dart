import 'package:custom_textfield/pages/converter_page.dart';
import 'package:custom_textfield/pages/custom_textfield_demo_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const route = '/home_page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Demo',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, CustomTextfieldDemoPage.route);
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(8),
                backgroundColor: Colors.blue,
              ),
              child: const SizedBox(
                width: double.maxFinite,
                child: Text(
                  'Custom textfield demo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24,),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, ConverterPage.route);
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(8),
                backgroundColor: Colors.blue,
              ),
              child: const SizedBox(
                width: double.maxFinite,
                child: Text(
                  'Converter demo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
