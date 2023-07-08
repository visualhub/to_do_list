import 'package:flutter/material.dart';
import 'package:to_do_list/database/database.dart';
import 'package:to_do_list/widgets/add_text_dialog.dart';

import '../widgets/item_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List _list;

  void _addToList(String text) {
    setState(() {
      _list.add({
        'text': text,
        'checked': false,
      });
    });
    db.updateTodoList(_list);
  }

  void _changeChecked(int index, bool newValue) {
    setState(() {
      _list[index]['checked'] = newValue;
    });
    db.updateTodoList(_list);
  }

  void _updateValue(int index, String newValue) {
    setState(() {
      _list[index]['text'] = newValue;
    });
    db.updateTodoList(_list);
  }

  void _deleteFromList(int index) {
    setState(() {
      _list.removeAt(index);
    });
    db.updateTodoList(_list);
  }

  @override
  void initState() {
    _list = db.getTodoItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'To Do List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'This week',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddTextDialog(
                                onAddToList: _addToList,
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Row(
                            children: const [
                              Text(
                                'Add Task',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 163, 8, 8),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                    ),
                  ),
                  child: _list.isNotEmpty
                      ? ListView(
                          children: [
                            const SizedBox(height: 25),
                            for (int i = 0; i < _list.length; i++)
                              ItemBar(
                                text: _list[i]['text'],
                                checked: _list[i]['checked'],
                                onDelete: () => _deleteFromList(i),
                                onCheckBoxPressed: (value) =>
                                    _changeChecked(i, value),
                                onEdit: (() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddTextDialog(
                                        text: _list[i]['text'],
                                        onAddToList: (String value) {
                                          _updateValue(i, value);
                                        },
                                      );
                                    },
                                  );
                                }),
                              ),
                            // for (Map item in _list)
                            //   ItemBar(
                            //     text: item['text'],
                            //     checked: item['checked'],
                            //   ),
                          ],
                        )
                      : const Center(
                          child: Text(
                            'No Item',
                          ),
                        ),
                ),
              ),
            ],
          ),
        ));
  }
}
