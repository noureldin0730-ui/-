import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/map_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const AlMusahehApp());
}

class AlMusahehApp extends StatelessWidget {
  const AlMusahehApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'المصحح',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF2B1D12),
      ),
      home: const StartScreen(),
    );
  }
}

// ═══════════ الألوان — ورق وخشب ═══════════
class P {
  // خلفية خشب
  static const wood = Color(0xFF2B1D12);
  static const woodLight = Color(0xFF3D2817);
  static const woodDark = Color(0xFF1A1109);

  // ألوان الورق
  static const paperWhite = Color(0xFFF0E8D8);
  static const paperBlue = Color(0xFFD8E0E8);
  static const paperGreen = Color(0xFFDDE8D8);
  static const paperYellow = Color(0xFFF0E8C8);

  // خطوط الورق
  static const paperLine = Color(0xFFB8B0A0);
  static const paperBorder = Color(0xFF8B7355);

  // حبر
  static const ink = Color(0xFF1A1A1A);
  static const inkBlue = Color(0xFF1E3A5F);
  static const inkRed = Color(0xFF8B1A1A);
  static const inkStamp = Color(0xFF6B2C91);

  // أزرار
  static const correct = Color(0xFF27AE60);
  static const partial = Color(0xFFE9B44C);
  static const wrong = Color(0xFFC0392B);

  // نصوص
  static const dim = Color(0xFF8B7355);
  static const white = Color(0xFFF0E8D8);
}

// ═══════════ شاشة البداية — Landscape ═══════════
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _start() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MapScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: P.wood,
      body: Stack(
        children: [
          // خلفية خشب بتدرج
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [P.woodLight, P.wood, P.woodDark],
              ),
            ),
          ),

          // خطوط خشب خفيفة
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: _WoodGrainPainter(),
          ),

          SafeArea(
            child: Row(
              children: [
                // ────── الشمال: العنوان ──────
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ورقة صغيرة عليها العنوان
                        Transform.rotate(
                          angle: -0.03,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: P.paperWhite,
                              border: Border.all(
                                color: P.paperBorder,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.6),
                                  blurRadius: 24,
                                  offset: const Offset(6, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // خطوط الورق
                                Container(
                                  width: 200,
                                  height: 2,
                                  color: P.paperLine,
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'المصحح',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: P.ink,
                                    fontSize: 48,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 4,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  width: 80,
                                  height: 3,
                                  color: P.inkRed,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'صحّح ورق الطلاب... واحد واحد',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: P.inkBlue,
                                    fontSize: 13,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  width: 200,
                                  height: 2,
                                  color: P.paperLine,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        // زر البدء
                        GestureDetector(
                          onTap: _start,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color: P.inkRed,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.6),
                                  blurRadius: 20,
                                  offset: const Offset(3, 5),
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: const Text(
                              'ابدأ التصحيح',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: P.white,
                                fontSize: 20,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Nour Developer',
                          style: TextStyle(
                            color: P.dim.withOpacity(0.7),
                            fontSize: 11,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ────── اليمين: ورقة مصححة ──────
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // ورقة ورا (زرقاء)
                        Transform.rotate(
                          angle: 0.12,
                          child: Container(
                            width: 200,
                            height: 250,
                            decoration: BoxDecoration(
                              color: P.paperBlue,
                              border: Border.all(color: P.paperBorder),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 20,
                                  offset: const Offset(4, 6),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // ورقة أمام (عاجية)
                        Transform.rotate(
                          angle: -0.06,
                          child: Container(
                            width: 200,
                            height: 250,
                            decoration: BoxDecoration(
                              color: P.paperWhite,
                              border: Border.all(color: P.paperBorder),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 20,
                                  offset: const Offset(4, 6),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                ...List.generate(4, (i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        // علامة صح أو غلط
                                        Icon(
                                          i == 1 ? Icons.close : Icons.check,
                                          color: i == 1
                                              ? P.inkRed
                                              : P.correct,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Container(
                                            height: 2,
                                            color: P.paperLine,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════ خطوط الخشب ═══════════
class _WoodGrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.06)
      ..strokeWidth = 1.5;

    // خطوط أفقية باهتة (شكل خشب)
    for (int i = 0; i < size.height; i += 40) {
      final path = Path();
      path.moveTo(0, i.toDouble());
      for (double x = 0; x < size.width; x += 60) {
        path.lineTo(
          x,
          i + (x % 120 == 0 ? 3 : -3),
        );
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}