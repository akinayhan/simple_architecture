import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/market/get_market_category_request_model.dart';
import '../../../models/market/update_market_category_model.dart';
import '../../../utils/design/build_dropdown/build_market_category_dropdown_items.dart';
import '../../../utils/design/button_design/delete_material_button.dart';
import '../../../../utils/design/dialog_design/quick_alert_utils.dart';
import '../../../utils/result/api_result.dart';
import '../../../view_model/market/get_market_category_view_model.dart';
import '../../../view_model/market/update_market_category_view_model.dart';

class DeleteMarketCategoryPage extends StatefulWidget {
  final int companyId;
  final String token;

  const DeleteMarketCategoryPage({super.key, required this.companyId, required this.token});

  @override
  DeleteMarketCategoryPageState createState() => DeleteMarketCategoryPageState();
}

class DeleteMarketCategoryPageState extends State<DeleteMarketCategoryPage> {
  late GetMarketCategoriesViewModel getMarketCategoriesViewModel;

  bool _dataLoaded = false;
  int? _selectedMarketCategoryId;
  String? _selectedMarketCategoryName;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    getMarketCategoriesViewModel = Provider.of<GetMarketCategoriesViewModel>(context, listen: false);
    GetMarketCategoryRequestModel requestModel = GetMarketCategoryRequestModel(companyId: widget.companyId, status: true, deleted: false,);
    await getMarketCategoriesViewModel.fetchMarketCategory(widget.token, requestModel);
    setState(() {
      _dataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final updateMarketCategoryViewModel = Provider.of<UpdateMarketCategoryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategori Sil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDropdownButtonFormField(),
                    SizedBox(height: screenHeight * 0.02),
                    if(_selectedMarketCategoryId != null)
                      DeleteMaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _onPressedUpdateCategory(updateMarketCategoryViewModel);
                          }
                        },
                        label: 'Kategori Sil',
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownButtonFormField() {
    return DropdownButtonFormField<int>(
      value: _selectedMarketCategoryId,
      items: _dataLoaded ? buildMarketCategoryDropdownItems(getMarketCategoriesViewModel.items) : null,
      onChanged: (value) {
        setState(() {
          _selectedMarketCategoryId = value;
          _selectedMarketCategoryName = getMarketCategoriesViewModel.items
              .firstWhere((category) => category.id == value)
              .categoryName;
        });
      },
      decoration: const InputDecoration(labelText: 'Kategori Seçin'),
      validator: (value) {
        if (value == null) {
          return 'Lütfen bir Kategori seçin!';
        }
        return null;
      },
    );
  }

  void _onPressedUpdateCategory(UpdateMarketCategoryViewModel updateMarketCategoryViewModel) async {
    if (_formKey.currentState!.validate()) {
      UpdateMarketCategoryModel updateMarketCategory = UpdateMarketCategoryModel(
        id: _selectedMarketCategoryId!,
        companyId: widget.companyId,
        categoryName: _selectedMarketCategoryName!,
        status: false,
        deleted: true,
      );

      ApiResult result = await updateMarketCategoryViewModel.updateMarketCategory(updateMarketCategory, widget.token);
      _handleApiResult(result);
    }
  }

  void _handleApiResult(ApiResult result) {
    if (result.success) {
      Navigator.pop(context, true);
      QuickAlertUtils.showSuccess(context, result.messages.join('\n'));
    } else {
      if(result.messages.isEmpty){
        QuickAlertUtils.showError(context, 'Oturum Sonlanmıştır. Tekrar giriş yapın.');
      }else{
        QuickAlertUtils.showError(context, result.messages.join('\n'));
      }
    }
  }
}
