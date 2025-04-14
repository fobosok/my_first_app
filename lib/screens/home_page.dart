import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/theme_toggle_button.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _storageKey = 'saved_input';
  final TextEditingController _textController = TextEditingController();
  String _result = '';
  @override
  void initState() {
    super.initState();
    _loadInput();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _saveInput(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, value);
  }

  Future<void> _loadInput() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_storageKey) ?? '';
    setState(() {
      _result = saved;
      _textController.text = saved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          const ThemeToggleButton(),  // Используем новый виджет кнопки
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
                _saveInput(_result);
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
