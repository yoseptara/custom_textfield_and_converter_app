import 'package:custom_textfield/components/custom_textfield.dart';
import 'package:flutter/material.dart';

class CustomTextfieldDemoPage extends StatefulWidget {
  static const route = '/custom_textfield_demo_page';

  const CustomTextfieldDemoPage({super.key});

  @override
  State<CustomTextfieldDemoPage> createState() => _CustomTextfieldDemoPageState();
}

class _CustomTextfieldDemoPageState extends State<CustomTextfieldDemoPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade800,
        title: const Text(
          'Custom Textfield Demo',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const CustomTextfield(
                label: 'Username',
                prefixIcon: Icon(
                  Icons.person_2,
                  size: 24,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextButton(
                onPressed: () {
                  if (formKey.currentState?.validate() == true) {
                    print('form has been submitted');
                  }
                  return;
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  backgroundColor: Colors.red.shade800,
                ),
                child: const SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    'Confirmation',
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
      ),
    );
  }
}
