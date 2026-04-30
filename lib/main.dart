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
      // Keep the AppBar as is
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
      body: Stack(
        children: [
          // 1. The Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background_female.jpg',
                ), // Replace with your path
                fit: BoxFit.cover, // This makes it fill the whole screen
              ),
            ),
          ),

          // 2. An optional Overlay (to make text more readable)
          Container(color: Colors.white.withOpacity(0.8)),

          // 3. Your Original Content
          // Mathe Karteikarten Widget
          const MenuButton(
            label: 'Mathe Karteikarten',
            icon: Icons.style_outlined,
            destination: TopicSelectionScreen(),
          ),

          //Center(
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       'Willkommen!',
          //       style: TextStyle(
          //         fontSize: 32,
          //         fontWeight: FontWeight.bold,
          //         color: myBlue,
          //       ),
          //     ),
          //     const SizedBox(height: 12),
          //     Text(
          //       'Was möchtest du heute lernen?',
          //       style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          //     ),
          //     const SizedBox(height: 48),
          //     ElevatedButton.icon(
          //       onPressed: () => Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (_) => const TopicSelectionScreen(),
          //         ),
          //       ),
          //       icon: const Icon(Icons.style_outlined),
          //       label: const Text(
          //         'Mathe Karteikarten',
          //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //       ),
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: myBlue,
          //         foregroundColor: myOrange,
          //         padding: const EdgeInsets.symmetric(
          //           horizontal: 32,
          //           vertical: 16,
          //         ),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(16),
          //         ),
          //         elevation: 6,
          //       ),
          //     ),
          //   ],
          // ),
          //),
        ],
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

// ─── CARD DATA ────────────────────────────────────────────────────────────────

const Map<String, List<Map<String, String>>> topicCards = {
  'Analysis': [
    {
      'question': 'Was ist die Ableitung von f(x) = x²?',
      'answer': r"f'(x) = 2x",
    },
    {
      'question': 'Was ist die Ableitung von f(x) = sin(x)?',
      'answer': r"f'(x) = \cos(x)",
    },
    {
      'question': 'Was ist das Integral von f(x) = 2x?',
      'answer': r'\int 2x\,dx = x^2 + C',
    },
  ],
  'Geometrie': [
    {
      'question': 'Wie lautet die Formel für die Kreisfläche?',
      'answer': r'A = \pi r^2',
    },
    {
      'question': 'Wie berechnet man den Umfang eines Kreises?',
      'answer': r'U = 2\pi r',
    },
    {
      'question': 'Wie lautet die Formel für das Volumen einer Kugel?',
      'answer': r'V = \frac{4}{3}\pi r^3',
    },
  ],
  'Stochastik': [
    {
      'question':
          'Was ist die Wahrscheinlichkeit eines Ereignisses A in einem Laplace-Experiment?',
      'answer': r'P(A) = \frac{\text{günstig}}{\text{möglich}}',
    },
    {
      'question': 'Wie lautet die Binomialformel für P(X = k)?',
      'answer': r'P(X=k) = \binom{n}{k} p^k (1-p)^{n-k}',
    },
    {
      'question': 'Was ist der Erwartungswert einer Binomialverteilung?',
      'answer': r'E(X) = n \cdot p',
    },
  ],
  'Grundlagen': [
    {
      'question': 'Wie lautet der Satz des Pythagoras?',
      'answer': r'a^2 + b^2 = c^2',
    },
    {
      'question': 'Wie lautet die Mitternachtsformel?',
      'answer': r'x_{1,2} = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}',
    },
    {
      'question': 'Was ist der Logarithmus zur Basis 10 von 1000?',
      'answer': r'\log_{10}(1000) = 3',
    },
  ],
};

List<Map<String, String>> getCardsForTopic(String topic) {
  if (topic == 'Gemischt') {
    final all = topicCards.values.expand((cards) => cards).toList();
    all.shuffle(Random());
    return all;
  }
  return List.from(topicCards[topic] ?? []);
}

// ─── SESSION RESULT ───────────────────────────────────────────────────────────

class SessionResult {
  final int total;
  final int known;
  final int unknown;
  final int maxStreak;

  const SessionResult({
    required this.total,
    required this.known,
    required this.unknown,
    required this.maxStreak,
  });
}

// ─── FLASHCARD SCREEN ─────────────────────────────────────────────────────────

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

  // Scoring
  int _knownCount = 0;
  int _unknownCount = 0;
  int _currentStreak = 0;
  int _maxStreak = 0;

  final Color myBlue = const Color(0xFF264358);
  final Color myOrange = const Color(0xFFF5AC26);
  final Color myGreen = const Color(0xFF2E7D32);
  final Color myRed = const Color(0xFFC62828);

  @override
  void initState() {
    super.initState();
    _cards = getCardsForTopic(widget.topic);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
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
    setState(() => _isFront = !_isFront);
  }

  void _rate(bool known) {
    setState(() {
      if (known) {
        _knownCount++;
        _currentStreak++;
        if (_currentStreak > _maxStreak) _maxStreak = _currentStreak;
      } else {
        _unknownCount++;
        _currentStreak = 0;
      }

      final isLast = _currentIndex == _cards.length - 1;
      if (isLast) {
        // Navigate to stats screen
        final result = SessionResult(
          total: _cards.length,
          known: _knownCount,
          unknown: _unknownCount,
          maxStreak: _maxStreak,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => StatsScreen(topic: widget.topic, result: result),
          ),
        );
      } else {
        _currentIndex++;
        _isFront = true;
        _controller.reset();
      }
    });
  }

  void _goHome(BuildContext context) =>
      Navigator.popUntil(context, (route) => route.isFirst);

  @override
  Widget build(BuildContext context) {
    final card = _cards[_currentIndex];
    final progress = (_currentIndex + 1) / _cards.length;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ── Score & Streak Row ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatChip(
                  icon: Icons.check_circle,
                  label: '$_knownCount',
                  color: myGreen,
                ),
                _StatChip(
                  icon: Icons.local_fire_department,
                  label: '$_currentStreak',
                  color: myOrange,
                ),
                _StatChip(
                  icon: Icons.cancel,
                  label: '$_unknownCount',
                  color: myRed,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ── Progress Bar ──
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.topic,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: myBlue,
                      ),
                    ),
                    Text(
                      '${_currentIndex + 1} / ${_cards.length}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor: Colors.grey[400],
                    valueColor: AlwaysStoppedAnimation<Color>(myOrange),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Hint ──
            Text(
              _isFront
                  ? 'Tippe auf die Karte zum Umdrehen'
                  : 'Kanntest du die Antwort?',
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),

            const SizedBox(height: 20),

            // ── Flashcard ──
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

            // ── Know / Don't Know Buttons (only after flip) ──
            AnimatedOpacity(
              opacity: _isFront ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: IgnorePointer(
                ignoring: _isFront,
                child: Row(
                  children: [
                    Expanded(
                      child: _RatingButton(
                        label: 'Nicht gewusst',
                        icon: Icons.close,
                        color: myRed,
                        onPressed: () => _rate(false),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _RatingButton(
                        label: 'Gewusst!',
                        icon: Icons.check,
                        color: myGreen,
                        onPressed: () => _rate(true),
                      ),
                    ),
                  ],
                ),
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
          fontSize: 20,
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
          textStyle: TextStyle(fontSize: 28, color: myBlue),
        ),
      ),
    );
  }

  Widget _cardWrapper({required Color backgroundColor, required Widget child}) {
    return Container(
      width: double.infinity,
      height: 200,
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

// ─── HELPER WIDGETS ───────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _RatingButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
      ),
    );
  }
}

// ─── STATS SCREEN ─────────────────────────────────────────────────────────────

class StatsScreen extends StatelessWidget {
  final String topic;
  final SessionResult result;

  const StatsScreen({super.key, required this.topic, required this.result});

  final Color myBlue = const Color(0xFF264358);
  final Color myOrange = const Color(0xFFF5AC26);
  final Color myGreen = const Color(0xFF2E7D32);
  final Color myRed = const Color(0xFFC62828);

  void _goHome(BuildContext context) =>
      Navigator.popUntil(context, (route) => route.isFirst);

  String get _emoji {
    final pct = result.known / result.total;
    if (pct == 1.0) return '🏆';
    if (pct >= 0.75) return '🎉';
    if (pct >= 0.5) return '👍';
    return '💪';
  }

  String get _message {
    final pct = result.known / result.total;
    if (pct == 1.0) return 'Perfekt! Alle Karten gewusst!';
    if (pct >= 0.75) return 'Sehr gut! Fast geschafft!';
    if (pct >= 0.5) return 'Gut gemacht! Weiter üben!';
    return 'Nicht aufgeben – Übung macht den Meister!';
  }

  @override
  Widget build(BuildContext context) {
    final knownPct = result.total > 0 ? result.known / result.total : 0.0;

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
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header ──
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: myBlue,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(_emoji, style: const TextStyle(fontSize: 42)),
                  const SizedBox(height: 6),
                  Text(
                    'Sitzung abgeschlossen!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: myOrange,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    topic,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.9),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ── Progress Bar ──
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    '${(knownPct * 100).round()}% gewusst',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: myBlue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: knownPct,
                      minHeight: 12,
                      backgroundColor: myRed.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(myGreen),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Stat Cards ──
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.check_circle,
                    value: '${result.known}',
                    label: 'Gewusst',
                    color: myGreen,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _StatCard(
                    icon: Icons.cancel,
                    value: '${result.unknown}',
                    label: 'Nicht gewusst',
                    color: myRed,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.style,
                    value: '${result.total}',
                    label: 'Karten gesamt',
                    color: myBlue,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _StatCard(
                    icon: Icons.local_fire_department,
                    value: '${result.maxStreak}',
                    label: 'Beste Serie',
                    color: myOrange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Actions ──
            ElevatedButton.icon(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => FancyMathCards(topic: topic)),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Nochmal üben',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: myBlue,
                foregroundColor: myOrange,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () => _goHome(context),
              icon: const Icon(Icons.home),
              label: const Text(
                'Zur Startseite',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: myBlue,
                side: BorderSide(color: myBlue, width: 2),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// --- stat card ----
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

// ---- Menu button ----
class MenuButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Widget destination;

  const MenuButton({
    super.key,
    required this.label,
    required this.icon,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    // Branding colors defined once here
    const Color myBlue = Color(0xFF264358);
    const Color myOrange = Color(0xFFF5AC26);

    return Center(
      // This ensures every instance is centered by default
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        icon: Icon(icon),
        label: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: myBlue,
          foregroundColor: myOrange,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
        ),
      ),
    );
  }
}
