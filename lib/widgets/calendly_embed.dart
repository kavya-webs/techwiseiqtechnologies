import 'package:flutter/material.dart';

import 'calendly_embed_stub.dart'
    if (dart.library.html) 'calendly_embed_web.dart' as cal_impl;

/// Inline Calendly on web (iframe); opens external Calendly on mobile/desktop.
class CalendlyBookingEmbed extends StatelessWidget {
  final double height;

  const CalendlyBookingEmbed({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return cal_impl.buildCalendlyEmbed(height: height);
  }
}
