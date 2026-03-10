import '../../../core/app-export.dart';
import '../../../data/model/analysis_models/call_stats_model.dart';

class CallStatsCard extends StatelessWidget {
  final CallStatsModel data;
  final VoidCallback? onTap;

  const CallStatsCard({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                _buildProfileSection(),
                const SizedBox(height: 14),
                _buildStatsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFFFFB800), Color(0xFFFF8A00)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey[200],
              backgroundImage: data.profileImage != null
                  ? NetworkImage(data.profileImage!)
                  : null,
              child: data.profileImage == null
                  ? Text(
                      _getInitials(data.name),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFFB800),
                      ),
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          data.name,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: AppFonts.poppins,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2D3436),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildStatRow(
            icon: Icons.phone_android_rounded,
            label: 'Phone',
            value: data.phoneNumber,
            iconColor: Colors.grey[700],
            isFirst: true,
          ),
          ...data.stats.asMap().entries.map((entry) {
            final isLast = entry.key == data.stats.length - 1;
            final stat = entry.value;
            return _buildStatRow(
              icon: stat.icon,
              label: stat.label,
              value: stat.value,
              iconColor: stat.iconColor,
              isLast: isLast,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStatRow({
    required IconData icon,
    required String label,
    required String value,
    Color? iconColor,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Colors.grey[200]!, width: 0.8)),
        borderRadius: isFirst
            ? const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              )
            : isLast
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )
            : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: (iconColor ?? Colors.grey[700])!.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor ?? Colors.grey[700], size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: AppFonts.poppins,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2D3436),
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    List<String> parts = name.trim().split(' ');
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
}
