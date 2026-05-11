// TechWiseIQ — Responsive Footer
//
// Site-wide footer that adapts to screen size:
// - Desktop (>= 900px): 4-column horizontal layout
// - Mobile (< 900px): Single-column stacked layout
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'section_container.dart';
import '../pages/about_page.dart';
import '../pages/services_page.dart';
import '../pages/contact_page.dart';

/// Site-wide footer — placed at the bottom of every page.
class TechWiseFooter extends StatelessWidget {
  const TechWiseFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF050A14),
        border: Border(top: BorderSide(color: Color(0xFF0E1A30), width: 1)),
      ),
      child: SectionContainer(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 80,
          vertical: isMobile ? 48 : 72,
        ),
        child: Column(
          children: [
            if (isMobile)
              _buildMobileLayout(context)
            else
              _buildDesktopLayout(context),
            SizedBox(height: isMobile ? 32 : 56),
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    const Color(0xFF1A2744).withValues(alpha: 0.6),
                    const Color(0xFF1A2744),
                    const Color(0xFF1A2744).withValues(alpha: 0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            SizedBox(height: isMobile ? 20 : 32),
            if (isMobile) _buildMobileCopyright() else _buildDesktopCopyright(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildBrandColumn()),
        const SizedBox(width: 40),
        Expanded(
          flex: 2,
          child: _FooterNavColumn(
            title: 'Services',
            links: const [
              'Software Development',
              'Cloud Solutions',
              'Cybersecurity',
              'Data Analytics',
            ],
            destination: const ServicesPage(),
          ),
        ),
        Expanded(
          flex: 2,
          child: _FooterNavColumn(
            title: 'Company',
            linkDestinations: const {
              'About Us': 'about',
              'Careers': 'about',
              'Contact': 'contact',
              'Privacy Policy': null,
            },
          ),
        ),
        Expanded(flex: 3, child: _buildContactColumn()),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandColumn(),
        const SizedBox(height: 32),
        _FooterNavColumn(
          title: 'Services',
          links: const [
            'Software Development',
            'Cloud Solutions',
            'Cybersecurity',
            'Data Analytics',
          ],
          destination: const ServicesPage(),
        ),
        const SizedBox(height: 32),
        _FooterNavColumn(
          title: 'Company',
          linkDestinations: const {
            'About Us': 'about',
            'Careers': 'about',
            'Contact': 'contact',
            'Privacy Policy': null,
          },
        ),
        const SizedBox(height: 32),
        _buildContactColumn(),
      ],
    );
  }

  Widget _buildBrandColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
            'assets/images/Logo.png',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
            alignment: Alignment.centerLeft,
            errorBuilder: (context, error, stackTrace) {
              return Text(
                'TechWise IQ Technologies',
                style: GoogleFonts.raleway(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 320,
          child: Text(
            'Empowering businesses with intelligent technology. We bridge the gap between ambition and execution.',
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.7,
              color: const Color(0xFF5A6478),
            ),
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }

  Widget _buildContactColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get in Touch',
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 24),
        const _ContactItem(
          icon: Icons.location_on_outlined,
          text:
              'Suite 3204, Aspect Tower,\nBusiness Bay, Dubai,\nUnited Arab Emirates',
        ),
        const SizedBox(height: 18),
        const _ContactItem(
          icon: Icons.email_outlined,
          text: 'hello@techwiseiq.com',
        ),
        const SizedBox(height: 18),
        const _ContactItem(icon: Icons.phone_outlined, text: '+971 50 3150751'),
      ],
    );
  }

  Widget _buildDesktopCopyright() {
    return Builder(
      builder:
          (context) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2026 TechWise IQ Technologies. All rights reserved.',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF3A4560),
                ),
              ),
              Row(
                children: [
                  _FooterBottomLink('Privacy Policy'),
                  const SizedBox(width: 24),
                  _FooterBottomLink('Terms of Service'),
                  const SizedBox(width: 24),
                  _FooterBottomLink('Sitemap'),
                ],
              ),
            ],
          ),
    );
  }

  Widget _buildMobileCopyright() {
    return Builder(
      builder:
          (context) => Column(
            children: [
              Wrap(
                spacing: 16,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  _FooterBottomLink('Privacy Policy'),
                  _FooterBottomLink('Terms of Service'),
                  _FooterBottomLink('Sitemap'),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '© 2026 TechWise IQ Technologies. All rights reserved.',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF3A4560),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
    );
  }
}

class _FooterNavColumn extends StatelessWidget {
  final String title;
  final List<String>? links;
  final Widget? destination;
  final Map<String, String?>? linkDestinations;
  const _FooterNavColumn({
    required this.title,
    this.links,
    this.destination,
    this.linkDestinations,
  });

  void _navigate(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a, sa) => page,
        transitionsBuilder:
            (c, a, sa, child) => FadeTransition(opacity: a, child: child),
      ),
    );
  }

  Widget? _getDestination(String label) {
    if (destination != null) return destination;
    if (linkDestinations != null) {
      final key = linkDestinations![label];
      if (key == 'about') return const AboutPage();
      if (key == 'contact') return const ContactPage();
      if (key == 'services') return const ServicesPage();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final items = links ?? linkDestinations?.keys.toList() ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 24),
        ...items.map((link) {
          final dest = _getDestination(link);
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: MouseRegion(
              cursor:
                  dest != null
                      ? SystemMouseCursors.click
                      : SystemMouseCursors.basic,
              child: GestureDetector(
                onTap: dest != null ? () => _navigate(context, dest) : null,
                child: Text(
                  link,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF5A6478),
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _ContactItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.cyan.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 14, color: AppColors.cyan),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.6,
              color: const Color(0xFF5A6478),
            ),
          ),
        ),
      ],
    );
  }
}

class _FooterBottomLink extends StatelessWidget {
  final String text;
  const _FooterBottomLink(this.text);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(text),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: const Color(0xFF3A4560),
          ),
        ),
      ),
    );
  }
}
