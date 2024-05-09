abstract class RegisterStates {}

class RegisterInitState extends RegisterStates {}

class FormDrSelectionState extends RegisterStates {}

class FormVSelectionState extends RegisterStates {}

class FormSNSelectionState extends RegisterStates {}

class FormResetState extends RegisterStates {}

class FormDrMajorState extends RegisterStates {}

class FormDropDownState extends RegisterStates {}

class FormCheckBoxState extends RegisterStates {}

class FormCheckImagesLoadingState extends RegisterStates {}

class FormCityChoiseState extends RegisterStates {}

class FormNIDDrImagePickerSuccState extends RegisterStates {}

class FormNIDDrImagePickerErrState extends RegisterStates {}

class FormNIDVImagePickerSuccState extends RegisterStates {}

class FormNIDVImagePickerErrState extends RegisterStates {}

class FormNIDSpImagePickerSuccState extends RegisterStates {}

class FormNIDSpImagePickerErrState extends RegisterStates {}

class FormNIDCSpImagePickerSuccState extends RegisterStates {}

class FormNIDCSpImagePickerErrState extends RegisterStates {}

class FormPicDrImagePickerSuccState extends RegisterStates {}

class FormPicDrImagePickerErrState extends RegisterStates {}

class FormPicVImagePickerSuccState extends RegisterStates {}

class FormPicVImagePickerErrState extends RegisterStates {}

class FormPicSpImagePickerSuccState extends RegisterStates {}

class FormPicSpImagePickerErrState extends RegisterStates {}

class FormPicCSpImagePickerSuccState extends RegisterStates {}

class FormPicCSpImagePickerErrState extends RegisterStates {}

class FormCardDrImagePickerSuccState extends RegisterStates {}

class FormCardDrImagePickerErrState extends RegisterStates {}

class FormCardSpImagePickerSuccState extends RegisterStates {}

class FormCardSpImagePickerErrState extends RegisterStates {}

class FormNIDDrImageUploadSuccState extends RegisterStates {}

class FormNIDDrImageUploadErrState extends RegisterStates {
  final String error;
  FormNIDDrImageUploadErrState(this.error);
}

class FormPicDrImageUploadSuccState extends RegisterStates {}

class FormPicDrImageUploadErrState extends RegisterStates {
  final String error;
  FormPicDrImageUploadErrState(this.error);
}

class FormCardDrImageUploadSuccState extends RegisterStates {}

class FormCardDrImageUploadErrState extends RegisterStates {
  final String error;
  FormCardDrImageUploadErrState(this.error);
}

class FormDrImagesUploadLoadingState extends RegisterStates {}

class FormNIDSpImageUploadSuccState extends RegisterStates {}

class FormNIDSpImageUploadErrState extends RegisterStates {
  final String error;
  FormNIDSpImageUploadErrState(this.error);
}

class FormPicSpImageUploadSuccState extends RegisterStates {}

class FormPicSpImageUploadErrState extends RegisterStates {
  final String error;
  FormPicSpImageUploadErrState(this.error);
}

class FormCardSpImageUploadSuccState extends RegisterStates {}

class FormCardSpImageUploadErrState extends RegisterStates {
  final String error;
  FormCardSpImageUploadErrState(this.error);
}

class FormNIDCSpImageUploadSuccState extends RegisterStates {}

class FormNIDCSpImageUploadErrState extends RegisterStates {
  final String error;
  FormNIDCSpImageUploadErrState(this.error);
}

class FormPicCSpImageUploadSuccState extends RegisterStates {}

class FormPicCSpImageUploadErrState extends RegisterStates {
  final String error;
  FormPicCSpImageUploadErrState(this.error);
}

class FormSpImagesUploadLoadingState extends RegisterStates {}

class FormSpImagesUploadState extends RegisterStates {}

class FormNIDVImageUploadSuccState extends RegisterStates {}

class FormNIDVImageUploadErrState extends RegisterStates {
  final String error;
  FormNIDVImageUploadErrState(this.error);
}

class FormPicVImageUploadSuccState extends RegisterStates {}

class FormPicVImageUploadErrState extends RegisterStates {
  final String error;
  FormPicVImageUploadErrState(this.error);
}

class FormVImagesUploadLoadingState extends RegisterStates {}

class RegisterPasswordVisibleState extends RegisterStates {}

class RegisterRePasswordVisibleState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccState extends RegisterStates {}

class RegisterErrState extends RegisterStates {
  final String error;
  RegisterErrState(this.error);
}

class RegisterUserDataSuccState extends RegisterStates {}

class RegisterUserDataErrState extends RegisterStates {
  final String error;
  RegisterUserDataErrState(this.error);
}
