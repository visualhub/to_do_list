import 'package:flutter/material.dart';

class AddTextDialog extends StatefulWidget {
  const AddTextDialog({
    super.key,
    this.text = '',
    required this.onAddToList,
  });

  final String text;
  final Function onAddToList;

  @override
  State<AddTextDialog> createState() => _AddTextDialogState();
}

class _AddTextDialogState extends State<AddTextDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.text);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 300,
        width: 250,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: 10,
                  autofocus: true,
                  controller: _controller,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  widget.onAddToList(_controller.text);
                  Navigator.pop(context);
                } else {
                  debugPrint('Text is empty! 💀');
                }
              },
              child: Text(widget.text.isEmpty ? 'Add To List' : 'Update Item'),
            ),
          ],
        ),
      ),
    );
  }
}
