// TechWiseIQ — Terms & Conditions
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../site_config.dart';
import '../theme/app_colors.dart';
import '../widgets/footer.dart';
import '../widgets/nav_bar.dart';
import '../widgets/reveal_on_scroll.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.of(context).size.width < 900 ? 24.0 : 80.0;
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(pad, 100, pad, 48),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Terms & Conditions',
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Last updated: May 2026',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppColors.grey,
                            ),
                          ),
                          const SizedBox(height: 32),
                          _p(
                            'These Terms & Conditions (“Terms”) govern your use of the TechWise IQ Technologies '
                            'website and related enquiry or booking flows. By using the site, you agree to these Terms.',
                          ),
                          _h('Services and information'),
                          _p(
                            'Content on this website describes our services in general terms. It does not form a binding '
                            'offer or contract. Specific services, deliverables, fees, and timelines are agreed only in a '
                            'separate written proposal or agreement between you and TechWise IQ Technologies.',
                          ),
                          _h('Use of the website'),
                          _p(
                            'You agree not to misuse the site (for example by attempting to disrupt security, overload systems, '
                            'or scrape content for unlawful purposes). We may suspend access where we reasonably believe '
                            'misuse has occurred.',
                          ),
                          _h('Intellectual property'),
                          _p(
                            'Branding, text, graphics, and layout on this site are owned by or licensed to us unless stated '
                            'otherwise. You may not copy or redistribute site materials for commercial use without our prior written consent.',
                          ),
                          _h('Third-party links and tools'),
                          _p(
                            'The site may link to or embed third-party tools (such as scheduling providers). We are not '
                            'responsible for their content or practices; use of those services is at your discretion and subject to their terms.',
                          ),
                          _h('Disclaimer'),
                          _p(
                            'The site is provided on an “as is” basis to the extent permitted by law. While we aim to keep '
                            'information accurate, we do not warrant that content is complete, current, or free from errors.',
                          ),
                          _h('Limitation of liability'),
                          _p(
                            'To the fullest extent permitted by applicable law, TechWise IQ Technologies and its team shall '
                            'not be liable for any indirect, incidental, or consequential loss arising from use of this website.',
                          ),
                          _h('Governing law'),
                          _p(
                            'These Terms are governed by the laws of the United Arab Emirates. Any disputes shall be subject '
                            'to the exclusive jurisdiction of the courts of Dubai, UAE, unless otherwise required by mandatory law.',
                          ),
                          _h('Changes'),
                          _p(
                            'We may update these Terms from time to time. Continued use of the site after changes constitutes '
                            'acceptance of the revised Terms.',
                          ),
                          _h('Contact'),
                          _p(
                            'Questions about these Terms: ${SiteConfig.contactEmail}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const RevealOnScroll(child: TechWiseFooter()),
              ],
            ),
          ),
          const Positioned(top: 0, left: 0, right: 0, child: TechWiseNavBar()),
        ],
      ),
    );
  }

  static Widget _h(String t) => Padding(
    padding: const EdgeInsets.only(top: 28, bottom: 12),
    child: Text(
      t,
      style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.cyan,
      ),
    ),
  );

  static Widget _p(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Text(
      t,
      style: GoogleFonts.inter(
        fontSize: 15,
        height: 1.65,
        color: const Color(0xFF8894A8),
      ),
    ),
  );
}
