import 'package:custom_textfield/constants.dart';
import 'package:custom_textfield/models/field_validation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    this.readOnly = false,
    this.unallowedPatternValidators = const [],
    this.prefixIcon,
    this.maxLength,
    this.onChanged,
    this.controller,
    this.keyboardType,
    required this.label,
  });

  final String label;
  final bool readOnly;
  final List<UnallowedPatternValidatorModel> unallowedPatternValidators;
  final Widget? prefixIcon;
  final int? maxLength;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();

  late String errorMsg = '${widget.label} cannot be empty';

  bool isTooltipShown = false;

  void toggleTooltip() {
    if (isTooltipShown) {
      dismissTooltip();
    } else {
      showTooltip();
    }
  }

  String? validate(String? value) {
    if (value != null) {
      //Default validation
      if (value.isEmpty) {
        updateErrorMsg('${widget.label} cannot be empty');
        showTooltip();
        return '';
      }

      //Custom validation
      for (UnallowedPatternValidatorModel validation in widget.unallowedPatternValidators) {
        if (RegExp(validation.pattern).hasMatch(value)) {
          updateErrorMsg(validation.errorMsg);
          showTooltip();
          return '';
        }
      }
    }

    if (isTooltipShown) {
      dismissTooltip();
    }

    return null;
  }

  void updateErrorMsg(String value) {
    if (errorMsg != value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          errorMsg = value;
        });
      });
    }
  }

  void dismissTooltip() {
    isTooltipShown = false;
    Tooltip.dismissAllToolTips();
  }

  void showTooltip() {
    isTooltipShown = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tooltipKey.currentState?.ensureTooltipVisible();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            widget.label,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextFormField(
              controller: widget.controller,
              onChanged: widget.onChanged,
              maxLength: widget.maxLength,
              readOnly: widget.readOnly,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.readOnly == false ? validate : null,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                prefixIcon: widget.prefixIcon,
                hintText: widget.label,
                hintStyle: const TextStyle(color: Colors.grey),
                border: kDefaultInputBorder,
                focusedBorder: kDefaultInputBorder,
                errorBorder: widget.readOnly == false
                    ? OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.shade800),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      )
                    : null,
                errorStyle: widget.readOnly == false
                    ? const TextStyle(fontSize: 0, height: 0): null,
              ),
            ),
            if (widget.readOnly == false)
              GestureDetector(
                onTap: toggleTooltip,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Tooltip(
                    key: tooltipKey,
                    showDuration: const Duration(milliseconds: 0),
                    preferBelow: false,
                    triggerMode: TooltipTriggerMode.manual,
                    message: errorMsg,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Colors.red.shade800,
                    ),
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.info,
                      size: 24,
                      color: Colors.red.shade800,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
