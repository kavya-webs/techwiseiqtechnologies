import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

import 'dart:ui_web' as ui_web;

import '../site_config.dart';

bool _registered = false;
const String _viewType = 'techwise-calendly-booking';

Widget buildCalendlyEmbed({required double height}) {
  if (!_registered) {
    _registered = true;
    ui_web.platformViewRegistry.registerViewFactory(
      _viewType,
      (int viewId) {
        final iframe = web.HTMLIFrameElement()
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..src = SiteConfig.calendlyBookingUrl;
        return iframe;
      },
    );
  }
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: SizedBox(
      width: double.infinity,
      height: height,
      child: const HtmlElementView(viewType: _viewType),
    ),
  );
}
