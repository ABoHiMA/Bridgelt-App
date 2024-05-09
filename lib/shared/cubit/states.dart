abstract class AppStates {}

class AppInitState extends AppStates {}

class AppChgNavBarState extends AppStates {}

class AppLogoutSuccState extends AppStates {}

class AppLogoutErrState extends AppStates {
  final String error;
  AppLogoutErrState(this.error);
}

class AppLoadingGetUserDataState extends AppStates {}

class AppGetUserDataSuccState extends AppStates {}

class AppGetUserDataErrState extends AppStates {
  final String error;
  AppGetUserDataErrState(this.error);
}

class AppLoadingGetOthersUserDataState extends AppStates {}

class AppGetOthersUserDataSuccState extends AppStates {}

class AppGetOthersUserDataErrState extends AppStates {
  final String error;
  AppGetOthersUserDataErrState(this.error);
}

class AppLoadingGetOthersUserChatState extends AppStates {}

class AppGetOthersUserChatSuccState extends AppStates {}

class AppGetOthersUserChatErrState extends AppStates {
  final String error;
  AppGetOthersUserChatErrState(this.error);
}

class AppCreateCaseLoadingState extends AppStates {}

class AppCreateCaseSuccState extends AppStates {}

class AppCreateCaseErrState extends AppStates {
  final String error;
  AppCreateCaseErrState(this.error);
}

class AppCreateSessionLoadingState extends AppStates {}

class AppCreateSessionSuccState extends AppStates {}

class AppCreateSessionErrState extends AppStates {
  final String error;
  AppCreateSessionErrState(this.error);
}

class AppChangeBtmBtnState extends AppStates {}

class AppLoadingGetCasesState extends AppStates {}

class AppGetCasesSuccState extends AppStates {}

class AppGetCasesErrState extends AppStates {
  final String error;
  AppGetCasesErrState(this.error);
}

class AppLoadingGetSessionsState extends AppStates {}

class AppGetSessionsSuccState extends AppStates {}

class AppGetSessionsErrState extends AppStates {
  final String error;
  AppGetSessionsErrState(this.error);
}

class AppDeleteCasesSuccState extends AppStates {}

class AppDeleteCasesErrState extends AppStates {
  final String error;
  AppDeleteCasesErrState(this.error);
}

class AppArchivedCasesSuccState extends AppStates {}

class AppArchivedCasesErrState extends AppStates {
  final String error;
  AppArchivedCasesErrState(this.error);
}

class AppDeleteSessionSuccState extends AppStates {}

class AppLoadingGetSpCasesState extends AppStates {}

class AppGetSpCasesSuccState extends AppStates {}

class AppGetSpCasesErrState extends AppStates {
  final String error;
  AppGetSpCasesErrState(this.error);
}

class AppLoadingGetFilteredCasesState extends AppStates {}

class AppGetFilteredCasesSuccState extends AppStates {}

class AppGetFilteredCasesErrState extends AppStates {
  final String error;
  AppGetFilteredCasesErrState(this.error);
}

class AppDropDownState extends AppStates {}

class AppMsgBtnState extends AppStates {}

class AppModeState extends AppStates {}

class AppCityChoiseState extends AppStates {}

class AppLoadingChatSpState extends AppStates {}

class AppLoadingChatsState extends AppStates {}

class AppLoadingMessagesSpState extends AppStates {}

class AppSendMessagesSpSuccState extends AppStates {}

class AppSendMessagesSpErrState extends AppStates {
  final String error;
  AppSendMessagesSpErrState(this.error);
}

class AppGetChatsUsersSuccState extends AppStates {}

class AppGetChatsUsersErrState extends AppStates {
  final String error;
  AppGetChatsUsersErrState(this.error);
}

class AppSetChatsUsersSuccState extends AppStates {}

class AppSetChatsUsersErrState extends AppStates {
  final String error;
  AppSetChatsUsersErrState(this.error);
}

class AppGetMessagesSpState extends AppStates {}

class AppLoadingChatVState extends AppStates {}

class AppLoadingMessagesVState extends AppStates {}

class AppSendMessagesVSuccState extends AppStates {}

class AppSendMessagesVErrState extends AppStates {
  final String error;
  AppSendMessagesVErrState(this.error);
}

class AppGetMessagesVState extends AppStates {}

class AppLoadingMessagesState extends AppStates {}

class AppLoadingMessagesDrState extends AppStates {}

class AppSendMessagesSuccState extends AppStates {}

class AppSendMessagesErrState extends AppStates {
  final String error;
  AppSendMessagesErrState(this.error);
}

class AppGetMessagesState extends AppStates {}

class AppLoadingGetUsersState extends AppStates {}

class AppGetUsersSuccState extends AppStates {}

class AppGetUsersErrState extends AppStates {
  final String error;
  AppGetUsersErrState(this.error);
}

class AppBtnProfileState extends AppStates {}

class AppChgProfileImageSuccState extends AppStates {}

class AppChgProfileImageErrState extends AppStates {}

class AppChgState extends AppStates {}

class AppUpdateUserDataLoadingState extends AppStates {}

class AppUpdateUserDataSuccState extends AppStates {}

class AppUpdateUserDataErrState extends AppStates {
  final String error;
  AppUpdateUserDataErrState(this.error);
}

class AppUploadProfileImageSuccState extends AppStates {}

class AppUploadProfileImageErrState extends AppStates {
  final String error;
  AppUploadProfileImageErrState(this.error);
}

class AppUpdateMsgCaseSuccState extends AppStates {}

class AppUpdateMsgCaseErrState extends AppStates {
  final String error;
  AppUpdateMsgCaseErrState(this.error);
}

class AppEncryptMessageState extends AppStates {}

class AppDecryptMessageState extends AppStates {}

class AppFingerPrintState extends AppStates {}
