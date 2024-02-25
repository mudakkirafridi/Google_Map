import 'package:flutter/material.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  bool iscolor1 = false;
  bool iscolor2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("2 button example"),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              if (iscolor1) {
                iscolor1 = false;
              } else {
                iscolor1 = true;
              }

              setState(() {});
            },
            child: Container(
              height: 50,
              decoration:
                  BoxDecoration(color: iscolor1 ? Colors.blue : Colors.red),
              child: Center(
                child: Text('button 1'),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              if (iscolor2) {
                iscolor2 = false;
              } else {
                iscolor2 = true;
              }

              setState(() {});
            },
            child: Container(
              height: 50,
              decoration:
                  BoxDecoration(color: iscolor2 ? Colors.blue : Colors.red),
              child: Center(
                child: Text('button 2'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
