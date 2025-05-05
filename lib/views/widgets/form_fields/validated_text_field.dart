import 'package:flutter/material.dart';

class ValidatedTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final Future<bool> Function(String) validateCode;

  const ValidatedTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.validateCode,
    this.readOnly = false,
  });

  @override
  ValidatedTextFieldState createState() => ValidatedTextFieldState();
}

class ValidatedTextFieldState extends State<ValidatedTextField> {
  IconData? _icon;
  Color? _iconColor;
  bool _isLoading = false;

  void _validate() async {
    setState(() {
      _isLoading = true;
      _icon = Icons.hourglass_top;
      _iconColor = Colors.grey;
    });

    bool isValid = await widget.validateCode(widget.controller.text);

    setState(() {
      _isLoading = false;
      if (isValid) {
        _icon = Icons.check_circle;
        _iconColor = Colors.green;
      } else {
        _icon = Icons.error;
        _iconColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: '${widget.label} Girin',
        suffixIcon: _isLoading
            ? Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircularProgressIndicator(strokeWidth: 2),
        )
            : IconButton(
          icon: Icon(_icon ?? Icons.help_outline),
          color: _iconColor ?? Colors.grey,
          onPressed: _validate,
        ),
      ),
    );
  }
}