import 'package:shared_preferences/shared_preferences.dart';

class RoleUtils {
  static const String roleAdmin = "Admin";
  static const String roleCustomer = "Customer";
  static const String roleSubCustomer = "SubCustomer";
  static const String roleEndUser = "EndUser";

  Future<Map<String, bool>> getAllUserRoles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? role = prefs.getString('ROLE');

    return {
      roleAdmin: role == roleAdmin,
      roleCustomer: role == roleCustomer,
      roleSubCustomer: role == roleSubCustomer,
      roleEndUser: role == roleEndUser,
    };
  }
}