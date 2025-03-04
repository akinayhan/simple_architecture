import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/market/create_market_product_model.dart';
import '../../../models/market/get_market_category_request_model.dart';
import '../../../utils/design/build_dropdown/build_market_category_dropdown_items.dart';
import '../../../utils/design/button_design/create_material_button.dart';
import '../../../utils/design/form_fields/generic_field.dart';
import '../../../utils/design/form_fields/number_field.dart';
import '../../../../utils/design/dialog_design/quick_alert_utils.dart';
import '../../../utils/result/api_result.dart';
import '../../../view_model/market/create_market_product_view_model.dart';
import '../../../view_model/market/get_market_category_view_model.dart';

class AddMarketProductPage extends StatefulWidget {
  final int companyId;
  final String token;

  const AddMarketProductPage({super.key, required this.companyId, required this.token});

  @override
  AddMarketProductPageState createState() => AddMarketProductPageState();
}

class AddMarketProductPageState extends State<AddMarketProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late GetMarketCategoriesViewModel getMarketCategoriesViewModel;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool _dataLoaded = false;
  int? _selectedMarketCategoryId;

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
    final createMarketProductViewModel = Provider.of<CreateMarketProductViewModel>(context);
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün Ekle"),
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
                    if (_selectedMarketCategoryId != null)
                    GenericTextField(controller: _productNameController, label: 'Ürün İsmi'),
                    SizedBox(height: screenHeight * 0.02),
                    if (_selectedMarketCategoryId != null)
                    NumberField(controller: _priceController, label: 'Ürün Fiyatı',),
                    SizedBox(height: screenHeight * 0.02),
                    if (_selectedMarketCategoryId != null)
                    CreateMaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _onPressedCreateMarketProduct(createMarketProductViewModel);
                        }
                      },
                      label: 'Ürün Ekle',
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

  void _onPressedCreateMarketProduct(CreateMarketProductViewModel createMarketProductViewModel) async {
    if (_formKey.currentState!.validate()) {
      CreateMarketProductModel newProduct = CreateMarketProductModel(
        companyId: widget.companyId,
        productName: _productNameController.text,
        marketCategoryId: _selectedMarketCategoryId!,
        productPrice: double.parse(_priceController.text),
      );

      ApiResult result = await createMarketProductViewModel.createMarketProduct(newProduct, widget.token);
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
