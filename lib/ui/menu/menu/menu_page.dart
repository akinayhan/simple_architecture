import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/function/app_exit_helper.dart';
import '../announcement/get_announcement_page.dart';
import 'menu_card.dart';
import '../../../utils/function/log_out_helper.dart';
import '../../../utils/navigate/navigate_to_profile_page.dart';
import '../../../utils/constants/role_utils.dart';
import '../../../utils/theme/colors.dart';
import '../../../view_model/login/log_out_view_model.dart';
import '../management/management_page.dart';
import '../market_management/market_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  int? _companyId;
  String? _token;
  bool isAdminRole = false;
  bool isCustomerRole = false;
  bool isSubCustomerRole = false;
  bool isEndUserRole = false;
  bool isLoading = false;
  List<MenuItem> allItems = [];
  List<MenuItem> filteredItems = [];
  late LogOutViewModel logOutViewModel;

  @override
  void initState() {
    super.initState();
    logOutViewModel = Provider.of<LogOutViewModel>(context, listen: false);
    _initializePage();
  }

  Future<void> _initializePage() async {
    await _getTokenFromSharedPreferences();
    await _fetchUserRoles();
  }

  Future<void> _getTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _companyId = prefs.getInt('COMPANY_ID');
      _token = prefs.getString('TOKEN');
    });
  }

  Future<void> _fetchUserRoles() async {
    Map<String, bool> userRoles = await RoleUtils().getAllUserRoles();
    setState(() {
      isAdminRole = userRoles[RoleUtils.roleAdmin] ?? false;
      isCustomerRole = userRoles[RoleUtils.roleCustomer] ?? false;
      isSubCustomerRole = userRoles[RoleUtils.roleSubCustomer] ?? false;
      isEndUserRole = userRoles[RoleUtils.roleEndUser] ?? false;
    });
    _initMenuItems();
  }

  void _initMenuItems() {
    setState(() {
      allItems = [
        MenuItem("Duyurular", Ionicons.megaphone_outline, GetAnnouncementPage(token: _token!, isAdminRole: isAdminRole, isCustomerRole: isCustomerRole, isSubCustomerRole: isSubCustomerRole, isEndUserRole: isEndUserRole,), CorporateColors.logoColor4),
        MenuItem("Market", Ionicons.cart_outline, const MarketPage(), CorporateColors.green),
        MenuItem("Yönetim", Ionicons.briefcase_outline, const ManagementPage(), CorporateColors.purple),
        MenuItem("Oturumu Kapat", Ionicons.exit_outline, null, CorporateColors.red),
      ];
      filteredItems = _filterMenuItemsByRole();
    });
  }

  List<MenuItem> _filterMenuItemsByRole() {
    List<MenuItem> filtered = [];

    if (isAdminRole) {
      filtered.addAll([
        allItems.firstWhere((item) => item.title == "Yönetim"),
        allItems.firstWhere((item) => item.title == "Yönetim"),
        allItems.firstWhere((item) => item.title == "Oturumu Kapat"),
      ]);
    }

    if (isCustomerRole) {
      if (_companyId != -1) {
        filtered.addAll([
          allItems.firstWhere((item) => item.title == "Market"),
          allItems.firstWhere((item) => item.title == "Duyurular"),
          allItems.firstWhere((item) => item.title == "Yönetim"),
        ]);
      }
      filtered.add(allItems.firstWhere((item) => item.title == "Oturumu Kapat"));
    }

    if (isSubCustomerRole) {
      filtered.addAll([
        allItems.firstWhere((item) => item.title == "Market"),
        allItems.firstWhere((item) => item.title == "Duyurular"),
      ]);
      filtered.add(allItems.firstWhere((item) => item.title == "Oturumu Kapat"));
    }

    if (isEndUserRole) {
      filtered.addAll([
        allItems.firstWhere((item) => item.title == "Duyurular"),
        allItems.firstWhere((item) => item.title == "Oturumu Kapat")
      ]);
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;

    if (screenWidth < 350) {
      crossAxisCount = 1;
    } else if (screenWidth >= 350 && screenWidth < 600) {
      crossAxisCount = 2;
    } else if (screenWidth >= 600 && screenWidth < 900) {
      crossAxisCount = 3;
    } else if (screenWidth >= 900 && screenWidth < 1200) {
      crossAxisCount = 4;
    } else if (screenWidth >= 1200 && screenWidth < 1600) {
      crossAxisCount = 4;
    } else {
      crossAxisCount = 5;
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if(didPop) {
          return;
        }
        AppExitHelper.onWillPop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Menü'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              AppExitHelper.onWillPop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Ionicons.person_outline),
              onPressed: () => navigateToProfilePage(context),
            ),
          ],
        ),
        body:GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.0,
          ),
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onItemClick(context, filteredItems[index]),
              child: MenuItemCard(item: filteredItems[index]),
            );
          },
        )
      ),
    );
  }

  void onItemClick(BuildContext context, MenuItem item) {
    if (item.page != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => item.page!));
    } else if (item.title == "Oturumu Kapat") {
      onPressedLogOut(logOutViewModel, context, _token!);
    }
  }
}