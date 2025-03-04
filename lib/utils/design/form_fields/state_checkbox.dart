import 'package:flutter/material.dart';

class StateCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const StateCheckbox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
          ),
          Text(
            value ? 'Aktif' : 'Pasif',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}