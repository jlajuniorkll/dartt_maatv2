import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final IconData? icon;
  final String label;
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatters;
  final String? iniValue;
  final TextEditingController? controller;
  final bool isInActive;
  final TextInputType? textInputType;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool autCorrect;
  final int? maxLines;
  final GlobalKey<FormFieldState>? formFieldKey;
  final void Function(String?)? onChanged;

  const CustomTextField(
      {Key? key,
      this.icon,
      required this.label,
      this.isSecret = false,
      this.inputFormatters,
      this.iniValue,
      this.controller,
      this.isInActive = false,
      this.textInputType,
      this.onSaved,
      this.onChanged,
      this.validator,
      this.autCorrect = true,
      this.maxLines = 1,
      this.formFieldKey,
      })
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;
  @override
  void initState() {
    isObscure = widget.isSecret;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        key: widget.formFieldKey,
        readOnly: widget.isInActive,
        initialValue: widget.iniValue,
        controller: widget.controller,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.textInputType,
        obscureText: isObscure,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        validator: widget.validator,
        autocorrect: widget.autCorrect,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
            prefixIcon: Icon(widget.icon),
            suffixIcon: widget.isSecret
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: isObscure
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off))
                : null,
            labelText: widget.label,
            isDense: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
      ),
    );
  }
}
