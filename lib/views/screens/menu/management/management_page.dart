import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/constants/role_utils.dart';
import '../settings/option_card.dart';
import '../market_management/market_management_page.dart';
import 'finance/market_payment_amounts_page.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key});

  @override
  ManagementPageState createState() => ManagementPageState();
}

class ManagementPageState extends State<ManagementPage> {
  int? _companyId;
  String? _token;
  bool isAdminRole = false;
  bool isCustomerRole = false;
  bool isSubCustomerRole = false;

  @override
  void initState() {
    super.initState();
    _getTokenFromSharedPreferences();
    _fetchUserRoles();
  }

  Future<void> _fetchUserRoles() async {
    Map<String, bool> userRoles = await RoleUtils().getAllUserRoles();
    setState(() {
      isAdminRole = userRoles[RoleUtils.roleAdmin] ?? false;
      isCustomerRole = userRoles[RoleUtils.roleCustomer] ?? false;
      isSubCustomerRole = userRoles[RoleUtils.roleSubCustomer] ?? false;
    });
  }

  Future<void> _getTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('TOKEN');
      _companyId = prefs.getInt('COMPANY_ID');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yönetim"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if(isCustomerRole)
              OptionCard(
                icon: Icons.folder,
                title: 'Market Yönetimi',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MarketManagementPage(
                        companyId: _companyId!,
                        token: _token!,
                      ),
                    ),
                  );
                },
              ),
              OptionCard(
                icon: Icons.folder,
                title: 'Market Satış Gelirleri',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MarketPaymentAmountsPage(
                        companyId: _companyId!,
                        token: _token!,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}