// TechWiseIQ — Privacy Policy
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../site_config.dart';
import '../theme/app_colors.dart';
import '../widgets/footer.dart';
import '../widgets/nav_bar.dart';
import '../widgets/reveal_on_scroll.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
                            'Privacy Policy',
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
                            'TechWise IQ Technologies (“we”, “us”, or “our”) respects your privacy. '
                            'This policy explains how we handle information when you visit our website or contact us.',
                          ),
                          _h('Information we collect'),
                          _p(
                            'We may collect information you provide voluntarily, such as your name, email address, '
                            'phone number, company name, and message content when you use our contact forms, '
                            'book a meeting, or email us at ${SiteConfig.contactEmail}.',
                          ),
                          _p(
                            'Like most websites, our hosting and analytics tools may automatically log technical data '
                            '(for example browser type, general region, and pages visited) to keep the site secure and improve performance.',
                          ),
                          _h('How we use information'),
                          _p(
                            'We use this information to respond to inquiries, schedule consultations, provide our services, '
                            'and improve our website. We do not sell your personal information.',
                          ),
                          _h('Cookies and similar technologies'),
                          _p(
                            'We may use cookies or similar technologies where needed for site functionality or analytics. '
                            'You can control cookies through your browser settings.',
                          ),
                          _h('Third-party services'),
                          _p(
                            'Some features (such as scheduling) may be provided by trusted third parties—for example, '
                            'Calendly. Their use of data is governed by their own policies when you use their services.',
                          ),
                          _h('Data retention and security'),
                          _p(
                            'We retain information only as long as needed for the purposes above or as required by law. '
                            'We apply reasonable safeguards appropriate to the nature of the data we hold.',
                          ),
                          _h('Your rights'),
                          _p(
                            'Depending on applicable law, you may have the right to access, correct, or delete certain '
                            'personal data, or to object to some processing. Contact us using the details below to make a request.',
                          ),
                          _h('Contact'),
                          _p(
                            'Questions about this policy: ${SiteConfig.contactEmail}',
                          ),
                          _h('Changes'),
                          _p(
                            'We may update this policy from time to time. The “Last updated” date at the top will change when we do.',
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
