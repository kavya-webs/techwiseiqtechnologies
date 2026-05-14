// TechWiseIQ - Contact Page
// Interactive hero with signal-pulse animation, contact form + info cards.
// All sections adapt to mobile (< 900px) via MediaQuery breakpoints.
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import '../site_config.dart';
import '../theme/app_colors.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../widgets/techwise_button.dart';
import '../widgets/reveal_on_scroll.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: const [
                _ContactHero(),
                _ContactContent(),
                RevealOnScroll(child: TechWiseFooter()),
              ],
            ),
          ),
          const Positioned(top: 0, left: 0, right: 0, child: TechWiseNavBar()),
        ],
      ),
    );
  }
}

class _Ring {
  final Offset origin;
  double radius, opacity;
  final double speed;
  final Color color;
  _Ring({
    required this.origin,
    required this.color,
    this.radius = 0,
    this.opacity = 0.7,
    this.speed = 80,
  });
  bool tick(double dt) {
    radius += speed * dt;
    opacity = (1 - radius / 420).clamp(0.0, 0.7);
    return opacity > 0.01;
  }
}

class _ContactHero extends StatefulWidget {
  const _ContactHero();
  @override
  State<_ContactHero> createState() => _ContactHeroState();
}

class _ContactHeroState extends State<_ContactHero>
    with TickerProviderStateMixin {
  late Ticker _ticker;
  final List<_Ring> _rings = [];
  final Random _rng = Random();
  Duration _last = Duration.zero;
  Size _sz = const Size(1440, 600);
  static const _nodes = [
    Offset(0.18, 0.38),
    Offset(0.82, 0.32),
    Offset(0.50, 0.22),
    Offset(0.28, 0.72),
    Offset(0.72, 0.68),
  ];
  late List<double> _next;

  @override
  void initState() {
    super.initState();
    _next = List.generate(_nodes.length, (_) => _rng.nextDouble() * 2.5);
    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    if (!mounted) return;
    final dt = ((elapsed - _last).inMicroseconds / 1e6).clamp(0.0, 0.05);
    _last = elapsed;
    _rings.removeWhere((r) => !r.tick(dt));
    for (int i = 0; i < _nodes.length; i++) {
      _next[i] -= dt;
      if (_next[i] <= 0) {
        _rings.add(
          _Ring(
            origin: Offset(_nodes[i].dx * _sz.width, _nodes[i].dy * _sz.height),
            color: AppColors.cyan,
            speed: 60 + _rng.nextDouble() * 40,
          ),
        );
        _next[i] = 1.8 + _rng.nextDouble() * 2.0;
      }
    }
    setState(() {});
  }

  void _onTap(TapDownDetails d) {
    for (int k = 0; k < 3; k++) {
      _rings.add(
        _Ring(
          origin: d.localPosition,
          color: Colors.white,
          radius: k * 18.0,
          opacity: 0.55,
          speed: 90 + k * 20,
        ),
      );
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return LayoutBuilder(
      builder: (ctx, cons) {
        _sz = cons.biggest.isInfinite ? const Size(1440, 600) : cons.biggest;
        return SizedBox(
          height: isMobile ? 420 : 600,
          width: double.infinity,
          child: GestureDetector(
            onTapDown: _onTap,
            child: Stack(
              children: [
                Positioned.fill(child: Container(color: AppColors.primaryDark)),
                Positioned.fill(
                  child: CustomPaint(
                    painter: _PulsePainter(
                      rings: List.unmodifiable(_rings),
                      nodes: _nodes,
                      sz: _sz,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x25060B18),
                          Color(0x00060B18),
                          Color(0x00060B18),
                          Color(0xFF060B18),
                        ],
                        stops: [0, 0.1, 0.65, 1.0],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 80,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: isMobile ? 60 : 90),
                        SizedBox(
                          width: isMobile ? double.infinity : 680,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.cyan.withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  'GET IN TOUCH',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2,
                                    color: AppColors.cyan,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                "We're Here to Help",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: isMobile ? 32 : 56,
                                  fontWeight: FontWeight.w600,
                                  height: 1.1,
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Tap anywhere to send a signal.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: isMobile ? 14 : 16,
                                  height: 1.6,
                                  color: const Color(0xFF8894A8),
                                ),
                              ),
                            ],
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
      },
    );
  }
}

class _PulsePainter extends CustomPainter {
  final List<_Ring> rings;
  final List<Offset> nodes;
  final Size sz;
  const _PulsePainter({
    required this.rings,
    required this.nodes,
    required this.sz,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final f in nodes) {
      final c = Offset(f.dx * size.width, f.dy * size.height);
      canvas.drawCircle(
        c,
        80,
        Paint()
          ..shader = RadialGradient(
            colors: [
              const Color(0xFF00D4FF).withValues(alpha: 0.08),
              Colors.transparent,
            ],
          ).createShader(Rect.fromCircle(center: c, radius: 80)),
      );
    }
    final lp =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final a = Offset(nodes[i].dx * size.width, nodes[i].dy * size.height);
        final b = Offset(nodes[j].dx * size.width, nodes[j].dy * size.height);
        if ((a - b).distance < size.width * 0.45) {
          lp.color = const Color(0xFF00D4FF).withValues(alpha: 0.08);
          canvas.drawLine(a, b, lp);
        }
      }
    }
    for (final r in rings) {
      canvas.drawCircle(
        r.origin,
        r.radius,
        Paint()
          ..color = r.color.withValues(alpha: r.opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
    for (final f in nodes) {
      final c = Offset(f.dx * size.width, f.dy * size.height);
      canvas.drawCircle(
        c,
        9,
        Paint()
          ..color = const Color(0xFF00D4FF).withValues(alpha: 0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2,
      );
      canvas.drawCircle(
        c,
        4,
        Paint()..color = const Color(0xFF00D4FF).withValues(alpha: 0.9),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PulsePainter old) => true;
}

class _ContactContent extends StatelessWidget {
  const _ContactContent();
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      color: AppColors.primaryDark,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 48 : 80,
        horizontal: isMobile ? 24 : 120,
      ),
      child:
          isMobile
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_form(context), const SizedBox(height: 48), _info()],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _form(context)),
                  const SizedBox(width: 80),
                  Expanded(flex: 2, child: _info()),
                ],
              ),
    );
  }

  Widget _form(BuildContext ctx) => RevealOnScroll(
    revealType: RevealType.slideRight,
    delay: const Duration(milliseconds: 100),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Send us a Message',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Fill out the form and we will get back to you within 24 hours.',
          style: GoogleFonts.inter(
            fontSize: 16,
            height: 1.6,
            color: AppColors.darkGrey,
          ),
        ),
        const SizedBox(height: 32),
        const _Field('Name', 'Your Name'),
        const SizedBox(height: 24),
        const _Field('Email', SiteConfig.contactEmail),
        const SizedBox(height: 24),
        const _Field('Subject', 'Project Inquiry'),
        const SizedBox(height: 24),
        const _Field('Message', 'Tell us about your project...', lines: 5),
        const SizedBox(height: 32),
        TechWiseButton(
          text: 'Send Message',
          width: double.infinity,
          height: 56,
          borderRadius: 8,
          onPressed: () {
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(
                content: const Text(
                  'Message sent! We will respond within 24 hours.',
                ),
                backgroundColor: AppColors.cyan,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          },
        ),
      ],
    ),
  );

  Widget _info() => RevealOnScroll(
    revealType: RevealType.slideLeft,
    delay: const Duration(milliseconds: 200),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 32),
        const _InfoCard(
          Icons.location_on_outlined,
          'Visit Us',
          'Office no 3204, Aspect Tower, Business Bay, Dubai, UAE',
        ),
        const SizedBox(height: 24),
        const _InfoCard(
          Icons.email_outlined,
          'Email Us',
          SiteConfig.contactEmail,
        ),
        const SizedBox(height: 24),
        const _InfoCard(Icons.phone_outlined, 'Call Us', '+971 50 3150751'),
      ],
    ),
  );
}

class _Field extends StatelessWidget {
  final String label, hint;
  final int lines;
  const _Field(this.label, this.hint, {this.lines = 1});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.white.withValues(alpha: 0.1)),
        ),
        child: TextField(
          maxLines: lines,
          style: GoogleFonts.inter(color: AppColors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: AppColors.grey),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ),
    ],
  );
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title, desc;
  const _InfoCard(this.icon, this.title, this.desc);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: const Color(0xFF0D1526),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.white.withValues(alpha: 0.05)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.cyan, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  height: 1.6,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
