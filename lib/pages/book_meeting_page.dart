// TechWiseIQ - Book a Meeting Page
// Schedule a free consultation. Hero + Calendly placeholder + Why Book cards.
// All sections adapt to mobile (< 900px) via MediaQuery breakpoints.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../widgets/reveal_on_scroll.dart';

class BookMeetingPage extends StatelessWidget {
  const BookMeetingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: const [
                _BookHero(),
                _Calendly(),
                _WhyBook(),
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

class _BookHero extends StatelessWidget {
  const _BookHero();
  @override
  Widget build(BuildContext context) {
    final m = MediaQuery.of(context).size.width < 900;
    return SizedBox(
      height: m ? 420 : 600,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/generated-1771418298230.png',
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(color: AppColors.secondaryDark),
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
                    Color(0xCC060B18),
                    Color(0x60060B18),
                    Color(0xEE060B18),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: RevealOnScroll(
              revealType: RevealType.fadeUp,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: m ? 24 : 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: m ? 60 : 80),
                    SizedBox(
                      width: m ? double.infinity : 700,
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
                              'SCHEDULE A CALL',
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
                            "Let's Discuss Your Vision",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: m ? 32 : 56,
                              fontWeight: FontWeight.w600,
                              height: 1.1,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Book a free discovery call with our experts. No hard selling, just a conversation about your business goals.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: m ? 14 : 18,
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
          ),
        ],
      ),
    );
  }
}

class _Calendly extends StatelessWidget {
  const _Calendly();
  @override
  Widget build(BuildContext context) {
    final m = MediaQuery.of(context).size.width < 900;
    return Container(
      color: AppColors.primaryDark,
      padding: EdgeInsets.symmetric(
        vertical: m ? 48 : 80,
        horizontal: m ? 24 : 120,
      ),
      child: Center(
        child: RevealOnScroll(
          revealType: RevealType.scale,
          child: Container(
            width: m ? double.infinity : 1000,
            height: m ? 400 : 700,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today,
                  size: m ? 48 : 64,
                  color: AppColors.grey,
                ),
                const SizedBox(height: 24),
                Text(
                  'Calendly Widget Placeholder',
                  style: GoogleFonts.inter(
                    fontSize: m ? 16 : 20,
                    color: AppColors.secondaryDark,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Use standard Calendly inline embed here.',
                  style: GoogleFonts.inter(
                    fontSize: m ? 12 : 14,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WhyBook extends StatelessWidget {
  const _WhyBook();
  @override
  Widget build(BuildContext context) {
    final m = MediaQuery.of(context).size.width < 900;
    return Container(
      color: const Color(0xFF0A0F1F),
      padding: EdgeInsets.all(m ? 24 : 80),
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
                      'WHY NOW?',
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
                    'Why Book a Meeting Today?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: m ? 28 : 40,
                      fontWeight: FontWeight.w600,
                      height: 1.15,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Every day without the right technology partner is a day your competition gains ground.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: m ? 14 : 16,
                      height: 1.6,
                      color: const Color(0xFF8894A8),
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
                m
                    ? Column(
                      children: const [
                        _Why(
                          'Rapid Technology Assessment',
                          'Expert evaluation of your IT landscape within 30 minutes.',
                        ),
                        SizedBox(height: 16),
                        _Why(
                          'Dubai-Based Expertise',
                          'Specialists who understand NESA compliance and local infrastructure.',
                        ),
                        SizedBox(height: 16),
                        _Why(
                          'Zero Obligation, Full Value',
                          'Free discovery calls with actionable insights.',
                        ),
                      ],
                    )
                    : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: _Why(
                            'Rapid Technology Assessment',
                            'Expert evaluation of your IT landscape within 30 minutes.',
                          ),
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: _Why(
                            'Dubai-Based Expertise',
                            'Specialists who understand NESA compliance and local infrastructure.',
                          ),
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: _Why(
                            'Zero Obligation, Full Value',
                            'Free discovery calls with actionable insights.',
                          ),
                        ),
                      ],
                    ),
          ),
          const SizedBox(height: 24),
          RevealOnScroll(
            revealType: RevealType.slideRight,
            delay: const Duration(milliseconds: 200),
            child:
                m
                    ? Column(
                      children: const [
                        _Why(
                          'Tailored Solutions',
                          'Consultations designed to understand your specific requirements.',
                        ),
                        SizedBox(height: 16),
                        _Why(
                          'Accelerate Your Growth',
                          '30% productivity gains with IT modernization.',
                        ),
                        SizedBox(height: 16),
                        _Why(
                          'Ongoing Support Guarantee',
                          'Continuous support from first call to deployment and beyond.',
                        ),
                      ],
                    )
                    : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: _Why(
                            'Tailored Solutions',
                            'Consultations designed to understand your specific requirements.',
                          ),
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: _Why(
                            'Accelerate Your Growth',
                            '30% productivity gains with IT modernization.',
                          ),
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: _Why(
                            'Ongoing Support Guarantee',
                            'Continuous support from first call to deployment and beyond.',
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

class _Why extends StatelessWidget {
  final String title, desc;
  const _Why(this.title, this.desc);
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
          child: const Icon(Icons.check, color: AppColors.cyan),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 17,
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
