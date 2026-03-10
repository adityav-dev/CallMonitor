// // ignore_for_file: must_be_immutable
// import 'dart:io';
// import '../../../app-export.dart';

// class CustomImageView extends StatelessWidget {
//   String? url;
//   String? cacheKey;
//   String? imagePath;
//   File? file;

//   double? height;
//   double? width;
//   Color? color;
//   BoxFit? fit;
//   final String placeHolder;
//   Alignment? alignment;
//   VoidCallback? onTap;
//   EdgeInsetsGeometry? margin;
//   BorderRadius? radius;
//   BoxBorder? border;

//   CustomImageView({
//     super.key,
//     this.url,
//     this.cacheKey,
//     this.imagePath,
//     this.file,
//     this.height,
//     this.width,
//     this.color,
//     this.fit,
//     this.alignment,
//     this.onTap,
//     this.radius,
//     this.margin,
//     this.border,
//     this.placeHolder = 'assets/images/image_not_found.png',
//   });

//   @override
//   Widget build(BuildContext context) {
//     Widget imageWidget = _buildImage();

//     if (radius != null || border != null) {
//       imageWidget = Container(
//         height: height,
//         width: width,
//         decoration: BoxDecoration(
//           border: border,
//           borderRadius: radius,
//         ),
//         clipBehavior: Clip.antiAlias,
//         child: imageWidget,
//       );
//     }

//     if (alignment != null) {
//       imageWidget = Align(
//         alignment: alignment!,
//         child: imageWidget,
//       );
//     }

//     if (onTap != null) {
//       imageWidget = InkWell(onTap: onTap, child: imageWidget);
//     }

//     return Padding(
//       padding: margin ?? EdgeInsets.zero,
//       child: imageWidget,
//     );
//   }

//   Widget _buildImage() {
//     final BoxFit effectiveFit = fit ?? BoxFit.cover;

//     if (file != null && file!.existsSync()) {
//       return Image.file(
//         file!,
//         height: height,
//         width: width,
//         fit: effectiveFit,
//         color: color,
//       );
//     }

//     if (url != null && url!.isNotEmpty) {
//       return CachedNetworkImage(
//         height: height,
//         width: width,
//         fit: effectiveFit,
//         imageUrl: url!,
//         color: color,
//         placeholder: (context, url) => Container(
//           height: height ?? 100.h,
//           width: width ?? 100.w,
//           alignment: Alignment.center,
//           child: const CircularProgressIndicator(strokeWidth: 1.5),
//         ),
//         errorWidget: (context, url, error) => Image.asset(
//           placeHolder,
//           height: height,
//           width: width,
//           fit: effectiveFit,
//         ),
//       );
//     }

//     if (imagePath != null && imagePath!.isNotEmpty) {
//       return Image.asset(
//         imagePath!,
//         height: height,
//         width: width,
//         fit: effectiveFit,
//         color: color,
//       );
//     }

//     return Image.asset(
//       placeHolder,
//       height: height,
//       width: width,
//       fit: effectiveFit,
//     );
//   }
// }
