import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../site_config.dart';
import '../theme/app_colors.dart';

Widget buildCalendlyEmbed({required double height}) {
  return SizedBox(
    height: height,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_month, size: 48, color: AppColors.cyan),
            const SizedBox(height: 16),
            Text(
              'Schedule your call',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Open Calendly in your browser to pick a time.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () async {
                final uri = Uri.parse(SiteConfig.calendlyBookingUrl);
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              },
              icon: const Icon(Icons.open_in_new),
              label: const Text('Open Calendly'),
            ),
          ],
        ),
      ),
    ),
  );
}
