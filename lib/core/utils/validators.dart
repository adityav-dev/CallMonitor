class AppValidators {
  static String? validateRequired(String? value, {required String fieldName}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateIndianPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contact Number is required';
    }
    // if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
    //   return 'Enter a valid 10-digit Indian phone number';
    // }
    return null;
  }

  static String? validateWebsite(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Website is optional
    }
    // if (!RegExp(
    //   r'^(https?:\/\/)?([\w\-]+(\.[\w\-]+)+)([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?$',
    // ).hasMatch(value)) {
    //   return 'Enter a valid website URL';
    // }
    return null;
  }

  static String? validatePanCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'PAN Card is required';
    }
    // if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
    //   return 'Enter a valid PAN Card number';
    // }
    return null;
  }

  static String? validateGstNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null; // GST Number is optional
    }
    // if (!RegExp(
    //   r'^\d{2}[A-Z]{5}\d{4}[A-Z]{1}[A-Z\d]{1}[Z]{1}[A-Z\d]{1}$',
    // ).hasMatch(value)) {
    //   return 'Enter a valid GST Number';
    // }
    return null;
  }

  static String? validatePinCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pin Code is required';
    }
    // if (!RegExp(r'^\d{6}$').hasMatch(value)) {
    //   return 'Enter a valid 6-digit Pin Code';
    // }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    //   return 'Enter a valid email address';
    // }
    return null;
  }
}