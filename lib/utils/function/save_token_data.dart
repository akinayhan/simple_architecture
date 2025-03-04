import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveTokenData(String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final decodedToken = JwtDecoder.decode(token);

  final role = decodedToken['role'] ?? '';
  final userId = decodedToken['userId'] ?? '';
  final companyIdStr = decodedToken['companyId'] ?? '';
  final fullName = decodedToken['fullName'] ?? '';
  final phoneNumber = decodedToken['phone'] ?? '';
  final email = decodedToken['email'] ?? '';
  final userName = decodedToken['userName'] ?? '';

  final companyId = int.tryParse(companyIdStr) ?? 0;

  await prefs.setString('TOKEN', token);
  await prefs.setString('ROLE', role);
  await prefs.setString('USER_ID', userId);
  await prefs.setInt('COMPANY_ID', companyId);
  await prefs.setString('EMAIL', email);
  await prefs.setString('FULL_NAME', fullName);
  await prefs.setString('USER_NAME', userName);
  await prefs.setString('PHONE_NUMBER', phoneNumber);
}
