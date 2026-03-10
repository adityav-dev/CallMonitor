import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/app-export.dart';

class NoLogsWidget extends StatelessWidget {
  const NoLogsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'No call logs available',
      style: TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 16.sp,
        color: ColorConstants.grey,
      ),
    );
  }
}


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(color: ColorConstants.appThemeColor),
        const SizedBox(height: 16),
        Text(
          'Loading...',
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 16,
            color: ColorConstants.grey,
          ),
        ),
      ],
    );
  }
}

class LoadingMoreWidget extends StatelessWidget {
  const LoadingMoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: CircularProgressIndicator(color: ColorConstants.appThemeColor),
    );
  }
}