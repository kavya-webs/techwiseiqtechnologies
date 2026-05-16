import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/nav_bar.dart';
import '../widgets/techwise_button.dart';
import '../widgets/footer.dart';
import '../pages/services_page.dart';
import '../pages/book_meeting_page.dart';
import '../widgets/reveal_on_scroll.dart';

// ── Particle Model ──────────────────────────────────────────────────────
class _Particle {
  double x;
  double y;
  double vx;
  double vy;
  double radius;
  double baseX; // original X for gentle drift anchoring
  double baseY;
  double opacity;

  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.opacity,
  }) : baseX = x,
       baseY = y;
}

// ── Home Page ───────────────────────────────────────────────────────────
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const _HeroSection(),
                const _ServicesSection(),
                const _AboutSection(),
                const _WhyChooseUsSection(),
                const _StatsSection(),
                const _TestimonialsSection(),
                const _FinalCTASection(),
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

// ── Interactive Hero Section ────────────────────────────────────────────
class _HeroSection extends StatefulWidget {
  const _HeroSection();

  @override
  State<_HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<_HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();
  Offset? _mousePosition;

  // Tuning constants
  static const int _particleCount = 140;
  static const double _connectionDistance = 160.0;
  static const double _mouseRepelRadius = 140.0;
  static const double _mouseRepelStrength = 6.0;
  static const double _particleSpeed = 0.6;
  static const double _driftStrength = 0.02;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // loops forever
    )..addListener(_updateParticles);
    _controller.repeat();
  }

  void _initParticles(double width, double height) {
    _particles.clear();
    for (int i = 0; i < _particleCount; i++) {
      final x = _random.nextDouble() * width;
      final y = _random.nextDouble() * height;
      // Give each particle a random angle for persistent drift
      final angle = _random.nextDouble() * 2 * pi;
      final speed = _random.nextDouble() * _particleSpeed + 0.2;
      _particles.add(
        _Particle(
          x: x,
          y: y,
          vx: cos(angle) * speed,
          vy: sin(angle) * speed,
          radius: _random.nextDouble() * 2.0 + 1.2,
          opacity: _random.nextDouble() * 0.5 + 0.35,
        ),
      );
    }
    _initialized = true;
  }

  void _updateParticles() {
    if (!_initialized || !mounted) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final size = box.size;

    for (final p in _particles) {
      // ── Mouse repulsion ────────────────────────────────────────
      if (_mousePosition != null) {
        final dx = p.x - _mousePosition!.dx;
        final dy = p.y - _mousePosition!.dy;
        final dist = sqrt(dx * dx + dy * dy);
        if (dist < _mouseRepelRadius && dist > 0) {
          final force =
              (_mouseRepelRadius - dist) /
              _mouseRepelRadius *
              _mouseRepelStrength;
          p.vx += (dx / dist) * force;
          p.vy += (dy / dist) * force;
        }
      }

      // ── Random drift perturbation (keeps particles alive) ──────
      p.vx += (_random.nextDouble() - 0.5) * _driftStrength;
      p.vy += (_random.nextDouble() - 0.5) * _driftStrength;

      // ── Clamp speed so they don't fly off too fast ─────────────
      final speed = sqrt(p.vx * p.vx + p.vy * p.vy);
      final maxSpeed = 2.5;
      if (speed > maxSpeed) {
        p.vx = (p.vx / speed) * maxSpeed;
        p.vy = (p.vy / speed) * maxSpeed;
      }

      // ── Light damping (keeps motion smooth, not dead) ──────────
      p.vx *= 0.998;
      p.vy *= 0.998;

      // ── Move ───────────────────────────────────────────────────
      p.x += p.vx;
      p.y += p.vy;

      // ── Wrap around edges seamlessly ───────────────────────────
      if (p.x < -20) p.x += size.width + 40;
      if (p.x > size.width + 20) p.x -= size.width + 40;
      if (p.y < -20) p.y += size.height + 40;
      if (p.y > size.height + 20) p.y -= size.height + 40;
    }

    setState(() {}); // trigger repaint
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return SizedBox(
      height: isMobile ? 700 : 900,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Initialise particles using full screen width
          if (!_initialized) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final screenWidth = MediaQuery.of(context).size.width;
              _initParticles(screenWidth, isMobile ? 700 : 900);
            });
          }

          return MouseRegion(
            onHover: (event) {
              _mousePosition = event.localPosition;
            },
            onExit: (_) {
              _mousePosition = null;
            },
            child: Stack(
              children: [
                // ── Background (dark base) ──────────────────────────
                Positioned.fill(child: Container(color: AppColors.primaryDark)),

                // ── Background Image (subtle) ──────────────────────
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.15,
                    child: Image.asset(
                      'assets/images/generated-1771352869904.png',
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) =>
                              Container(color: AppColors.secondaryDark),
                    ),
                  ),
                ),

                // ── Gradient Overlay ────────────────────────────────
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xE6060B18),
                          Color(0xA0060B18),
                          Color(0xA0060B18),
                          Color(0xF0060B18),
                        ],
                        stops: [0.0, 0.25, 0.75, 1.0],
                      ),
                    ),
                  ),
                ),

                // ── Particle Network Canvas ─────────────────────────
                Positioned.fill(
                  child: CustomPaint(
                    painter: _ParticleNetworkPainter(
                      particles: _particles,
                      connectionDistance: _connectionDistance,
                      mousePosition: _mousePosition,
                      mouseRepelRadius: _mouseRepelRadius,
                    ),
                  ),
                ),

                // ── Radial glow behind content ──────────────────────
                Center(
                  child: Container(
                    width: 700,
                    height: 700,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.cyan.withValues(alpha: 0.04),
                          AppColors.cyan.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── Content ─────────────────────────────────────────
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 120,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: isMobile ? 60 : 100),

                        // Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.cyan.withValues(alpha: 0.07),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.cyan.withValues(alpha: 0.15),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.cyan,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.cyan.withValues(
                                        alpha: 0.6,
                                      ),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Dubai\'s Leading IT & AI Solutions Partner',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.cyan,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Headline
                        SizedBox(
                          width: 900,
                          child: Column(
                            children: [
                              Semantics(
                                header: true,
                                child: Text(
                                  'Engineering the Future of Digital Intelligence',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: isMobile ? 32 : 56,
                                    fontWeight: FontWeight.w600,
                                    height: 1.1,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'We architect transformative AI, cloud, and cybersecurity solutions that propel enterprises across the Middle East into the next era of innovation.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: isMobile ? 14 : 18,
                                  fontWeight: FontWeight.normal,
                                  height: 1.6,
                                  color: const Color(0xFF8894A8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 48),

                        // CTAs
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 16,
                          runSpacing: 12,
                          children: [
                            TechWiseButton(
                              text: 'Get Started',
                              borderRadius: 8,
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 28 : 36,
                                vertical: 16,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const BookMeetingPage(),
                                  ),
                                );
                              },
                            ),
                            TechWiseButton(
                              text: 'Our Services',
                              isOutline: true,
                              textColor: AppColors.white,
                              borderRadius: 8,
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 28 : 36,
                                vertical: 16,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ServicesPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 80),

                        // Trust Metrics
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: isMobile ? 24 : 48,
                            runSpacing: 16,
                            children: [
                              _HeroMetric('150+', 'Enterprise Clients'),
                              if (!isMobile) _HeroDivider(),
                              _HeroMetric('99.9%', 'Uptime SLA'),
                              if (!isMobile) _HeroDivider(),
                              _HeroMetric('24/7', 'Support'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ── Particle Network Custom Painter ─────────────────────────────────────
class _ParticleNetworkPainter extends CustomPainter {
  final List<_Particle> particles;
  final double connectionDistance;
  final Offset? mousePosition;
  final double mouseRepelRadius;

  _ParticleNetworkPainter({
    required this.particles,
    required this.connectionDistance,
    this.mousePosition,
    required this.mouseRepelRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()..strokeWidth = 2.0;
    final dotPaint = Paint();

    // ── Draw connecting lines ──────────────────────────────────────
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final dx = particles[i].x - particles[j].x;
        final dy = particles[i].y - particles[j].y;
        final dist = sqrt(dx * dx + dy * dy);

        if (dist < connectionDistance) {
          final alpha = (1 - dist / connectionDistance) * 0.75;

          // If mouse is near the midpoint, fade lines more
          double mouseFade = 1.0;
          if (mousePosition != null) {
            final midX = (particles[i].x + particles[j].x) / 2;
            final midY = (particles[i].y + particles[j].y) / 2;
            final mDist = sqrt(
              (midX - mousePosition!.dx) * (midX - mousePosition!.dx) +
                  (midY - mousePosition!.dy) * (midY - mousePosition!.dy),
            );
            if (mDist < mouseRepelRadius) {
              mouseFade = mDist / mouseRepelRadius;
            }
          }

          linePaint.color = Color.fromRGBO(
            0,
            212,
            255, // AppColors.cyan RGB
            alpha * mouseFade,
          );

          canvas.drawLine(
            Offset(particles[i].x, particles[i].y),
            Offset(particles[j].x, particles[j].y),
            linePaint,
          );
        }
      }
    }

    // ── Draw dots ───────────────────────────────────────────────────
    for (final p in particles) {
      double mouseFade = 1.0;
      if (mousePosition != null) {
        final dx = p.x - mousePosition!.dx;
        final dy = p.y - mousePosition!.dy;
        final dist = sqrt(dx * dx + dy * dy);
        if (dist < mouseRepelRadius * 0.7) {
          mouseFade = dist / (mouseRepelRadius * 0.7);
        }
      }

      // Outer glow
      dotPaint.color = Color.fromRGBO(0, 212, 255, p.opacity * 0.2 * mouseFade);
      canvas.drawCircle(Offset(p.x, p.y), p.radius * 3.0, dotPaint);

      // Core dot
      dotPaint.color = Color.fromRGBO(0, 212, 255, p.opacity * 0.8 * mouseFade);
      canvas.drawCircle(Offset(p.x, p.y), p.radius, dotPaint);
    }

    // ── Mouse cursor glow ring ──────────────────────────────────────
    if (mousePosition != null) {
      final glowPaint =
          Paint()
            ..color = Color.fromRGBO(0, 212, 255, 0.06)
            ..style = PaintingStyle.fill;
      canvas.drawCircle(mousePosition!, mouseRepelRadius * 0.8, glowPaint);

      final ringPaint =
          Paint()
            ..color = Color.fromRGBO(0, 212, 255, 0.12)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0;
      canvas.drawCircle(mousePosition!, mouseRepelRadius * 0.8, ringPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticleNetworkPainter oldDelegate) => true;
}

// ── Hero Metric ─────────────────────────────────────────────────────────
class _HeroMetric extends StatelessWidget {
  final String value;
  final String label;
  const _HeroMetric(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppColors.cyan,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: const Color(0xFF5A6478),
          ),
        ),
      ],
    );
  }
}

class _HeroDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: AppColors.white.withValues(alpha: 0.08),
      margin: const EdgeInsets.symmetric(horizontal: 48),
    );
  }
}

class _ServicesSection extends StatelessWidget {
  const _ServicesSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      color: const Color(0xFF0A0F1F), // #0A0F1F
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 80,
      ),
      child: Column(
        children: [
          // Header
          SizedBox(
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
                    'OUR SERVICES',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      color: AppColors.cyan,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  header: true,
                  child: Text(
                    'Comprehensive IT Solutions for Your Business',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: isMobile ? 28 : 40,
                      fontWeight: FontWeight.w600,
                      height: 1.15,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'From intelligent automation to robust infrastructure, we deliver end-to-end technology services that drive growth and secure your digital assets.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    height: 1.6,
                    color: const Color(0xFF6B7A94),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // Cards Row 1
          RevealOnScroll(
            revealType: RevealType.slideLeft,
            delay: const Duration(milliseconds: 100),
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: [
                SizedBox(
                  width: isMobile ? double.infinity : 280,
                  child: const _ServiceCard(
                    'Software Development',
                    'Custom enterprise applications, mobile apps, and scalable platforms built with cutting-edge technologies.',
                    Icons.code,
                  ),
                ), // Approx Icon
                SizedBox(
                  width: isMobile ? double.infinity : 280,
                  child: const _ServiceCard(
                    'Full Stack Web Development',
                    'End-to-end web solutions from responsive frontends to robust backend APIs and database architecture.',
                    Icons.layers,
                  ),
                ),
                SizedBox(
                  width: isMobile ? double.infinity : 280,
                  child: const _ServiceCard(
                    'IT Infrastructure',
                    'Designing, deploying, and managing resilient IT infrastructure that ensures business continuity.',
                    Icons.dns,
                  ),
                ),
                SizedBox(
                  width: isMobile ? double.infinity : 280,
                  child: const _ServiceCard(
                    'Data Entry',
                    'Accurate and efficient data entry, processing, and management services for enterprises of all sizes.',
                    Icons.table_chart,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Cards Row 2
          RevealOnScroll(
            revealType: RevealType.slideRight,
            delay: const Duration(milliseconds: 200),
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: [
                SizedBox(
                  width: isMobile ? double.infinity : 350,
                  child: const _ServiceCard(
                    'Cyber Security Architecture',
                    'Enterprise-grade security frameworks, threat detection, and zero-trust architecture to protect your digital assets.',
                    Icons.security,
                  ),
                ),
                SizedBox(
                  width: isMobile ? double.infinity : 350,
                  child: const _ServiceCard(
                    'Computer Systems & Communications',
                    'Networking, communication systems, and unified infrastructure for seamless enterprise connectivity.',
                    Icons.settings_input_antenna,
                  ),
                ),
                SizedBox(
                  width: isMobile ? double.infinity : 350,
                  child: const _ServiceCard(
                    'Equipment & Software Design',
                    'Hardware-software integration, embedded systems, and bespoke equipment design for idle-specific needs.',
                    Icons.memory,
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

class _ServiceCard extends StatelessWidget {
  final String title;
  final String desc;
  final IconData icon;

  const _ServiceCard(this.title, this.desc, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1526),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.cyan.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Icon(icon, color: AppColors.cyan, size: 20)),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            desc,
            style: GoogleFonts.inter(
              fontSize: 13,
              height: 1.6,
              color: const Color(0xFF6B7A94),
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      color: AppColors.primaryDark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 80,
      ),
      child:
          isMobile
              ? Column(
                children: [
                  // Image
                  RevealOnScroll(
                    revealType: RevealType.slideRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: Image.asset(
                          'assets/images/dubaiimg.JPEG',
                          fit: BoxFit.cover,
                          errorBuilder:
                              (_, __, ___) =>
                                  Container(color: AppColors.secondaryDark),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  // Content
                  RevealOnScroll(
                    revealType: RevealType.slideLeft,
                    delay: const Duration(milliseconds: 150),
                    child: _AboutContent(isMobile: isMobile),
                  ),
                ],
              )
              : Row(
                children: [
                  // Image
                  Expanded(
                    flex: 5,
                    child: RevealOnScroll(
                      revealType: RevealType.slideRight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          height: 420,
                          child: Image.asset(
                            'assets/images/dubaiimg.JPEG',
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) =>
                                    Container(color: AppColors.secondaryDark),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 64),
                  // Content
                  Expanded(
                    flex: 6,
                    child: RevealOnScroll(
                      revealType: RevealType.slideLeft,
                      delay: const Duration(milliseconds: 150),
                      child: _AboutContent(isMobile: isMobile),
                    ),
                  ),
                ],
              ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  final bool isMobile;
  const _AboutContent({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.cyan.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'ABOUT US',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
              color: AppColors.cyan,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Semantics(
          header: true,
          child: Text(
            'Dubai\'s Trusted Technology Partner Since Day One',
            style: GoogleFonts.cormorantGaramond(
              fontSize: isMobile ? 32 : 36,
              fontWeight: FontWeight.w600,
              height: 1.2,
              color: AppColors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Based in the heart of Dubai, TechWiseIQ is a premier IT solutions company dedicated to empowering businesses with intelligent technology. We combine deep technical expertise with a passion for innovation to deliver solutions that transform how enterprises operate in the digital age.',
          style: GoogleFonts.inter(
            fontSize: 15,
            height: 1.7,
            color: const Color(0xFF6B7A94),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Our team of seasoned engineers, architects, and consultants works hand-in-hand with clients across the Middle East to bridge the gap between ambition and execution.',
          style: GoogleFonts.inter(
            fontSize: 15,
            height: 1.7,
            color: const Color(0xFF6B7A94),
          ),
        ),
      ],
    );
  }
}

class _WhyChooseUsSection extends StatelessWidget {
  const _WhyChooseUsSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      color: AppColors.secondaryDark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 80,
      ),
      child: Column(
        children: [
          // Header
          SizedBox(
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
                    'WHY CHOOSE US',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      color: AppColors.cyan,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  header: true,
                  child: Text(
                    'Built for Performance, Designed for Growth',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: isMobile ? 28 : 40,
                      fontWeight: FontWeight.w600,
                      height: 1.15,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // Grid
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              SizedBox(
                width: isMobile ? double.infinity : 280,
                child: const _FeatureCard(
                  '01',
                  'Dubai-Based Expertise',
                  'Deep understanding of the Middle East market and regulatory landscape.',
                ),
              ),
              SizedBox(
                width: isMobile ? double.infinity : 280,
                child: const _FeatureCard(
                  '02',
                  '24/7 Dedicated Support',
                  'Round-the-clock monitoring and rapid incident response for your systems.',
                ),
              ),
              SizedBox(
                width: isMobile ? double.infinity : 280,
                child: const _FeatureCard(
                  '03',
                  'Scalable Solutions',
                  'Infrastructure and software that grows with your business demands.',
                ),
              ),
              SizedBox(
                width: isMobile ? double.infinity : 280,
                child: const _FeatureCard(
                  '04',
                  'Certified Professionals',
                  'Industry-certified engineers with proven track records across domains.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String num;
  final String title;
  final String desc;

  const _FeatureCard(this.num, this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1526),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            num,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: AppColors.cyan.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              height: 1.5,
              color: const Color(0xFF6B7A94),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      color: AppColors.primaryDark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 48 : 64,
      ),
      child: RevealOnScroll(
        revealType: RevealType.scale,
        child:
            isMobile
                ? Wrap(
                  spacing: 32,
                  runSpacing: 40,
                  alignment: WrapAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: _StatItem('150+', 'Projects Delivered', isMobile),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: _StatItem('50+', 'Enterprise Clients', isMobile),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: _StatItem('99.9%', 'Uptime Guaranteed', isMobile),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: _StatItem('10+', 'Years Experience', isMobile),
                    ),
                  ],
                )
                : Row(
                  children: [
                    Expanded(
                      child: _StatItem('150+', 'Projects Delivered', isMobile),
                    ),
                    Container(
                      width: 1,
                      height: 64,
                      color: AppColors.white.withValues(alpha: 0.1),
                    ),
                    Expanded(
                      child: _StatItem('50+', 'Enterprise Clients', isMobile),
                    ),
                    Container(
                      width: 1,
                      height: 64,
                      color: AppColors.white.withValues(alpha: 0.1),
                    ),
                    Expanded(
                      child: _StatItem('99.9%', 'Uptime Guaranteed', isMobile),
                    ),
                    Container(
                      width: 1,
                      height: 64,
                      color: AppColors.white.withValues(alpha: 0.1),
                    ),
                    Expanded(
                      child: _StatItem('10+', 'Years Experience', isMobile),
                    ),
                  ],
                ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String val;
  final String label;
  final bool isMobile;

  const _StatItem(this.val, this.label, [this.isMobile = false]);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          val,
          style: GoogleFonts.cormorantGaramond(
            fontSize: isMobile ? 36 : 48,
            fontWeight: FontWeight.w600,
            color: AppColors.cyan,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF6B7A94),
          ),
        ),
      ],
    );
  }
}

// ── Infinite Marquee Widget ─────────────────────────────────────────────
class _InfiniteMarquee extends StatefulWidget {
  final List<Widget> children;
  final double velocity;
  final bool reverse;
  final double gap;

  const _InfiniteMarquee({
    required this.children,
    this.velocity = 50.0,
    this.reverse = false,
    this.gap = 20.0,
  });

  @override
  State<_InfiniteMarquee> createState() => _InfiniteMarqueeState();
}

class _InfiniteMarqueeState extends State<_InfiniteMarquee>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animController;
  final GlobalKey _flexKey = GlobalKey();
  double _contentWidth = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Will be updated
    )..addListener(() {
      if (_scrollController.hasClients && _contentWidth > 0) {
        double offset = _animController.value * _contentWidth;
        if (widget.reverse) {
          offset = _contentWidth - offset;
        }
        _scrollController.jumpTo(offset);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateWidth());
  }

  void _calculateWidth() {
    final context = _flexKey.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      _contentWidth = box.size.width;

      if (_contentWidth > 0) {
        final duration = Duration(
          milliseconds: ((_contentWidth / widget.velocity) * 1000).toInt(),
        );
        _animController.duration = duration;
        _animController.repeat();
      }
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = [];
    for (int i = 0; i < widget.children.length; i++) {
      rowChildren.add(widget.children[i]);
      rowChildren.add(SizedBox(width: widget.gap));
    }

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: [
          Row(key: _flexKey, children: rowChildren),
          Row(children: rowChildren),
          Row(children: rowChildren),
          Row(children: rowChildren),
        ],
      ),
    );
  }
}

// Simplified Testimonials (Marquee)
class _TestimonialsSection extends StatelessWidget {
  const _TestimonialsSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      color: AppColors.secondaryDark,
      padding: EdgeInsets.symmetric(vertical: isMobile ? 60 : 80),
      child: Column(
        children: [
          // Header
          RevealOnScroll(
            revealType: RevealType.fadeUp,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cyan.withValues(alpha: 0.04), // #00D4FF08
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'WHAT OUR CLIENTS SAY',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.5,
                      color: AppColors.cyan,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  header: true,
                  child: Text(
                    'Trusted by Industry Leaders',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: isMobile ? 32 : 42,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Join 150+ enterprises that trust TechWiseIQ to power their digital transformation',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: const Color(0xFF4A5B75),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          RevealOnScroll(
            revealType: RevealType.slideLeft,
            child: _InfiniteMarquee(
              velocity: 40.0,
              gap: 20.0,
              children: const [
                _TestimonialCard(
                  'TechWiseIQ transformed our entire IT infrastructure. Their cloud migration reduced our operational costs by 40% while improving performance.',
                  AppColors.cyan,
                ),
                _TestimonialCard(
                  'Their cybersecurity team identified vulnerabilities we didn\'t know existed. Professional, thorough, and incredibly responsive.',
                  Color(0xFFFF6B35),
                ),
                _TestimonialCard(
                  'The full-stack platform they built handles 10x traffic with half the latency. True engineering excellence from a world-class team.',
                  Color(0xFFA855F7),
                ),
                _TestimonialCard(
                  'Their IT infrastructure redesign was seamless. Zero downtime migration and our systems are now 3x more resilient.',
                  Color(0xFF10B981),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          RevealOnScroll(
            revealType: RevealType.slideRight,
            child: _InfiniteMarquee(
              velocity: 40.0,
              reverse: true,
              gap: 20.0,
              children: const [
                _TestimonialCard(
                  'Exceptional security architecture. They implemented a zero-trust framework that passed every compliance audit with flying colors.',
                  Color(0xFFEC4899),
                ),
                _TestimonialCard(
                  'The software design and hardware integration they delivered was flawless. Our custom equipment now runs 5x faster.',
                  Color(0xFF6366F1),
                ),
                _TestimonialCard(
                  'From concept to deployment in 8 weeks. Their AI-powered analytics platform gave us a competitive edge nobody expected.',
                  Color(0xFF00D4FF),
                ),
                _TestimonialCard(
                  'Outstanding proactive support. We haven\'t faced a single minute of unexpected downtime since migrating to their systems.',
                  Color(0xFFFFB020),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String quote;
  final Color tagColor;

  const _TestimonialCard(this.quote, this.tagColor);
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      width: isMobile ? 300 : 380,
      padding: EdgeInsets.all(isMobile ? 20 : 28),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1324),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"$quote"',
            style: GoogleFonts.inter(
              fontSize: 13,
              height: 1.65,
              color: const Color(0xFF6B7A94),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: tagColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

class _FinalCTASection extends StatelessWidget {
  const _FinalCTASection();
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      color: AppColors.primaryDark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 120,
        vertical: isMobile ? 60 : 80,
      ),
      child: RevealOnScroll(
        revealType: RevealType.scale,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 48 : 64,
            horizontal: isMobile ? 24 : 80,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF0D1526),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Semantics(
                header: true,
                child: Text(
                  'Ready to Transform Your Business?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: isMobile ? 32 : 40,
                    fontWeight: FontWeight.w600,
                    height: 1.15,
                    color: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Let\'s discuss how TechWiseIQ can architect the perfect technology solution for your enterprise. Book a free consultation today.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  height: 1.6,
                  color: const Color(0xFF6B7A94),
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: [
                  TechWiseButton(
                    text: 'Book a Consultation',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BookMeetingPage(),
                        ),
                      );
                    },
                    borderRadius: 8,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 36,
                      vertical: 16,
                    ),
                  ),
                  TechWiseButton(
                    text: 'Explore Services',
                    isOutline: true,
                    textColor: AppColors.white,
                    borderRadius: 8,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 36,
                      vertical: 16,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ServicesPage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
