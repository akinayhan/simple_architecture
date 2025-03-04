import 'package:provider/provider.dart';
import '../../view_model/login/change_password_view_model.dart';
import '../../view_model/login/forgot_password_view_model.dart';
import '../../view_model/login/log_out_view_model.dart';
import '../../view_model/login/reset_password_view_model.dart';
import '../../view_model/login/sign_in_view_model.dart';
import '../../view_model/login/sign_up_view_model.dart';
import '../../view_model/login/update_profile_view_model.dart';
import '../../view_model/market/create_market_category_view_model.dart';
import '../../view_model/market/create_market_payment_view_model.dart';
import '../../view_model/market/create_market_product_view_model.dart';
import '../../view_model/market/get_market_category_view_model.dart';
import '../../view_model/market/get_market_payment_by_company_id_view_model.dart';
import '../../view_model/market/get_market_product_view_model.dart';
import '../../view_model/market/update_market_category_view_model.dart';
import '../../view_model/market/update_market_product_view_model.dart';
import '../../view_model/other/city_view_model.dart';
import '../../view_model/other/district_view_model.dart';
import '../../view_model/other/get_daily_leaderboard_view_model.dart';
import '../../view_model/other/get_monthly_leaderboard_view_model.dart';
import '../../view_model/other/list_payment_methods_view_model.dart';

List<ChangeNotifierProvider> getAppProviders() {
  return [
    ChangeNotifierProvider<CityViewModel>(create: (_) => CityViewModel()),
    ChangeNotifierProvider<DistrictViewModel>(create: (_) => DistrictViewModel()),
    ChangeNotifierProvider<SignInViewModel>(create: (_) => SignInViewModel()),
    ChangeNotifierProvider<ResetPasswordViewModel>(create: (_) => ResetPasswordViewModel()),
    ChangeNotifierProvider<ForgotPasswordViewModel>(create: (_) => ForgotPasswordViewModel()),
    ChangeNotifierProvider<SignInViewModel>(create: (_) => SignInViewModel()),
    ChangeNotifierProvider<SignUpViewModel>(create: (_) => SignUpViewModel()),
    ChangeNotifierProvider<UpdateProfileViewModel>(create: (_) => UpdateProfileViewModel()),
    ChangeNotifierProvider<ChangePasswordViewModel>(create: (_) => ChangePasswordViewModel()),
    ChangeNotifierProvider<LogOutViewModel>(create: (_) => LogOutViewModel()),
    ChangeNotifierProvider<CreateMarketCategoryViewModel>(create: (_) => CreateMarketCategoryViewModel()),
    ChangeNotifierProvider<CreateMarketProductViewModel>(create: (_) => CreateMarketProductViewModel()),
    ChangeNotifierProvider<CreateMarketPaymentViewModel>(create: (_) => CreateMarketPaymentViewModel(),),
    ChangeNotifierProvider<UpdateMarketCategoryViewModel>(create: (_) => UpdateMarketCategoryViewModel()),
    ChangeNotifierProvider<UpdateMarketProductViewModel>(create: (_) => UpdateMarketProductViewModel()),
    ChangeNotifierProvider<GetMarketCategoriesViewModel>(create: (_) => GetMarketCategoriesViewModel()),
    ChangeNotifierProvider<GetMarketProductsViewModel>(create: (_) => GetMarketProductsViewModel()),
    ChangeNotifierProvider<ListPaymentMethodsViewModel>(create: (_) => ListPaymentMethodsViewModel()),
    ChangeNotifierProvider<GetMarketPaymentByCompanyIdViewModel>(create: (_) => GetMarketPaymentByCompanyIdViewModel()),
    ChangeNotifierProvider<GetDailyLeaderboardViewModel>(create: (_) => GetDailyLeaderboardViewModel()),
    ChangeNotifierProvider<GetMonthlyLeaderboardViewModel>(create: (_) => GetMonthlyLeaderboardViewModel()),
  ];
}