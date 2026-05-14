import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../widgets/reveal_on_scroll.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
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
                _ServicesHero(scrollController: _scrollController),
                const _PhilosophyBreak(),
                const _InteractiveGrid(),
                const _WhyChooseUsBreak(),
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

class _PhilosophyBreak extends StatelessWidget {
  const _PhilosophyBreak();
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      color: const Color(0xFF0A0F1F),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 120,
        vertical: isMobile ? 60 : 100,
      ),
      child: RevealOnScroll(
        revealType: RevealType.fadeUp,
        child: Column(
          children: [
            Text(
              'Engineering the Future',
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                fontSize: isMobile ? 32 : 46,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 800,
              child: Text(
                'At TechWiseIQ, we believe that software should be beautiful on the inside and outside. Our services are built upon a foundation of zero-trust security, highly cohesive modularity, and pixel-perfect aesthetic precision.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 16 : 18,
                  height: 1.8,
                  color: const Color(0xFF8894A8),
                ),
              ),
            ),
            const SizedBox(height: 48),
            Wrap(
              spacing: 40,
              runSpacing: 40,
              alignment: WrapAlignment.center,
              children: [
                _buildStat('50+', 'Enterprise Projects'),
                _buildStat('99.99%', 'Uptime Guaranteed'),
                _buildStat('< 0.5s', 'Latency Pipelines'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String val, String label) {
    return Column(
      children: [
        Text(
          val,
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.cyan,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF6B7A94),
          ),
        ),
      ],
    );
  }
}

class _WhyChooseUsBreak extends StatelessWidget {
  const _WhyChooseUsBreak();
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      color: const Color(0xFF060B18),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 120,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          RevealOnScroll(
            revealType: RevealType.slideRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.cyan.withValues(alpha: 0.3),
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'THE TECHWISEIQ ADVANTAGE',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  color: AppColors.cyan,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          RevealOnScroll(
            revealType: RevealType.slideLeft,
            child: Text(
              'Why Leading Brands Choose Us',
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                fontSize: isMobile ? 32 : 46,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildFeature(
                Icons.security_rounded,
                'Security First',
                'Every line of code is audited and tested for vulnerabilities.',
              ),
              _buildFeature(
                Icons.speed_rounded,
                'Extreme Velocity',
                'Agile pipelines that deliver scale without sacrificing quality.',
              ),
              _buildFeature(
                Icons.support_agent_rounded,
                '24/7 Partnership',
                'Dedicated engineers proactively monitoring your infrastructure.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String title, String desc) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.cyan.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cyan.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 36, color: AppColors.cyan),
          const SizedBox(height: 24),
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
              color: const Color(0xFF8894A8),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServicesHero extends StatefulWidget {
  final ScrollController scrollController;
  const _ServicesHero({required this.scrollController});
  @override
  State<_ServicesHero> createState() => _ServicesHeroState();
}

class _ServicesHeroState extends State<_ServicesHero>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final ValueNotifier<int?> _hovered = ValueNotifier<int?>(null);

  // Planet data — split into inner (0-2) and outer (3-5) rings.
  // Use IconData (Icons.*), not raw codepoints: release web builds tree-shake
  // MaterialIcons and only keep glyphs referenced via IconData.
  static const _planetData = [
    {'label': 'Software Dev', 'icon': Icons.code},
    {'label': 'Web Dev', 'icon': Icons.web},
    {'label': 'IT Infra', 'icon': Icons.dns},
    {'label': 'Cyber Security', 'icon': Icons.security},
    {'label': 'Data Mgmt', 'icon': Icons.data_usage},
    {'label': 'Hardware', 'icon': Icons.memory},
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 50),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _hovered.dispose();
    super.dispose();
  }

  // Hit-test helper: find which planet (if any) is under the pointer
  void _onPointerMove(PointerEvent event, Size areaSize, bool isMobile) {
    final cx = areaSize.width / 2;
    final cy = areaSize.height / 2 + 80;
    final phase = _ctrl.value * 2 * pi;

    const tiltFactor = 0.45; // Y-axis squash to simulate 3D tilt
    final innerR = isMobile ? 140.0 : 280.0;
    final outerR = isMobile ? 220.0 : 420.0;

    int? hit;
    for (int i = 0; i < 6; i++) {
      final r = i < 3 ? innerR : outerR;
      final speed = i < 3 ? 1.0 : 0.6;
      final offset = i < 3 ? 0 : 3;
      final angle = (phase * speed) + ((2 * pi / 3) * (i - offset));
      final px = cx + cos(angle) * r;
      final py = cy + sin(angle) * r * tiltFactor;
      final dx = event.localPosition.dx - px;
      final dy = event.localPosition.dy - py;
      if (dx * dx + dy * dy < 45 * 45) {
        hit = i;
        break;
      }
    }
    if (_hovered.value != hit) _hovered.value = hit;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final heroHeight = isMobile ? 600.0 : 800.0;

    return SizedBox(
      height: heroHeight,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Rich deep-space background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, 0.2),
                  radius: 1.2,
                  colors: [
                    Color(0xFF0D1B2E),
                    Color(0xFF060B18),
                    Color(0xFF020408),
                  ],
                  stops: [0, 0.6, 1],
                ),
              ),
            ),
          ),

          // Ambient glow spots (static — no animation needed)
          Positioned(
            top: heroHeight * 0.25,
            left: isMobile ? -60 : 100,
            child: Container(
              width: isMobile ? 250 : 400,
              height: isMobile ? 250 : 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.cyan.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: heroHeight * 0.1,
            right: isMobile ? -40 : 80,
            child: Container(
              width: isMobile ? 200 : 350,
              height: isMobile ? 200 : 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF1E40AF).withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 3D Tilted Orbital System — pure CustomPaint, no widget tree rebuilds
          Positioned.fill(
            child: RepaintBoundary(
              child: Listener(
                behavior: HitTestBehavior.translucent,
                onPointerHover:
                    (e) => _onPointerMove(
                      e,
                      Size(MediaQuery.of(context).size.width, heroHeight),
                      isMobile,
                    ),
                onPointerMove:
                    (e) => _onPointerMove(
                      e,
                      Size(MediaQuery.of(context).size.width, heroHeight),
                      isMobile,
                    ),
                child: AnimatedBuilder(
                  animation: Listenable.merge([_ctrl, _hovered]),
                  builder: (context, _) {
                    return CustomPaint(
                      size: Size.infinite,
                      painter: _OrbitalPainter(
                        phase: _ctrl.value * 2 * pi,
                        hoveredIndex: _hovered.value,
                        isMobile: isMobile,
                        planetData: _planetData,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Vignette edges
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 200,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00060B18), Color(0xFF060B18)],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 120,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0x00060B18), Color(0x80060B18)],
                ),
              ),
            ),
          ),

          // Header text overlay
          Positioned(
            top: isMobile ? 90 : 100,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cyan.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.cyan.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        'OUR ECOSYSTEM',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 3,
                          color: AppColors.cyan,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Semantics(
                      header: true,
                      child: Text(
                        'Connected Intelligence',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: isMobile ? 38 : 54,
                          fontWeight: FontWeight.w600,
                          height: 1.1,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 500,
                      child: Text(
                        'Six core capabilities orbiting a unified technology nucleus.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: isMobile ? 14 : 16,
                          height: 1.6,
                          color: const Color(0xFF8894A8),
                        ),
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

// ─── Pure CustomPainter for the entire orbital system ───
class _OrbitalPainter extends CustomPainter {
  final double phase;
  final int? hoveredIndex;
  final bool isMobile;
  final List<Map<String, dynamic>> planetData;

  _OrbitalPainter({
    required this.phase,
    required this.hoveredIndex,
    required this.isMobile,
    required this.planetData,
  });

  static const _tiltFactor = 0.45; // Y-squash simulates 3D viewing angle

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2 + 80;
    final innerR = isMobile ? 140.0 : 280.0;
    final outerR = isMobile ? 220.0 : 420.0;

    // ── Draw orbit ellipses ──
    _drawOrbitRing(canvas, cx, cy, innerR);
    _drawOrbitRing(canvas, cx, cy, outerR);

    // ── Draw central sun ──
    _drawSun(canvas, cx, cy);

    // ── Draw connection beam if hovered ──
    if (hoveredIndex != null) {
      _drawConnectionBeam(canvas, cx, cy, hoveredIndex!, innerR, outerR);
    }

    // ── Draw planets ──
    for (int i = 0; i < 6; i++) {
      _drawPlanet(canvas, cx, cy, i, innerR, outerR);
    }
  }

  void _drawOrbitRing(Canvas canvas, double cx, double cy, double r) {
    final rect = Rect.fromCenter(
      center: Offset(cx, cy),
      width: r * 2,
      height: r * 2 * _tiltFactor,
    );
    canvas.drawOval(
      rect,
      Paint()
        ..color = const Color(0xFF00D4FF).withValues(alpha: 0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
    // Subtle glow ring
    canvas.drawOval(
      rect,
      Paint()
        ..color = const Color(0xFF00D4FF).withValues(alpha: 0.03)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
  }

  void _drawSun(Canvas canvas, double cx, double cy) {
    final sunR = isMobile ? 50.0 : 85.0;

    // Outer glow
    canvas.drawCircle(
      Offset(cx, cy),
      sunR + 30,
      Paint()
        ..color = const Color(0xFF00D4FF).withValues(alpha: 0.08)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30),
    );
    // Mid glow
    canvas.drawCircle(
      Offset(cx, cy),
      sunR + 10,
      Paint()
        ..color = const Color(0xFF00D4FF).withValues(alpha: 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15),
    );
    // Fill
    canvas.drawCircle(
      Offset(cx, cy),
      sunR,
      Paint()..color = const Color(0xFF0F1626),
    );
    // Border
    canvas.drawCircle(
      Offset(cx, cy),
      sunR,
      Paint()
        ..color = const Color(0xFF00D4FF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // "TechWise IQ" text
    final tp = TextPainter(
      text: TextSpan(
        text: 'TechWise\nIQ',
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w900,
          fontSize: isMobile ? 13 : 16,
          letterSpacing: 1,
          height: 1.3,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(cx - tp.width / 2, cy - tp.height / 2));
  }

  Offset _planetPos(
    double cx,
    double cy,
    int index,
    double innerR,
    double outerR,
  ) {
    final r = index < 3 ? innerR : outerR;
    final speed = index < 3 ? 1.0 : 0.6;
    final offset = index < 3 ? 0 : 3;
    final angle = (phase * speed) + ((2 * pi / 3) * (index - offset));
    return Offset(cx + cos(angle) * r, cy + sin(angle) * r * _tiltFactor);
  }

  void _drawConnectionBeam(
    Canvas canvas,
    double cx,
    double cy,
    int idx,
    double innerR,
    double outerR,
  ) {
    final pos = _planetPos(cx, cy, idx, innerR, outerR);
    final center = Offset(cx, cy);

    // Outer glow beam
    canvas.drawLine(
      center,
      pos,
      Paint()
        ..color = const Color(0xFF00D4FF).withValues(alpha: 0.3)
        ..strokeWidth = 6
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );
    // Core beam
    canvas.drawLine(
      center,
      pos,
      Paint()
        ..color = const Color(0xFF00D4FF).withValues(alpha: 0.6)
        ..strokeWidth = 2,
    );
    // White center line
    canvas.drawLine(
      center,
      pos,
      Paint()
        ..color = AppColors.white.withValues(alpha: 0.4)
        ..strokeWidth = 1,
    );
  }

  void _drawPlanet(
    Canvas canvas,
    double cx,
    double cy,
    int index,
    double innerR,
    double outerR,
  ) {
    final pos = _planetPos(cx, cy, index, innerR, outerR);
    final isHovered = hoveredIndex == index;
    final planetR = isHovered ? 34.0 : 28.0;

    // Glow on hover
    if (isHovered) {
      canvas.drawCircle(
        pos,
        planetR + 15,
        Paint()
          ..color = const Color(0xFF00D4FF).withValues(alpha: 0.25)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15),
      );
    }

    // Planet fill
    canvas.drawCircle(
      pos,
      planetR,
      Paint()
        ..color = isHovered ? const Color(0xFF0D2847) : const Color(0xFF111D33),
    );
    // Planet border
    canvas.drawCircle(
      pos,
      planetR,
      Paint()
        ..color =
            isHovered
                ? const Color(0xFF00D4FF)
                : const Color(0xFF00D4FF).withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = isHovered ? 2 : 1,
    );

    // Icon: draw from IconData so web release retains font glyphs (see _planetData).
    final icon = planetData[index]['icon'] as IconData;
    final iconTp = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          fontSize: isHovered ? 22 : 18,
          color: isHovered ? AppColors.white : const Color(0xFF00D4FF),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    iconTp.paint(
      canvas,
      Offset(pos.dx - iconTp.width / 2, pos.dy - iconTp.height / 2),
    );

    // Label on hover
    if (isHovered) {
      final label = planetData[index]['label'] as String;
      final labelTp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      // Label background pill
      final labelX = pos.dx + planetR + 12;
      final labelY = pos.dy - labelTp.height / 2;
      final pillRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          labelX - 10,
          labelY - 6,
          labelTp.width + 20,
          labelTp.height + 12,
        ),
        const Radius.circular(14),
      );
      canvas.drawRRect(
        pillRect,
        Paint()..color = const Color(0xFF0D1B2E).withValues(alpha: 0.9),
      );
      canvas.drawRRect(
        pillRect,
        Paint()
          ..color = const Color(0xFF00D4FF).withValues(alpha: 0.4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
      labelTp.paint(canvas, Offset(labelX, labelY));
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitalPainter old) =>
      old.phase != phase || old.hoveredIndex != hoveredIndex;
}

class _InteractiveGrid extends StatelessWidget {
  const _InteractiveGrid();

  static const _services = [
    {
      'badge': 'SOFTWARE DEVELOPMENT',
      'title': 'Custom-Built Software for Your Business',
      'desc':
          'We design and develop bespoke software solutions using cutting-edge technologies that scale with your ambition.',
      'feats': [
        'Web & Mobile Application Development',
        'API Design & Integration',
        'Legacy System Modernization',
        'Agile Dev & DevOps',
      ],
      'img': 'assets/images/generated-1771352869904.png',
    },
    {
      'badge': 'FULL STACK WEB DEV',
      'title': 'End-to-End Web Solutions',
      'desc':
          'From responsive frontends to robust backend APIs, we build complete web platforms.',
      'feats': [
        'Frontend (React, Angular, Vue)',
        'Backend (Node.js, Python, .NET)',
        'Database Optimization',
        'Progressive Web Apps',
      ],
      'img': 'assets/images/generated-1771418298230.png',
    },
    {
      'badge': 'IT INFRASTRUCTURE',
      'title': 'Resilient Infrastructure, Zero Downtime',
      'desc':
          'We design, deploy, and manage enterprise IT infrastructure that keeps your business running 24/7.',
      'feats': [
        'Cloud Migration (AWS, Azure)',
        'Network Architecture',
        'Disaster Recovery',
        'Server Virtualization',
      ],
      'img': 'assets/images/generated-1771418563501.png',
    },
    {
      'badge': 'CYBER SECURITY',
      'title': 'Enterprise-Grade Security',
      'desc':
          'Protect your digital assets with comprehensive cybersecurity services.',
      'feats': [
        'Threat Detection',
        'Penetration Testing',
        'NESA & ISO 27001',
        'Zero-Trust Architecture',
      ],
      'img': 'assets/images/generated-1771353550724.png',
    },
    {
      'badge': 'DATA MANAGEMENT',
      'title': 'Accurate Data, Actionable Insights',
      'desc':
          'Efficient data entry, processing, and management services designed for enterprises.',
      'feats': [
        'High-Volume Data Entry',
        'Data Cleansing',
        'Database Migration',
        'Reporting Dashboards',
      ],
      'img': 'assets/images/generated-1771352869904.png',
    },
    {
      'badge': 'EQUIPMENT DESIGN',
      'title': 'Hardware-Software Integration',
      'desc':
          'From embedded systems to bespoke equipment design for industry-specific solutions.',
      'feats': [
        'Embedded Systems',
        'IoT Solutions',
        'Custom Equipment',
        'Industrial Automation',
      ],
      'img': 'assets/images/generated-1771418298230.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryDark,
      child: Column(
        children: List.generate(_services.length, (index) {
          final s = _services[index];
          // Alternate the layout direction: even = image right, odd = image left
          final bool imgRight = index.isEven;
          return _ServiceBlock(
            imgRight: imgRight,
            altBackground: !imgRight,
            badge: s['badge'] as String,
            title: s['title'] as String,
            desc: s['desc'] as String,
            feats: s['feats'] as List<String>,
            img: s['img'] as String,
          );
        }),
      ),
    );
  }
}

class _ServiceBlock extends StatelessWidget {
  final bool imgRight;
  final bool altBackground;
  final String badge, title, desc, img;
  final List<String> feats;

  const _ServiceBlock({
    required this.imgRight,
    required this.altBackground,
    required this.badge,
    required this.title,
    required this.desc,
    required this.img,
    required this.feats,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      color: altBackground ? const Color(0xFF0A0F1F) : AppColors.primaryDark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 120,
        vertical: isMobile ? 60 : 120,
      ),
      child: isMobile ? _mobileLayout() : _desktopLayout(),
    );
  }

  Widget _desktopLayout() {
    final textContent = Expanded(
      flex: 5,
      child: RevealOnScroll(
        revealType: RevealType.fadeUp,
        delay: const Duration(milliseconds: 100),
        child: _buildTextContent(),
      ),
    );

    final imageContent = Expanded(
      flex: 5,
      child: RevealOnScroll(
        revealType: imgRight ? RevealType.slideLeft : RevealType.slideRight,
        delay: const Duration(milliseconds: 200),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            img,
            height: 500,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder:
                (_, __, ___) =>
                    Container(color: AppColors.secondaryDark, height: 500),
          ),
        ),
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
          imgRight
              ? [textContent, const SizedBox(width: 80), imageContent]
              : [imageContent, const SizedBox(width: 80), textContent],
    );
  }

  Widget _mobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevealOnScroll(
          revealType: RevealType.fadeUp,
          child: _buildTextContent(),
        ),
        const SizedBox(height: 48),
        RevealOnScroll(
          revealType: RevealType.fadeUp,
          delay: const Duration(milliseconds: 150),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              img,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) =>
                      Container(color: AppColors.secondaryDark, height: 300),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.cyan.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            badge,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: AppColors.cyan,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Semantics(
          label: title,
          child: Text(
            title,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 48,
              fontWeight: FontWeight.w600,
              height: 1.1,
              color: AppColors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          desc,
          style: GoogleFonts.inter(
            fontSize: 18,
            height: 1.6,
            color: const Color(0xFF8894A8),
          ),
        ),
        const SizedBox(height: 32),
        ...feats.map(
          (f) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(
                    Icons.check_circle,
                    size: 20,
                    color: AppColors.cyan,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    f,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xFFBAC4D6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
