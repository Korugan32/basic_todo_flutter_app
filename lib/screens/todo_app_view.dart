import 'package:flutter/material.dart';

class TodoAppView extends StatefulWidget {
  const TodoAppView({super.key});

  @override
  State<TodoAppView> createState() => _TodoAppViewState();
}

class _TodoAppViewState extends State<TodoAppView> {
  List<TodoModel> list = [];
  final String _title = 'Todo App';
  String _input = "";
  final TextEditingController _controller = TextEditingController();
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(controller: _controller, onChanged: _setInput, decoration: _textFieldDecoration()),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return TodoCard(
                      model: list[index],
                      onChanged: (newValue) {
                        setState(() {
                          list[index].isDone = newValue!;
                        });
                      },
                      onDelete: (){
                        setState(() {
                          list.removeAt(index);
                        });
                      }
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _textFieldDecoration() {
    return InputDecoration(
      prefixIcon: Icon(Icons.text_increase_rounded),
      suffixIcon: IconButton(onPressed: _onAddClick, icon: Icon(Icons.add)),
    );
  }

  void _onAddClick() {
    setState(() {
      list.add(TodoModel(name: _input));
      _input = "";
      _controller.clear();
    });
  }

  void _setInput(value) {
    setState(() {});
    _input = value;
  }
}

class TodoCard extends StatelessWidget {
  const TodoCard({super.key, required this.model, required this.onChanged, required this.onDelete,});

  final TodoModel model;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TodoText(model: model),
            Row(
              children: [
                Checkbox(value: model.isDone, onChanged: onChanged),
                IconButton(onPressed: onDelete, icon: Icon(Icons.delete_outline_outlined, color: Colors.red,))
              ]
            )
          ],
        ),
      ),
    );
  }
}

class TodoText extends StatelessWidget {
  const TodoText({super.key, required this.model});

  final TodoModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        model.name,
        style: TextStyle(decoration: model.isDone ? TextDecoration.lineThrough : TextDecoration.none),
      ),
    );
  }
}

class TodoModel {
  final String name;
  bool isDone = false;
  TodoModel({required this.name});
}
