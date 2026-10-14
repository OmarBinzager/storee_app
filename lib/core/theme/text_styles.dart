import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

abstract final class AppTextStyles {
  // Base font is IBM Plex Sans Arabic
  static TextStyle get _baseFont => GoogleFonts.ibmPlexSansArabic();

  // Headings
  static TextStyle get headingLarge => _baseFont.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get headingMedium => _baseFont.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.35,
      );

  static TextStyle get headingSmall => _baseFont.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // Subtitles & Section titles
  static TextStyle get subtitleLarge => _baseFont.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get subtitleMedium => _baseFont.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  // Body text
  static TextStyle get bodyLarge => _baseFont.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodyMedium => _baseFont.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodySmall => _baseFont.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  // Money & Numeric Highlights
  static TextStyle get moneyLarge => _baseFont.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
        letterSpacing: 0.5,
      );

  static TextStyle get moneyMedium => _baseFont.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
      );

  static TextStyle get moneySmall => _baseFont.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  // Button Labels & Badges
  static TextStyle get buttonLabel => _baseFont.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  static TextStyle get badgeLabel => _baseFont.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      );
}
