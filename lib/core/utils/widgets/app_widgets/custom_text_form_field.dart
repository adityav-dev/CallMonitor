import '../../../app-export.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.maxLength,
    this.onChanged,
    this.shape,
    this.padding,
    this.variant,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.focusNode,
    this.isObscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.validator,
    this.labelText,
    this.readOnly,
    this.onTap,
    this.capital,
    this.floatingLabelBehavior,
    this.autofocus,
    this.minLines,
    this.inputFormatters,
  });

  final bool? autofocus;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextCapitalization? capital;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final TextFormFieldShape? shape;
  final TextFormFieldPadding? padding;
  final TextFormFieldVariant? variant;
  final Alignment? alignment;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? isObscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final String? hintText;
  final bool? readOnly;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final FormFieldValidator<String>? validator;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final textField = TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus ?? false,
      obscureText: isObscureText ?? false,
      readOnly: readOnly ?? false,
      maxLength: maxLength,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      onTap: onTap,
      onChanged: onChanged,
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: textInputType,
      validator: validator,
      inputFormatters: inputFormatters,
      textCapitalization: capital ?? TextCapitalization.sentences,
      decoration: _buildDecoration(),
    );

    return alignment != null
        ? Align(alignment: alignment!, child: _wrapWithContainer(textField))
        : _wrapWithContainer(textField);
  }

  Widget _wrapWithContainer(Widget child) {
    return Container(
      width: width ?? double.infinity,
      margin: margin,
      child: child,
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      counterText: "",
      hintText: hintText ?? "",
      labelText: labelText ?? hintText,
      floatingLabelBehavior:
          floatingLabelBehavior ?? FloatingLabelBehavior.auto,
      filled: _setFilled(),
      fillColor: _setFillColor(),
      prefixIcon: prefixIcon,
      prefixIconConstraints: prefixIconConstraints,
      suffixIcon: suffixIcon,
      suffixIconConstraints: suffixIconConstraints,
      contentPadding: _setPadding(),
      errorStyle: TextStyle(color: ColorConstants.error, fontSize: 12.sp),
      hintStyle: TextStyle(
        color: ColorConstants.grey,
        fontSize: 14.sp,
        fontFamily: AppFonts.poppins,
      ),
      labelStyle: TextStyle(
        color: ColorConstants.grey,
        fontSize: 14.sp,
        fontFamily: AppFonts.poppins,
      ),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      errorBorder: OutlineInputBorder(
        borderRadius: _setOutlineBorderRadius(),
        borderSide: BorderSide(color: ColorConstants.errorBorder),
      ),
    );
  }

  BorderRadius _setOutlineBorderRadius() {
    return BorderRadius.circular(10.r);
  }

  InputBorder _setBorderStyle() {
    switch (variant) {
      case TextFormFieldVariant.White:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(color: ColorConstants.grey, width: 1),
        );
      case TextFormFieldVariant.FillWhiteA700:
      case TextFormFieldVariant.FillDeeporange5001:
      case TextFormFieldVariant.FillGray10001:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
      case TextFormFieldVariant.OutlineGray30004_1:
      case TextFormFieldVariant.OutlineGray30004_2:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(color: ColorConstants.outlineStroke, width: 1),
        );
      case TextFormFieldVariant.OutlineScecondaryColor:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: const BorderSide(
            color: ColorConstants.secondaryColor,
            width: 1,
          ),
        );
      case TextFormFieldVariant.OutlineLightGrey:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(color: ColorConstants.lightGrey, width: 1),
        );
      case TextFormFieldVariant.None:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(color: ColorConstants.grey, width: 1),
        );
    }
  }

  bool _setFilled() {
    switch (variant) {
      case TextFormFieldVariant.None:
        return false;
      default:
        return true;
    }
  }

  Color _setFillColor() {
    switch (variant) {
      case TextFormFieldVariant.FillWhiteA700:
      case TextFormFieldVariant.White:
        return ColorConstants.white;
      case TextFormFieldVariant.FillDeeporange5001:
        return ColorConstants.orangeTwo;
      case TextFormFieldVariant.FillGray10001:
        return ColorConstants.greyBgs;
      case TextFormFieldVariant.FillneutralN20:
        return ColorConstants.neutral20;
      default:
        return ColorConstants.surfaceColor;
    }
  }

  EdgeInsets _setPadding() {
    switch (padding) {
      case TextFormFieldPadding.PaddingT16:
        return EdgeInsets.only(left: 16.w, top: 16.h, bottom: 16.h);
      case TextFormFieldPadding.PaddingAll19:
        return EdgeInsets.all(19.w);
      case TextFormFieldPadding.PaddingT15:
        return EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h);
      case TextFormFieldPadding.PaddingLR16TB8:
        return EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h);
      case TextFormFieldPadding.PaddingAll8:
        return EdgeInsets.all(8.w);
      case TextFormFieldPadding.PaddingAll4:
        return EdgeInsets.all(4.w);
      case TextFormFieldPadding.PaddingAll12:
        return EdgeInsets.all(12.w);
      case TextFormFieldPadding.PaddingAll0:
        return EdgeInsets.zero;
      case TextFormFieldPadding.PaddingVertical20:
        return EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h);
      default:
        return EdgeInsets.all(16.w);
    }
  }
}

enum TextFormFieldShape { RoundedBorder6 }

enum TextFormFieldPadding {
  PaddingAll16,
  PaddingT16,
  PaddingAll19,
  PaddingT15,
  PaddingAll8,
  PaddingAll4,
  PaddingAll12,
  PaddingAll0,
  PaddingLR16TB8,
  PaddingVertical20,
}

enum TextFormFieldVariant {
  None,
  OutlineGray30004,
  White,
  FillWhiteA700,
  OutlineGray30004_1,
  FillDeeporange5001,
  FillGray10001,
  OutlineGray30004_2,
  OutlineScecondaryColor,
  FillneutralN20,
  OutlineLightGrey,
}
