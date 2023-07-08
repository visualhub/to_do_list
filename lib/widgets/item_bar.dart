import 'package:flutter/material.dart';

class ItemBar extends StatelessWidget {
  const ItemBar({
    Key? key,
    required this.text,
    required this.checked,
    required this.onDelete,
    required this.onEdit,
    required this.onCheckBoxPressed,
  }) : super(key: key);

  final String text;
  final bool checked;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final ValueChanged<bool> onCheckBoxPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue,
            Colors.grey.shade400,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Checkbox(
            value: checked,
            checkColor: Colors.black,
            activeColor: Colors.white,
            shape: const CircleBorder(),
            onChanged: (value) => onCheckBoxPressed(value!),
          ),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
