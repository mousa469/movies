import 'dart:io';

class NetworkChecker {
  static Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // Connected to the internet
      }
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      return false; // No internet connection
    }
    return false;
  }
}
