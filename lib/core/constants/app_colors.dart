import 'package:flutter/material.dart';

/// Defines the Storee "Soft Boutique" color palette.
/// Designed specifically for boutique sales managers with a calm, elegant, feminine touch.
abstract final class AppColors {
  // Brand Primary & Secondary
  static const Color primary = Color(0xFFA34863); // Berry Rose - Primary actions & identity
  static const Color primaryLight = Color(0xFFC76D88);
  static const Color primaryDark = Color(0xFF7A2941);

  static const Color secondary = Color(0xFFF7E8EC); // Blush Pink - Surfaces, container backgrounds
  static const Color secondaryLight = Color(0xFFFCF4F6);

  // Background & Surfaces
  static const Color background = Color(0xFFFFF9F4); // Soft Ivory - General canvas
  static const Color surface = Color(0xFFFFFFFF); // Pure white card surfaces
  static const Color surfaceElevated = Color(0xFFFFFDFC);

  // Semantic States
  static const Color success = Color(0xFF78927B); // Sage Green - Positive financial states & delivered
  static const Color successLight = Color(0xFFEBF1EC);

  static const Color warning = Color(0xFFC68B43); // Gold Accent - In-progress, partially paid, alerts
  static const Color warningLight = Color(0xFFFAF3EB);

  static const Color error = Color(0xFFD9534F); // Rosewood Coral - Debt, overdue, cancellations
  static const Color errorLight = Color(0xFFFDEEEC);

  static const Color info = Color(0xFF5B82A6); // Slate Blue - Informational snapshots
  static const Color infoLight = Color(0xFFEDF3F7);

  // Typography & Neutral Grayscale
  static const Color textPrimary = Color(0xFF343039); // Charcoal - Main readable text
  static const Color textSecondary = Color(0xFF6B6673); // Muted subtitles & labels
  static const Color textTertiary = Color(0xFF9E99A6); // Placeholders & dividers
  static const Color border = Color(0xFFEADBDF); // Soft border separating elements
  static const Color borderLight = Color(0xFFF4EDF0);

  // Financial Semantics
  static const Color profit = Color(0xFF5E8B62);
  static const Color expense = Color(0xFFC24953);
  static const Color receivable = Color(0xFFBA7A2C);
}
