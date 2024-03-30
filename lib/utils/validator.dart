class CustomValidator {
  static final CustomValidator _formValidator = CustomValidator._internal();

  factory CustomValidator() => _formValidator;

  CustomValidator._internal();

  String? validateUsername(String value) {
    if (value.isEmpty) {
      return 'Username cannot be empty';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters long';
    }
    return null;
  }

  String? validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  String? validateFullName(String value) {
    if (value.isEmpty) {
      return 'Full Name cannot be empty';
    }
    if (value.length < 3) {
      return 'Full Name must be at least 3 characters long';
    }
    return null;
  }

  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Phone Number cannot be empty';
    }
    if (value.length < 10) {
      return 'Phone Number must be at least 10 digits long';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String value, String password) {
    if (value.isEmpty) {
      return 'Confirm Password cannot be empty';
    } else if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateTaskTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Task Title cannot be empty';
    }
    if (value.length < 3) {
      return 'Task Title must be at least 3 characters long';
    }
    return null;
  }

  String? validateTaskDescription(String? value) {
    return null;
  }

  String? validateNotes(String? value) {
    return null;
  }

  String? validateDate(String? value) {
    return null;
  }

  String? validateTag(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tag cannot be empty';
    }
    return null;
  }
}
