import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/market/get_market_category_request_model.dart';
import '../../../models/market/get_market_product_request_model.dart';
import '../../../models/market/update_market_product_model.dart';
import '../../../utils/design/build_dropdown/build_market_category_dropdown_items.dart';
import '../../../utils/design/build_dropdown/build_market_product_dropdown_items.dart';
import '../../../utils/design/button_design/update_material_button.dart';
import '../../../utils/design/form_fields/generic_field.dart';
import '../../../utils/design/form_fields/number_field.dart';
import '../../../../utils/design/dialog_design/quick_alert_utils.dart';
import '../../../utils/result/api_result.dart';
import '../../../view_model/market/get_market_category_view_model.dart';
import '../../../view_model/market/get_market_product_view_model.dart';
import '../../../view_model/market/update_market_product_view_model.dart';

class UpdateMarketProductPage extends StatefulWidget {
  final int companyId;
  final String token;

  const UpdateMarketProductPage({super.key, required this.companyId, required this.token});

  @override
  UpdateMarketProductPageState createState() => UpdateMarketProductPageState();
}

class UpdateMarketProductPageState extends State<UpdateMarketProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late GetMarketCategoriesViewModel getMarketCategoriesViewModel;
  late GetMarketProductsViewModel getMarketProductsViewModel;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  bool _categoriesLoaded = false;
  bool _productsLoaded = false;
  int? _selectedMarketCategoryId;
  int? _selectedMarketProductId;
  final bool _status = true;
  final bool _deleted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getMarketCategories());
  }

  Future<void> _getMarketCategories() async {
    getMarketCategoriesViewModel = Provider.of<GetMarketCategoriesViewModel>(context, listen: false);
    GetMarketCategoryRequestModel requestModel = GetMarketCategoryRequestModel(companyId: widget.companyId, status: true, deleted: false,);
    await getMarketCategoriesViewModel.fetchMarketCategory(widget.token, requestModel);
    setState(() {
      _categoriesLoaded = true;
    });
  }

  Future<void> _getMarketProducts(int categoryId) async {
    setState(() {
      _productsLoaded = false;
    });
    getMarketProductsViewModel = Provider.of<GetMarketProductsViewModel>(context, listen: false);
    GetMarketProductRequestModel requestModel = GetMarketProductRequestModel(companyId: widget.companyId, marketCategoryId: categoryId, status: true, deleted: false);
    await getMarketProductsViewModel.fetchMarketProduct(widget.token, requestModel);
    setState(() {
      _productsLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final updateMarketProductViewModel = Provider.of<UpdateMarketProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün Güncelle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategoryDropdownButtonFormField(),
                SizedBox(height: screenHeight * 0.02),
                if (_selectedMarketCategoryId != null) _buildProductDropdownButtonFormField(),
                SizedBox(height: screenHeight * 0.02),
                if (_selectedMarketProductId != null) ...[
                  GenericTextField(controller: _productNameController, label: 'Ürün İsmi'),
                  SizedBox(height: screenHeight * 0.02),
                  NumberField(controller: _productPriceController, label: 'Ürün Fiyatı'),
                  SizedBox(height: screenHeight * 0.02),
                  UpdateMaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _onPressedUpdateProduct(updateMarketProductViewModel);
                      }
                    },
                    label: 'Ürün Düzenle',
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdownButtonFormField() {
    return DropdownButtonFormField<int>(
      value: _selectedMarketCategoryId,
      items: _categoriesLoaded ? buildMarketCategoryDropdownItems(getMarketCategoriesViewModel.items) : null,
      onChanged: (value) {
        setState(() {
          _selectedMarketCategoryId = value;
          _selectedMarketProductId = null;
          if (value != null) {
            _getMarketProducts(value);
          }
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

  Widget _buildProductDropdownButtonFormField() {
    return DropdownButtonFormField<int>(
      value: _selectedMarketProductId,
      items: _productsLoaded ? buildMarketProductDropdownItems(getMarketProductsViewModel.items) : null,
      onChanged: (value) {
        setState(() {
          _selectedMarketProductId = value;
          var selectedProduct = getMarketProductsViewModel.items.firstWhere((product) => product.id == value);
          _productNameController.text = selectedProduct.productName;
          _productPriceController.text = selectedProduct.productPrice.toString();
        });
      },
      decoration: const InputDecoration(labelText: 'Ürün Seçin'),
      validator: (value) {
        if (value == null) {
          return 'Lütfen bir Ürün seçin!';
        }
        return null;
      },
    );
  }

  void _onPressedUpdateProduct(UpdateMarketProductViewModel updateMarketProductViewModel) async {
    if (_formKey.currentState!.validate()) {
      UpdateMarketProductModel updateMarketProduct = UpdateMarketProductModel(
        id: _selectedMarketProductId!,
        companyId: widget.companyId,
        productName: _productNameController.text,
        marketCategoryId: _selectedMarketCategoryId!,
        productPrice: double.parse(_productPriceController.text),
        status: _status,
        deleted: _deleted,
      );

      ApiResult result = await updateMarketProductViewModel.updateMarketProduct(updateMarketProduct, widget.token);
      _handleApiResult(result);
    }
  }

  void _handleApiResult(ApiResult result) {
    if (result.success) {
      Navigator.pop(context, true);
      QuickAlertUtils.showSuccess(context, result.messages.join('\n'));
    } else {
      QuickAlertUtils.showError(context, result.messages.isEmpty ? 'Oturum Sonlanmıştır. Tekrar giriş yapın.' : result.messages.join('\n'));
    }
  }
}