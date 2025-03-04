import '../../models/market/get_market_payment_by_company_id_model.dart';
import '../../models/market/get_market_payment_request_model.dart';
import '../../utils/result/data_api_result.dart';
import '../base/get_base_service.dart';

class GetMarketPaymentByCompanyIdService extends GetBaseService {
  static const String endPoint = 'Market/GetMarketPaymentByCompanyId';

  Future<DataApiResult<List<GetMarketPaymentByCompanyIdModel>>> fetchMarketPaymentByCompanyId(String token, GetMarketPaymentRequestModel requestModel) async {
    return await postRequest<GetMarketPaymentByCompanyIdModel>(endPoint, token, requestModel.toJson(), (data) => GetMarketPaymentByCompanyIdModel.fromJson(data));
  }
}