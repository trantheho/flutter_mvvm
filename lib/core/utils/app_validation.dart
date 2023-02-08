

enum EmailValidationState {
  valid,
  nonEmail,
  badEmail,
}

enum PasswordValidationState {
  valid,
  badPassword,
  badLength,
  nonPassword,
}

enum PhoneValidationState {
  badPhoneNumber,
  valid,
}

enum NameValidationState{
  emptyName,
  valid,
}


mixin Validator {
  final _emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final _passwordRegex =
      r"^([ a-zA-ZĂ€ĂĂ‚ĂƒĂˆĂ‰ĂĂŒĂĂ’Ă“Ă”Ă•Ă™ĂĂĂ Ă¡Ă¢Ă£Ă¨Ă©ĂªĂ¬Ă­Ă²Ă³Ă´ĂµĂ¹ĂºĂ½Ä‚ÄƒÄÄ‘Ä¨Ä©Å¨Å©Æ Æ¡Æ¯Æ°áº -á»¹]+(([',. -][a-zA-Z ])?[a-zA-ZĂ€ĂĂ‚ĂƒĂˆĂ‰ĂĂŒĂĂ’Ă“Ă”Ă•Ă™ĂĂĂ Ă¡Ă¢Ă£Ă¨Ă©ĂªĂ¬Ă­Ă²Ă³Ă´ĂµĂ¹ĂºĂ½Ä‚ÄƒÄÄ‘Ä¨Ä©Å¨Å©Æ Æ¡Æ¯Æ°áº -á»¹]*)*)$";

  String? emailValidator(String? email, {String? Function(EmailValidationState state)? validatorBuilder}) {
    final state = _validateEmail(email);
    if (validatorBuilder != null) {
      return validatorBuilder(state);
    }

    switch (state) {
      case EmailValidationState.nonEmail:
        return 'Email is empty';
      case EmailValidationState.badEmail:
        return 'Email is invalid';
      default:
        return null;
    }
  }

  String? passwordValidator(String? password,
      {String? Function(PasswordValidationState state)? validatorBuilder}) {
    final state = _validatePassword(password);
    if (validatorBuilder != null) {
      return validatorBuilder(state);
    }

    switch (state) {
      case PasswordValidationState.badPassword:
        return 'Password is invalid';
      case PasswordValidationState.badLength:
        return 'Password is too short';
      case PasswordValidationState.nonPassword:
        return 'Password is empty';
      default:
        return null;
    }
  }

  String? firstNameValidator(String? name, {String? Function(NameValidationState state)? validatorBuilder}){
    final state = _validateName(name);
    if(validatorBuilder != null){
      return validatorBuilder(state);
    }

    switch(state){
      case NameValidationState.emptyName:
        return 'First is empty';
      case NameValidationState.valid:
      default:
        return null;
    }
  }

  String? lastNameValidator(String? name, {String? Function(NameValidationState state)? validatorBuilder}){
    final state = _validateName(name);
    if(validatorBuilder != null){
      return validatorBuilder(state);
    }

    switch(state){
      case NameValidationState.emptyName:
        return 'Last name is empty';
      case NameValidationState.valid:
      default:
        return null;
    }
  }


  /// VALIDATE
  EmailValidationState _validateEmail(String? email) {
    if (email != null && email.isNotEmpty) {
      final regex = RegExp(_emailRegex);
      if (!regex.hasMatch(email)) {
        return EmailValidationState.badEmail;
      }
    } else {
      return EmailValidationState.nonEmail;
    }

    return EmailValidationState.valid;
  }

  PhoneValidationState _validatePhoneNumber(String? phone) {
    if (phone == null) {
      return PhoneValidationState.badPhoneNumber;
    } else if (phone.isEmpty) {
      return PhoneValidationState.badPhoneNumber;
    } else if (phone.length < 9) {
      return PhoneValidationState.badPhoneNumber;
    }

    return PhoneValidationState.valid;
  }

  NameValidationState _validateName(String? stringName) {
    if(stringName == null || stringName.isEmpty){
      return NameValidationState.emptyName;
    }

    return NameValidationState.valid;
  }

  PasswordValidationState _validatePassword(String? password) {
    if (password != null && password.isNotEmpty) {
      if (password.length < 2) {
        return PasswordValidationState.badLength;
      }

      final regex = RegExp(_passwordRegex);
      if (!regex.hasMatch(password)) {
        return PasswordValidationState.badPassword;
      }
    } else {
      return PasswordValidationState.nonPassword;
    }

    return PasswordValidationState.valid;
  }
}