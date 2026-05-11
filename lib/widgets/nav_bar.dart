// TechWiseIQ — Responsive Navigation Bar
//
// A glassmorphism-style navigation bar that adapts to screen size:
// - Desktop (>= 900px): Horizontal nav links + CTA button
// - Mobile (< 900px): Logo + hamburger icon that opens a full-screen drawer
//
// Uses PageRouteBuilder with FadeTransition for smooth page transitions.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'techwise_button.dart';
import '../pages/home_page.dart';
import '../pages/about_page.dart';
import '../pages/services_page.dart';
import '../pages/contact_page.dart';
import '../pages/book_meeting_page.dart';

/// Top-level navigation bar widget — positioned at the top of every page.
class TechWiseNavBar extends StatelessWidget {
  const TechWiseNavBar({super.key});

  /// Navigates to [page] with a smooth fade transition.
  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: isMobile ? 12 : 18,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 40,
        vertical: isMobile ? 10 : 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo — navigates to home on tap
          _buildLogo(context),

          // Desktop: Horizontal nav links + CTA
          if (!isMobile) ...[
            Row(
              children: [
                _NavLink(title: 'About Us', destination: const AboutPage()),
                const SizedBox(width: 36),
                _NavLink(title: 'Services', destination: const ServicesPage()),
                const SizedBox(width: 36),
                _NavLink(title: 'Contact Us', destination: const ContactPage()),
              ],
            ),
            TechWiseButton(
              text: 'Book a Meeting',
              onPressed: () => _navigateTo(context, const BookMeetingPage()),
              borderRadius: 6,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ],

          // Mobile: Hamburger menu icon
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu, color: AppColors.white, size: 28),
              onPressed: () => _openMobileDrawer(context),
              splashRadius: 24,
            ),
        ],
      ),
    );
  }

  /// Builds the TechWise IQ logo.
  Widget _buildLogo(BuildContext context) {
    return InkWell(
      onTap: () => _navigateTo(context, const HomePage()),
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'TechWise IQ',
            style: GoogleFonts.raleway(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: AppColors.white,
            ),
          ),
          Text(
            'TECHNOLOGIES',
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              letterSpacing: 3,
              color: AppColors.cyan.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  /// Opens a full-screen modal drawer for mobile navigation.
  void _openMobileDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => _MobileNavDrawer(
            onNavigate: (Widget page) {
              Navigator.pop(context);
              _navigateTo(context, page);
            },
          ),
    );
  }
}

/// Full-screen mobile navigation drawer with animated links.
class _MobileNavDrawer extends StatelessWidget {
  final void Function(Widget page) onNavigate;
  const _MobileNavDrawer({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Color(0xFF0A0F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 40),
            // Navigation links
            _MobileNavLink(
              title: 'Home',
              icon: Icons.home_outlined,
              onTap: () => onNavigate(const HomePage()),
            ),
            _MobileNavLink(
              title: 'About Us',
              icon: Icons.info_outlined,
              onTap: () => onNavigate(const AboutPage()),
            ),
            _MobileNavLink(
              title: 'Services',
              icon: Icons.design_services_outlined,
              onTap: () => onNavigate(const ServicesPage()),
            ),
            _MobileNavLink(
              title: 'Contact Us',
              icon: Icons.mail_outlined,
              onTap: () => onNavigate(const ContactPage()),
            ),
            const SizedBox(height: 32),
            // CTA Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TechWiseButton(
                text: 'Book a Meeting',
                width: double.infinity,
                borderRadius: 8,
                padding: const EdgeInsets.symmetric(vertical: 16),
                onPressed: () => onNavigate(const BookMeetingPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual link item in the mobile navigation drawer.
class _MobileNavLink extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const _MobileNavLink({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.cyan, size: 22),
            const SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Desktop nav link with hover effect.
class _NavLink extends StatefulWidget {
  final String title;
  final Widget destination;
  const _NavLink({required this.title, required this.destination});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) =>
                      widget.destination,
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        },
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: _hovering ? FontWeight.w500 : FontWeight.normal,
            color:
                _hovering
                    ? AppColors.white
                    : AppColors.white.withValues(alpha: 0.7),
          ),
          child: Text(widget.title),
        ),
      ),
    );
  }
}
