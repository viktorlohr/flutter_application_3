import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

void main() => runApp(const MaterialApp(home: HomeScreen()));

// ─── HOME SCREEN ─────────────────────────────────────────────────────────────

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final Color myBlue = const Color(0xFF264358);
  final Color myOrange = const Color(0xFFF5AC26);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Image.asset(
          'assets/images/akademus_logo.jpg',
          height: 80,
          fit: BoxFit.contain,
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        foregroundColor: myOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Willkommen!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: myBlue,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Was möchtest du heute lernen?',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TopicSelectionScreen()),
              ),
              icon: const Icon(Icons.style_outlined),
              label: const Text(
                'Mathe Karteikarten',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: myBlue,
                foregroundColor: myOrange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── TOPIC SELECTION SCREEN ───────────────────────────────────────────────────

class TopicSelectionScreen extends StatelessWidget {
  const TopicSelectionScreen({super.key});

  final Color myBlue = const Color(0xFF264358);
  final Color myOrange = const Color(0xFFF5AC26);

  static const List<Map<String, dynamic>> _topics = [
    {'label': 'Analysis', 'icon': Icons.show_chart},
    {'label': 'Geometrie', 'icon': Icons.square_foot},
    {'label': 'Stochastik', 'icon': Icons.bar_chart},
    {'label': 'Grundlagen', 'icon': Icons.functions},
    {'label': 'Gemischt', 'icon': Icons.shuffle},
  ];

  void _goHome(BuildContext context) =>
      Navigator.popUntil(context, (route) => route.isFirst);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => _goHome(context),
          child: Image.asset(
            'assets/images/akademus_logo.jpg',
            height: 80,
            fit: BoxFit.contain,
          ),
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        foregroundColor: myOrange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _goHome(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thema wählen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: myBlue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Wähle ein Thema, um mit den Karteikarten zu beginnen.',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 28),
            // 2-column grid for first 4 topics
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.6,
              children: _topics
                  .take(4)
                  .map(
                    (t) => _TopicCard(
                      label: t['label'],
                      icon: t['icon'],
                      myBlue: myBlue,
                      myOrange: myOrange,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            // "Gemischt" spans full width
            _TopicCard(
              label: _topics[4]['label'],
              icon: _topics[4]['icon'],
              myBlue: myBlue,
              myOrange: myOrange,
              fullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color myBlue;
  final Color myOrange;
  final bool fullWidth;

  const _TopicCard({
    required this.label,
    required this.icon,
    required this.myBlue,
    required this.myOrange,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final card = GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => FancyMathCards(topic: label)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: myBlue,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: myOrange, size: 28),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: myOrange,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    return fullWidth ? SizedBox(width: double.infinity, child: card) : card;
  }
}

// ─── FLASHCARD SCREEN ─────────────────────────────────────────────────────────

// ─── FLASHCARD SCREEN ─────────────────────────────────────────────────────────

// Define the card pools outside the class
const Map<String, List<Map<String, String>>> topicCards = {
  'Analysis': [
    {
      'question': 'Was ist die Ableitung von f(x) = x²?',
      'answer': r"f'(x) = 2x",
    },
  ],
  'Geometrie': [
    {
      'question': 'Wie lautet die Formel für die Kreisfläche?',
      'answer': r'A = \pi r^2',
    },
  ],
  'Stochastik': [
    {
      'question':
          'Was ist die Wahrscheinlichkeit eines Ereignisses A in einem Laplace-Experiment?',
      'answer': r'P(A) = \frac{\text{günstig}}{\text{möglich}}',
    },
  ],
  'Grundlagen': [
    {
      'question': 'Wie lautet der Satz des Pythagoras?',
      'answer': r'a^2 + b^2 = c^2',
    },
  ],
};

List<Map<String, String>> getCardsForTopic(String topic) {
  if (topic == 'Gemischt') {
    // Combine all pools
    return topicCards.values.expand((cards) => cards).toList();
  }
  return topicCards[topic] ?? [];
}

class FancyMathCards extends StatefulWidget {
  final String topic;
  const FancyMathCards({super.key, required this.topic});

  @override
  State<FancyMathCards> createState() => _FancyMathCardsState();
}

class _FancyMathCardsState extends State<FancyMathCards>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late List<Map<String, String>> _cards;
  int _currentIndex = 0;
  bool _isFront = true;

  final Color myBlue = const Color(0xFF264358);
  final Color myOrange = const Color(0xFFF5AC26);

  @override
  void initState() {
    super.initState();
    _cards = getCardsForTopic(widget.topic);
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

  void _nextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _cards.length;
      _isFront = true;
      _controller.reset();
    });
  }

  void _goHome(BuildContext context) =>
      Navigator.popUntil(context, (route) => route.isFirst);

  @override
  Widget build(BuildContext context) {
    final card = _cards[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => _goHome(context),
          child: Image.asset(
            'assets/images/akademus_logo.jpg',
            height: 80,
            fit: BoxFit.contain,
          ),
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        foregroundColor: myOrange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.topic,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: myBlue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tippe auf die Karte zum Umdrehen',
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            GestureDetector(
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
                    child: angle < pi / 2
                        ? _buildFront(card['question']!)
                        : _buildBack(card['answer']!),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _nextCard,
              icon: const Icon(Icons.arrow_forward),
              label: const Text(
                'Nächste Karte',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: myBlue,
                foregroundColor: myOrange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFront(String question) {
    return _cardWrapper(
      backgroundColor: myBlue,
      child: Text(
        question,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: myOrange,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBack(String answer) {
    return Transform(
      transform: Matrix4.identity()..rotateY(pi),
      alignment: Alignment.center,
      child: _cardWrapper(
        backgroundColor: Colors.white,
        child: Math.tex(
          answer,
          textStyle: TextStyle(fontSize: 30, color: myBlue),
        ),
      ),
    );
  }

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
