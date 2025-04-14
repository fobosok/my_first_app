import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  String _result = '';
  int _counter = 0;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            tooltip: 'Сменить тему',
            onPressed: () {
              final controller = Provider.of<ThemeController>(context, listen: false);
              controller.toggleTheme();
            }
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Введите что-то',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _result = _textController.text;
                });
              },
              child: const Text('Показать введённое'),
            ),
            const SizedBox(height: 24),
            Text('Вы ввели: $_result'),
          ],
        ),
      ),

    );
  }
}