import '../../core/app-export.dart';

class AnalysisCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final VoidCallback? onTap;

  // New: Optional styling overrides
  final double? valueFontSize;
  final FontWeight? valueFontWeight;
  final bool? forceLargeFont;

  const AnalysisCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.onTap,
    this.valueFontSize,
    this.valueFontWeight,
    this.forceLargeFont,
  });

  // Auto-detect large number (same as before)
  bool get _isLargeNumber {
    final trimmed = value.trim();
    final clean = trimmed.replaceAll(RegExp(r'[,\s]'), '');
    if (clean.isEmpty) return false;

    final isNumeric =
        int.tryParse(clean) != null || double.tryParse(clean) != null;
    final isShort = trimmed.length <= 10;
    return isNumeric && isShort;
  }

  @override
  Widget build(BuildContext context) {
    // Decide if we use large font
    final bool useLargeFont =
        forceLargeFont ??
        (valueFontSize == null && _isLargeNumber); // Only auto if no override

    // Final font size
    final double finalFontSize =
        valueFontSize ?? (useLargeFont ? 20.sp : 14.sp);

    // Final font weight
    final FontWeight finalFontWeight =
        valueFontWeight ?? (useLargeFont ? FontWeight.w600 : FontWeight.w500);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      splashColor: Colors.grey.withOpacity(0.1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey[100]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: iconBgColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      color: Colors.grey[800],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Value Text - Fully Customizable
            Text(
              value,
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: finalFontSize,
                fontWeight: finalFontWeight,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
