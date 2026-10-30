import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: AnimationPage()));
}

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fade and Slide Animation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: show ? 1.0 : 0.0,
              duration: const Duration(seconds: 2),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text('Fade', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 30),
            AnimatedSlide(
              offset: show ? Offset.zero : const Offset(2, 0),
              duration: const Duration(seconds: 2),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.green,
                alignment: Alignment.center,
                child: const Text('Slide', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  show = !show;
                });
              },
              child: const Text('Start Animation'),
            ),
          ],
        ),
      ),
    );
  }
}
