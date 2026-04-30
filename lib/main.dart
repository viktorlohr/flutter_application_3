import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

void main() => runApp(const MaterialApp(home: FancyMathCards()));

class FancyMathCards extends StatefulWidget {
  const FancyMathCards({super.key});

  @override
  State<FancyMathCards> createState() => _FancyMathCardsState();
}

class _FancyMathCardsState extends State<FancyMathCards>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  // Define our color palette
  final Color myBlue = const Color(0xFF264358);
  final Color myOrange = const Color(0xFFF5AC26);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );
  }

  void _flipCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[300], // Slightly darker background to make white card pop
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: Image.asset(
            'assets/images/akademus_logo.jpg',
            height: 80,
            fit: BoxFit.contain,
          ),
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.white, // White background to match the logo
        foregroundColor: myOrange,
      ),
      body: Center(
        child: GestureDetector(
          onTap: _flipCard,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final angle = _animation.value * pi;
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle),
                alignment: Alignment.center,
                // Logic to switch between the two widgets at the 90-degree mark
                child: angle < pi / 2 ? _buildFront() : _buildBack(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFront() {
    return _cardWrapper(
      backgroundColor: myBlue, // Navy Blue Background
      child: Text(
        "Wie lautet die Formel für die Kreisfläche?",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: myOrange, // Orange Font
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBack() {
    // We flip the back content so it's not mirrored
    return Transform(
      transform: Matrix4.identity()..rotateY(pi),
      alignment: Alignment.center,
      child: _cardWrapper(
        backgroundColor: Colors.white, // White Background
        child: Math.tex(
          // Use Navy Blue for the math symbols
          r'{A = \pi r^2}',
          textStyle: TextStyle(fontSize: 40, color: myBlue),
        ),
      ),
    );
  }

  // Updated wrapper to accept a background color
  Widget _cardWrapper({required Color backgroundColor, required Widget child}) {
    return Container(
      width: 320,
      height: 220,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: const Center(child: Text("Welcome to Akademus!")),
    );
  }
}
