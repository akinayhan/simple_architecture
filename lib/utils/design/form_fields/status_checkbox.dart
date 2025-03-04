import 'package:flutter/material.dart';

class StatusCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String textName;
  final bool readOnly;

  const StatusCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.textName,
    this.readOnly = false,
  });

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
          Text(
            '$textName : ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(width: 10),
          Checkbox(
            value: value,
            onChanged: readOnly ? null : onChanged,
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
