import 'package:custom_textfield/components/custom_textfield.dart';
import 'package:custom_textfield/constants.dart';
import 'package:custom_textfield/models/field_validation_model.dart';
import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget {
  static const route = '/converter_page';

  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController outputCtrler = TextEditingController();

  String inputVal = '';

  String convert() {
    String currString = '';

    for (int i = inputVal.length - 1; i >= 0; i--) {
      final int digitCounter = inputVal.length - i;
      final inputValNum = int.parse(inputVal[i]);

      if (inputValNum == 0) {
        continue;
      }

      if (digitCounter == 1 || digitCounter % 3 == 1) {
        if(kDigitToWordMap.containsKey(digitCounter)) {
          currString = '${kDigitToWordMap[digitCounter]} $currString';
        }

        if (digitCounter < inputVal.length && int.parse(inputVal[i - 1]) == 1) {
          continue;
        }

        currString =
            '${kIntToWordMap[inputValNum]} $currString';
        continue;
      }

      if (digitCounter % 3 == 0) {
        currString = '${kIntToWordMap[inputValNum]} hundred $currString';
        continue;
      }

      if (digitCounter == 2 || digitCounter % 3 == 2) {
        if (inputValNum == 1) {
          currString =
              '${kIntToWordMap[int.parse('$inputValNum${inputVal[i + 1]}')]} $currString';
          continue;
        }

        currString = '${kIntToWordMap[inputValNum * 10]}-$currString';
        continue;
      }
    }
    return currString;
  }

  @override
  void dispose() {
    outputCtrler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text(
          'Converter app',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const Text(
              'Please enter on Integer number in the "input" box and top on "Convert" to see the equivalent in words appear in the "Output" box.',
            ),
            const SizedBox(
              height: 24,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextfield(
                    label: 'Input',
                    maxLength: 15,
                    keyboardType: TextInputType.number,
                    unallowedPatternValidators: [
                      UnallowedPatternValidatorModel(
                        r'[^0-9]',
                        'Input only accepts decimal without any fraction',
                      ),
                      UnallowedPatternValidatorModel(
                        r'^0+',
                        'Use a proper number format. Real Numbers or Scientific E Notation',
                      ),
                    ],
                    onChanged: (String val) {
                      inputVal = val;
                    },
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  CustomTextfield(
                    controller: outputCtrler,
                    label: 'Output',
                    readOnly: true,
                    minLines: 3,
                    maxLines: null,
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        // setState(() {
                        outputCtrler.text = convert();
                        // });
                      }
                      return;
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      child: const Text(
                        'Convert',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
