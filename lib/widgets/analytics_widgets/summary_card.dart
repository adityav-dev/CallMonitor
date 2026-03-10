import '../../core/app-export.dart';

class AnalyticsCard extends StatelessWidget {
  final String title;
  final String count;
  final String? duration;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final bool isPremium;
  final VoidCallback? onTap;

  const AnalyticsCard({
    super.key,
    required this.title,
    required this.count,
    this.duration,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.isPremium = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.grey[100]!, // Light grey border
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row (icon + title)
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
                            fontSize: 12,
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

                  const SizedBox(height: 4),

                  // Count Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        count,
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  // Duration Row
                  if (duration != null) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          duration!,
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontSize: 12,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Premium Tag
            if (isPremium)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(14),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.workspace_premium,
                        color: Colors.white,
                        size: 12,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        'Premium',
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
