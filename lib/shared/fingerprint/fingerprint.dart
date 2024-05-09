import 'package:local_auth/local_auth.dart';

class FingerPrint {
  final LocalAuthentication lAuth = LocalAuthentication();

  Future<bool> isFingerEnable() async {
    bool finger = await lAuth.canCheckBiometrics;

    return finger;
  }

  Future<bool> isAuth(String reason) async {
    bool auth = await lAuth.authenticate(
      localizedReason: reason,
      options: const AuthenticationOptions(
        biometricOnly: true,
      ),
    );
    return auth;
  }
}
  