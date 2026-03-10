import '../../core/app-export.dart';
import '../../data/model/analytics_model/call_data_model.dart';

class CallCard extends StatelessWidget {
  final CallData call;
  final bool showSubCalls;

  const CallCard({super.key, required this.call, this.showSubCalls = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// -------- Top Row: Avatar + Name + Icons --------
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Missed call icon circle
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Color(0xffc62828),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.phone_missed,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),

                // Expanded section for name and number
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        call.name.isNotEmpty ? call.name : "Unknown",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        call.phoneNumber,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: Colors.black54,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Compact icons (without extra IconButton padding)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _compactIcon(Icons.copy_outlined, Colors.grey),
                    SizedBox(width: 4.w),
                    _compactIcon(Icons.message_outlined, Colors.blue),
                    SizedBox(width: 4.w),
                    _compactIcon(Icons.message, Colors.green),
                    SizedBox(width: 4.w),
                    _compactIcon(Icons.call, Colors.blue),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// -------- Bottom Row: Call info --------
            if (showSubCalls)
              Column(
                children: List.generate(3, (i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${i + 1}", style: _subTextStyle()),
                        Text("a day ago", style: _subTextStyle()),
                        Text("31 Oct 2025", style: _subTextStyle()),
                        Text("02:4${i} PM", style: _subTextStyle()),
                      ],
                    ),
                  );
                }),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(call.callCount, style: _subTextStyle(fontSize: 12.5)),
                  Text(call.date, style: _subTextStyle(fontSize: 12.5)),
                  Text(call.time, style: _subTextStyle(fontSize: 12.5)),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Compact icon widget — fixes right spacing issue
  Widget _compactIcon(IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Icon(icon, color: color, size: 18),
    );
  }

  TextStyle _subTextStyle({double fontSize = 11}) {
    return TextStyle(
      color: Colors.grey[600],
      fontSize: fontSize.sp,
      fontFamily: AppFonts.poppins,
    );
  }
}
