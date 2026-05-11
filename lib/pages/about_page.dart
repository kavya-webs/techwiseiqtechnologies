// TechWiseIQ - About Page
// Showcases company story, philosophy, stats, leadership, and promises.
// All sections adapt to mobile (< 900px) via MediaQuery breakpoints.
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../widgets/reveal_on_scroll.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _AboutHero(scrollController: _scrollController),
                const _PhilosophySection(),
                const _ValueStatsSection(),
                const _MissionVisionSection(),
                const _GlobalFootprintSection(),
                const _LeadershipSection(),
                const _PromiseSection(),
                const RevealOnScroll(child: TechWiseFooter()),
              ],
            ),
          ),
          const Positioned(top: 0, left: 0, right: 0, child: TechWiseNavBar()),
        ],
      ),
    );
  }
}

class _AboutHero extends StatefulWidget {
  final ScrollController scrollController;
  const _AboutHero({required this.scrollController});

  @override
  State<_AboutHero> createState() => _AboutHeroState();
}

class _AboutHeroState extends State<_AboutHero>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    _pulseController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (mounted) {
      setState(() {
        _scrollOffset = widget.scrollController.offset;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final heroHeight = isMobile ? 500.0 : 700.0;

    // Parallax values
    final textParallax = _scrollOffset * 0.4;
    final bgParallax = _scrollOffset * 0.2;

    return SizedBox(
      height: heroHeight,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(child: Container(color: AppColors.primaryDark)),

          // Orbital Parallax Background
          Positioned(
            top: bgParallax,
            bottom: -bgParallax,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (_, __) {
                return CustomPaint(
                  painter: _OrbitalPainter(
                    phase: _pulseController.value * 2 * pi,
                    scrollOffset: _scrollOffset,
                  ),
                );
              },
            ),
          ),

          // Bottom Fade Gradient
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
                  stops: [0, 0.4, 0.75, 1.0],
                ),
              ),
            ),
          ),

          // High-end Text overlay (parallaxed slightly slower)
          Positioned(
            top: (isMobile ? 120 : 180) + textParallax,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
              child: SizedBox(
                width: isMobile ? MediaQuery.of(context).size.width - 48 : 800,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Semantics(
                      header: true,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cyan.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: AppColors.cyan.withValues(alpha: 0.3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.cyan.withValues(alpha: 0.2),
                              blurRadius: 20,
                              spreadRadius: -5,
                            ),
                          ],
                        ),
                        child: Text(
                          'THE TECHWISEIQ STORY',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 3,
                            color: AppColors.cyan,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Semantics(
                      label: 'Pioneering Excellence in Technology',
                      child: Text(
                        'Pioneering Excellence in Technology',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: isMobile ? 42 : 72,
                          fontWeight: FontWeight.w600,
                          height: 1.1,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Designing the future of enterprise architecture from the heart of Dubai, merging visionary ambition with relentless engineering precision.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 16 : 20,
                        height: 1.6,
                        color: const Color(0xFF8894A8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrbitalPainter extends CustomPainter {
  final double phase;
  final double scrollOffset;

  _OrbitalPainter({required this.phase, required this.scrollOffset});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 100);

    // Parallax 3D Transformation applied directly to canvas
    // Tilt the rings heavily based on scroll position
    final baseTilt = pi / 3.5;
    final dynamicTilt = baseTilt - (scrollOffset * 0.0005);

    canvas.save();
    canvas.translate(center.dx, center.dy);

    // Apply 3D perspective
    final matrix =
        Matrix4.identity()
          ..setEntry(3, 2, 0.001) // perspective
          ..rotateX(dynamicTilt.clamp(0.0, pi / 2));

    canvas.transform(matrix.storage);

    final paintLine =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;

    final paintGlow =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8.0
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12.0);

    // Draw 4 concentric expanding/rotating orbital rings
    final baseRadius = isMobileSize(size) ? 150.0 : 250.0;

    for (int i = 0; i < 4; i++) {
      final ringRadius = baseRadius + (i * 120.0);

      // Calculate dynamic rotation based on phase and scroll offset
      final dir = i % 2 == 0 ? 1 : -1;
      final rot = (phase * dir) + (scrollOffset * 0.002 * dir);

      canvas.save();
      canvas.rotate(rot);

      // Dash effects
      final dashCount = 60 + (i * 20);
      final dashLength = (2 * pi * ringRadius) / dashCount * 0.6;
      final gapLength = (2 * pi * ringRadius) / dashCount * 0.4;

      final path = Path();
      for (
        double angle = 0;
        angle < 2 * pi;
        angle += (dashLength + gapLength) / ringRadius
      ) {
        path.addArc(
          Rect.fromCircle(center: Offset.zero, radius: ringRadius),
          angle,
          dashLength / ringRadius,
        );
      }

      // Add glow and solid lines with alternating colors
      final isAccent = i == 1 || i == 3;
      final color = isAccent ? AppColors.cyan : const Color(0xFF2B4C7E);

      paintGlow.color = color.withValues(alpha: 0.15 - (i * 0.02));
      canvas.drawPath(path, paintGlow);

      paintLine.color = color.withValues(alpha: 0.4 - (i * 0.05));
      canvas.drawPath(path, paintLine);

      // Draw subtle orbital nodes on the rings
      final nodePaint =
          Paint()
            ..style = PaintingStyle.fill
            ..color = AppColors.white.withValues(alpha: 0.8);

      for (int n = 0; n < 3; n++) {
        final nodeAngle = (2 * pi / 3) * n + (i * pi / 4);
        final nx = ringRadius * cos(nodeAngle);
        final ny = ringRadius * sin(nodeAngle);
        canvas.drawCircle(Offset(nx, ny), 3, nodePaint);

        // Glow for nodes
        final nodeGlow =
            Paint()
              ..style = PaintingStyle.fill
              ..color = AppColors.cyan.withValues(alpha: 0.6)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);
        canvas.drawCircle(Offset(nx, ny), 6, nodeGlow);
      }

      canvas.restore();
    }

    canvas.restore();
  }

  bool isMobileSize(Size size) => size.width < 900;

  @override
  bool shouldRepaint(covariant _OrbitalPainter old) =>
      old.phase != phase || old.scrollOffset != scrollOffset;
}

class _PhilosophySection extends StatelessWidget {
  const _PhilosophySection();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      color: AppColors.primaryDark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 120,
        vertical: isMobile ? 48 : 80,
      ),
      child: isMobile ? _mobile() : _desktop(),
    );
  }

  Widget _desktop() => RevealOnScroll(
    revealType: RevealType.slideRight,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _content()),
        const SizedBox(width: 80),
        Expanded(
          flex: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/burj.jpeg',
              height: 420,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) =>
                      Container(color: AppColors.secondaryDark, height: 420),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _mobile() => RevealOnScroll(
    revealType: RevealType.fadeUp,
    child: Column(
      children: [
        _content(),
        const SizedBox(height: 32),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/burj.jpeg',
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder:
                (_, __, ___) =>
                    Container(color: AppColors.secondaryDark, height: 250),
          ),
        ),
      ],
    ),
  );

  Widget _content() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.cyan.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          'OUR PHILOSOPHY',
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
        'Where Vision Meets Precision',
        style: GoogleFonts.cormorantGaramond(
          fontSize: 40,
          fontWeight: FontWeight.w600,
          height: 1.2,
          color: AppColors.white,
        ),
      ),
      const SizedBox(height: 24),
      Text(
        'We believe that exceptional technology should be invisible - seamlessly integrating into your operations while powerfully driving results.',
        style: GoogleFonts.inter(
          fontSize: 16,
          height: 1.7,
          color: const Color(0xFF6B7A94),
        ),
      ),
      const SizedBox(height: 16),
      Text(
        'Every solution we architect is built on three pillars: reliability, scalability, and security.',
        style: GoogleFonts.inter(
          fontSize: 16,
          height: 1.7,
          color: const Color(0xFF6B7A94),
        ),
      ),
    ],
  );
}

class _ValueStatsSection extends StatelessWidget {
  const _ValueStatsSection();
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      color: const Color(0xFF0A0F1F),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 120,
        vertical: isMobile ? 40 : 60,
      ),
      child: RevealOnScroll(
        revealType: RevealType.fadeUp,
        child:
            isMobile
                ? Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 32,
                  runSpacing: 24,
                  children: const [
                    _Stat('10+', 'Years Experience'),
                    _Stat('150+', 'Projects Delivered'),
                    _Stat('50+', 'Enterprise Clients'),
                    _Stat('24/7', 'Active Support'),
                  ],
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _Stat('10+', 'Years Experience'),
                    _Stat('150+', 'Projects Delivered'),
                    _Stat('50+', 'Enterprise Clients'),
                    _Stat('24/7', 'Active Support'),
                  ],
                ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value, label;
  const _Stat(this.value, this.label);
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: GoogleFonts.cormorantGaramond(
          fontSize: 42,
          fontWeight: FontWeight.w600,
          color: AppColors.cyan,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF5A6478)),
      ),
    ],
  );
}

class _LeadershipSection extends StatelessWidget {
  const _LeadershipSection();
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      color: AppColors.primaryDark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 120,
        vertical: isMobile ? 48 : 80,
      ),
      child: Column(
        children: [
          RevealOnScroll(
            revealType: RevealType.fadeUp,
            child: SizedBox(
              width: 700,
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
                      'LEADERSHIP',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                        color: AppColors.cyan,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Meet the Minds Behind TechWiseIQ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: isMobile ? 28 : 40,
                      fontWeight: FontWeight.w600,
                      height: 1.15,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),
          RevealOnScroll(
            revealType: RevealType.slideLeft,
            delay: const Duration(milliseconds: 100),
            child:
                isMobile
                    ? Column(
                      children: const [
                        _Leader(
                          'Bansi Khakher',
                          'CEO',
                          'Visionary leader with 15+ years shaping enterprise tech.',
                        ),
                        SizedBox(height: 16),
                        _Leader(
                          'Janakkumar Makwana',
                          'Owner',
                          'Architect of scalable platforms for Fortune 500.',
                        ),
                        SizedBox(height: 16),
                        _Leader(
                          'Rudrakumar Makwana',
                          'Operations Head',
                          'NESA compliance expert with a decade of experience.',
                        ),
                      ],
                    )
                    : Row(
                      children: const [
                        Expanded(
                          child: _Leader(
                            'Bansi Khakher',
                            'CEO',
                            'Visionary leader with 15+ years shaping enterprise tech.',
                          ),
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: _Leader(
                            'Janakkumar Makwana',
                            'Owner',
                            'Architect of scalable platforms for Fortune 500.',
                          ),
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: _Leader(
                            'Rudrakumar Makwana',
                            'Operations Head',
                            'NESA compliance expert with a decade of experience.',
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

class _Leader extends StatelessWidget {
  final String name, role, desc;
  const _Leader(this.name, this.role, this.desc);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(32),
    decoration: BoxDecoration(
      color: const Color(0xFF0D1526),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.white.withValues(alpha: 0.05)),
    ),
    child: Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.cyan.withValues(alpha: 0.1),
          ),
          child: const Icon(Icons.person, size: 40, color: AppColors.cyan),
        ),
        const SizedBox(height: 20),
        Text(
          name,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          role,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.cyan,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            height: 1.6,
            color: const Color(0xFF6B7A94),
          ),
        ),
      ],
    ),
  );
}

class _PromiseSection extends StatelessWidget {
  const _PromiseSection();
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      color: const Color(0xFF0A0F1F),
      padding: EdgeInsets.all(isMobile ? 24 : 80),
      child: Column(
        children: [
          RevealOnScroll(
            revealType: RevealType.fadeUp,
            child: SizedBox(
              width: 700,
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
                      'OUR PROMISE',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                        color: AppColors.cyan,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'What Sets Us Apart',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: isMobile ? 28 : 40,
                      fontWeight: FontWeight.w600,
                      height: 1.15,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),
          RevealOnScroll(
            revealType: RevealType.slideRight,
            delay: const Duration(milliseconds: 100),
            child:
                isMobile
                    ? Column(
                      children: const [
                        _Promise(
                          Icons.shield_outlined,
                          'Uncompromising Security',
                          'Enterprise-grade protection built into everything.',
                        ),
                        SizedBox(height: 16),
                        _Promise(
                          Icons.speed_outlined,
                          'Relentless Performance',
                          '99.9% uptime is our standard.',
                        ),
                        SizedBox(height: 16),
                        _Promise(
                          Icons.handshake_outlined,
                          'True Partnership',
                          'We invest in long-term relationships.',
                        ),
                      ],
                    )
                    : Row(
                      children: const [
                        Expanded(
                          child: _Promise(
                            Icons.shield_outlined,
                            'Uncompromising Security',
                            'Enterprise-grade protection built into everything.',
                          ),
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: _Promise(
                            Icons.speed_outlined,
                            'Relentless Performance',
                            '99.9% uptime is our standard.',
                          ),
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: _Promise(
                            Icons.handshake_outlined,
                            'True Partnership',
                            'We invest in long-term relationships.',
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

class _Promise extends StatelessWidget {
  final IconData icon;
  final String title, desc;
  const _Promise(this.icon, this.title, this.desc);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(32),
    decoration: BoxDecoration(
      color: const Color(0xFF0D1526),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.white.withValues(alpha: 0.05)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.cyan.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.cyan),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          desc,
          style: GoogleFonts.inter(
            fontSize: 14,
            height: 1.6,
            color: const Color(0xFF6B7A94),
          ),
        ),
      ],
    ),
  );
}

class _MissionVisionSection extends StatelessWidget {
  const _MissionVisionSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      color: AppColors.primaryDark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 120,
        vertical: isMobile ? 48 : 80,
      ),
      child: RevealOnScroll(
        revealType: RevealType.fadeUp,
        child:
            isMobile
                ? Column(
                  children: const [
                    _MVCard(
                      title: 'Our Mission',
                      desc:
                          'To empower enterprises with future-ready, scalable, and secure technology solutions that drive unprecedented growth and operational excellence.',
                      icon: Icons.rocket_launch_outlined,
                    ),
                    SizedBox(height: 24),
                    _MVCard(
                      title: 'Our Vision',
                      desc:
                          'To be the global vanguard of digital transformation, setting the benchmark for innovation, reliability, and precision in software engineering.',
                      icon: Icons.visibility_outlined,
                    ),
                  ],
                )
                : Row(
                  children: const [
                    Expanded(
                      child: _MVCard(
                        title: 'Our Mission',
                        desc:
                            'To empower enterprises with future-ready, scalable, and secure technology solutions that drive unprecedented growth and operational excellence.',
                        icon: Icons.rocket_launch_outlined,
                      ),
                    ),
                    SizedBox(width: 32),
                    Expanded(
                      child: _MVCard(
                        title: 'Our Vision',
                        desc:
                            'To be the global vanguard of digital transformation, setting the benchmark for innovation, reliability, and precision in software engineering.',
                        icon: Icons.visibility_outlined,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}

class _MVCard extends StatelessWidget {
  final String title, desc;
  final IconData icon;

  const _MVCard({required this.title, required this.desc, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1526),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.cyan.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyan.withValues(alpha: 0.05),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cyan.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.cyan, size: 32),
          ),
          const SizedBox(height: 24),
          Semantics(
            header: true,
            child: Text(
              title,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            desc,
            style: GoogleFonts.inter(
              fontSize: 16,
              height: 1.7,
              color: const Color(0xFF8894A8),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlobalFootprintSection extends StatelessWidget {
  const _GlobalFootprintSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      color: const Color(0xFF0A0F1F),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 120,
        vertical: isMobile ? 48 : 80,
      ),
      child: Column(
        children: [
          RevealOnScroll(
            revealType: RevealType.fadeUp,
            child: Column(
              children: [
                Semantics(
                  header: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cyan.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'GLOBAL REACH & EXPERTISE',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                        color: AppColors.cyan,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Delivering World-Class Solutions',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: isMobile ? 28 : 40,
                    fontWeight: FontWeight.w600,
                    height: 1.15,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 600,
                  child: Text(
                    'Our diverse tech stack and agile methodologies enable us to deliver scalable, high-performance applications for clients worldwide.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      height: 1.6,
                      color: const Color(0xFF6B7A94),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          RevealOnScroll(
            revealType: RevealType.fadeUp,
            delay: const Duration(milliseconds: 100),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: const [
                _TechBadge('Flutter'),
                _TechBadge('ReactJS'),
                _TechBadge('Node.js'),
                _TechBadge('Python AI'),
                _TechBadge('AWS Cloud'),
                _TechBadge('Cybersecurity'),
                _TechBadge('UI/UX Design'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TechBadge extends StatelessWidget {
  final String label;
  const _TechBadge(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.cyan.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
