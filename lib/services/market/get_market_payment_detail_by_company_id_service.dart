import '../../models/market/get_market_payment_detail_by_company_id_model.dart';
import '../../models/market/get_market_payment_detail_by_company_id_request_model.dart';
import '../../models/result/data_api_result.dart';import '../base/get_base_service.dart';

class GetMarketPaymentDetailByCompanyIdService extends GetBaseService {
  static const String endPoint = 'Market/GetMarketPaymentDetailByCompanyId';

  Future<DataApiResult<List<GetMarketPaymentDetailByCompanyIdModel>>> fetchMarketPaymentDetail(String token, GetMarketPaymentDetailByCompanyIdRequestModel requestModel) async {
    return await postRequest<GetMarketPaymentDetailByCompanyIdModel>(endPoint, token, requestModel.toJson(), (data) => GetMarketPaymentDetailByCompanyIdModel.fromJson(data));
  }
}