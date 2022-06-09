import 'package:debounce_textfield/debounce_textfield.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Debounce Textfield Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> example1() => [
        const Text('Default'),
        DebounceTextfield(
          action: (enteredText) {
            print('Executed after 500 milliseconds from last change.');
            print(enteredText);
          },
        ),
      ];

  List<Widget> example2() => [
        const Text('Custom Duration'),
        DebounceTextfield(
          action: (enteredText) {
            print('Executed after 800 milliseconds from last change.');
            print(enteredText);
          },
          duration: const Duration(milliseconds: 800),
        ),
      ];

  List<Widget> example3() => [
        const Text('onTextfieldEmpty Callback'),
        DebounceTextfield(
          action: (enteredText) {
            print('Executed after 500 milliseconds from last change.');
            print(enteredText);
          },
          onTextfieldEmpty: () {
            print('Textfield is empty now...');
          },
        ),
      ];

  List<Widget> example4() => [
        const Text('Custom Style'),
        DebounceTextfield(
          action: (enteredText) {
            print('Executed after 500 milliseconds from last change.');
            print(enteredText);
          },
          height: 50,
          clearButtonIcon:
              const Icon(Icons.clear_rounded, color: Colors.white, size: 20),
          textFieldDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.indigo.shade200,
          ),
          inputDecoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search for your favoutie Anime',
            hintStyle: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 20,
            ),
          ),
          textFieldStyle: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ];

  List<Widget> example5() => [
        const Text('Right to left Direction'),
        DebounceTextfield(
          action: (enteredText) {
            print('Executed after 500 milliseconds from last change.');
            print(enteredText);
          },
          direction: TextDirection.rtl,
          inputDecoration: const InputDecoration.collapsed(
            hintText: 'أدخل النص هنا',
            hintStyle: TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
          textFieldDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black12,
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debounce Textfield Demo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ...example1(),
              ...example2(),
              ...example3(),
              ...example4(),
              ...example5()
            ],
          ),
        ),
      ),
    );
  }
}
