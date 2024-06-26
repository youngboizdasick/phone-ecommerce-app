import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notification_center/notification_center.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/brand.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/cart.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/customer.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/product_basic.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/product_item.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/services/api_urls.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/services/dio_helper.dart';
import '../models/address.dart';
import '../models/cart_product.dart';

class ApiServices {
  final Dio api = Dio();
  String? accessToken;
  final _storage = const FlutterSecureStorage();
  static List<Map<String, dynamic>> cartProducts = [];

  ApiServices() {
    api.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!options.path.contains('http')) {
            options.path = '${ApiUrls().IDENTITY_URL}${options.path}';
          }
          options.headers['Authorization'] = 'Bearer $accessToken';
          options.headers['appCode'] = 'RETAIL';
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if ((error.response?.statusCode ==
                  401 /* &&
              error.response?.data['message'] == "Invalid JWT"*/
              )) {
            if (await _storage.containsKey(key: 'refreshToken')) {
              // will throw error below
              await refreshToken();
              getAndStoreCurrentCartId();
              return handler.resolve(await _retry(error.requestOptions));
            }
          }
          return handler.next(error);
        },
      ),
    );

    api.interceptors.add(CurlLoggerDioInterceptor());

    // api.interceptors.add(PrettyDioLogger());
  }

  Future<void> refreshToken() async {
    try {
      final refreshToken = await _storage.read(key: 'refreshToken');
      final response = await api.post(
        ApiUrls().API_REFRESH_TOKEN,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        // successfully got the new access token
        accessToken = response.data['data']['accessToken'];
      } else {
        // log out user.
        accessToken = null;
        _storage.deleteAll();
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<void> storeTokens(Map<String, dynamic> data) async {
    await _storage.write(
        key: 'accessToken', value: data['data']['accessToken']);
    await _storage.write(
        key: 'refreshToken', value: data['data']['refreshToken']);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refreshToken');
  }

  Future<void> storeUid(String? uid) async {
    await _storage.write(key: 'uid', value: uid);
  }

  Future<String?> getUid() async {
    return await _storage.read(key: 'uid');
  }

  Future<void> storeUsername(
    String? username,
  ) async {
    await _storage.write(key: 'username', value: username);
  }

  Future<void> storePwd(String? password) async {
    await _storage.write(key: 'password', value: password);
  }

  Future<String?> getUsername() async {
    return await _storage.read(key: 'username');
  }

  Future<String?> getPassword() async {
    return await _storage.read(key: 'password');
  }

  Future<void> storeCurrentCartId(String? id) async {
    await _storage.write(key: 'currentCartId', value: id);
  }

  Future<String?> getCurrentCartId() async {
    return await _storage.read(key: 'currentCartId');
  }

  Future<void> storeAddressId(String? id) async {
    await _storage.write(key: 'addressId', value: id);
  }

  Future<String?> getAddressId() async {
    return await _storage.read(key: 'addressId');
  }

  Future<void> storePhoneId(String? id) async {
    await _storage.write(key: 'phoneId', value: id);
  }

  Future<String?> getPhoneId() async {
    return await _storage.read(key: 'phoneId');
  }

  // SGU Identity Swagger

  Future<bool> loginUser(String username, String password) async {
    try {
      final response = await api.post(
        ApiUrls().API_AUTH,
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        getAndStoreCurrentCartId();
        storeTokens(response.data);
        CustomerModel? customerModel = await getCustomerInformation();
        CustomerAddresses? primaryAddress;
        for (CustomerAddresses? customerAddresses
            in customerModel!.customerAddresses!) {
          if (customerAddresses?.isPrimary == true)
            primaryAddress = customerAddresses;
        }
        CustomerPhones? primaryPhones;
        for (CustomerPhones? customerPhones in customerModel.customerPhones!) {
          if (customerPhones?.isPrimary == true) primaryPhones = customerPhones;
        }
        storeAddressId(primaryAddress?.id.toString());
        storePhoneId(primaryPhones?.id.toString());
        return true;
      } else {
        ApiHelper.handleNon200Response(response);
        return false;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return false;
  }

  Future<int?> register(String username, String password) async {
    try {
      final response = await api.post(
        ApiUrls().API_REGISTER,
        data: {'username': username, 'password': password},
      );

      if (response.data['meta']['success'] == false) {
        return 0;
      }

      if (response.statusCode == 200) {
        return 1;
      } else {
        ApiHelper.handleNon200Response(response);
        return -1;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return -1;
  }

  Future<bool> logout() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
    return true;
  }

  Future<bool> changePwd(String password) async {
    try {
      final response = await api.put(
        ApiUrls().API_CHANGEPWD,
        data: {'password': password},
      );

      if (response.data['meta']['success'] == true) {
        storePwd(password);
        return true;
      } else {
        ApiHelper.handleNon200Response(response);
        return false;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return false;
  }

  // SGU Product Swagger

  Future<List<BrandModel>?> getBrands() async {
    final url = '${ApiUrls().PRODUCT_URL}/App/Brand';
    final params = {
      'page': 1,
      'size': 10,
    };

    try {
      final response = await api.get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> brands = [];
        for (dynamic brand in response.data['data']) {
          brands.add(brand);
        }
        return BrandModel.fromList(brands);
      } else {
        ApiHelper.handleNon200Response(response);
        return null;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return null;
  }

  Future<List<ProductBasicModel>?> getProductLineByBrand(
      {String? brandId}) async {
    if (brandId == null) {
      ApiHelper.logUnexpectedError('BrandId is null');
      return null;
    }

    final url = '${ApiUrls().PRODUCT_URL}/App/Product';
    final params = {
      'brandId': brandId,
      'page': 1,
      'size': 10,
    };

    try {
      final response = await api.get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> products = [];
        for (dynamic product in response.data['data']) {
          products.add(product);
        }
        return ProductBasicModel.fromList(products);
      } else {
        ApiHelper.handleNon200Response(response);
        return null;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return null;
  }

  Future<List<ProductItemModel>?> getItemsByProductLine({
    String? productId,
    String? productCode,
    String? name,
    String? brandId,
    int? page,
  }) async {
    final url = '${ApiUrls().PRODUCT_URL}/App/ProductItem';
    final params = {
      'productId': productId,
      'productCode': productCode,
      'name': name,
      'brandId': brandId,
      'page': page ?? 1,
      'size': 10,
    };

    try {
      final response = await api.get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> products = [];
        for (dynamic product in response.data['data']) {
          products.add(product);
        }
        return ProductItemModel.fromList(products);
      } else {
        ApiHelper.handleNon200Response(response);
        return null;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return null;
  }

  Future<int> getTotalProductsByLine({
    String? productId,
    String? productCode,
    String? name,
    String? brandId,
    int? page,
  }) async {
    final url = '${ApiUrls().PRODUCT_URL}/App/ProductItem';
    final params = {
      'productId': productId,
      'productCode': productCode,
      'name': name,
      'brandId': brandId,
      'page': page ?? 1,
      'size': 10,
    };

    try {
      final response = await api.get(url, queryParameters: params);
      if (response.statusCode == 200) {
        return response.data['meta']['total'];
      } else {
        ApiHelper.handleNon200Response(response);
        return 0;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return 0;
  }

  // ------- address
  Future<List<AddressModel>?> getListProvince() async {
    final url =
        '${ApiUrls().URL_8001}${ApiUrls().API_AdministrativeDivision}/Province';
    try {
      final response = await api.get(url);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> provinces = [];
        for (dynamic province in response.data['data']) {
          provinces.add(province);
        }
        return AddressModel.fromList(provinces);
      } else {
        ApiHelper.handleNon200Response(response);
        return null;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return null;
  }

  Future<List<AddressModel>?> getListDistrict({
    required int provinceCode,
    int? districtCode,
  }) async {
    final url =
        '${ApiUrls().URL_8001}/App/AdministrativeDivision/Administrative';
    final params = {'provinceCode': provinceCode, 'districtCode': districtCode};

    try {
      final response = await api.get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> districts = [];
        for (dynamic district in response.data['data']['districts']) {
          districts.add(district);
        }
        return AddressModel.fromList(districts);
      } else {
        ApiHelper.handleNon200Response(response);
        return null;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return null;
  }

  Future<List<AddressModel>?> getListWard({
    required int provinceCode,
    required int districtCode,
  }) async {
    final url =
        '${ApiUrls().URL_8001}/App/AdministrativeDivision/Administrative';
    final params = {
      'provinceCode': provinceCode,
      'districtCode': districtCode,
    };

    try {
      final response = await api.get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> wards = [];
        for (dynamic ward in response.data['data']['wards']) {
          wards.add(ward);
        }
        return AddressModel.fromList(wards);
      } else {
        ApiHelper.handleNon200Response(response);
        return null;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return null;
  }

  // user -------

  Future<CustomerModel?> getCustomerInformation() async {
    final url = '${ApiUrls().URL_8001}/App/Customer';

    try {
      final response = await api.get(url);
      if (response.statusCode == 200) {
        CustomerModel customerModel =
            CustomerModel.fromJson(response.data['data']);
        storeUid(customerModel.id);
        return customerModel;
      } else {
        ApiHelper.handleNon200Response(response);
        return null;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return null;
  }

  Future<bool> changeInformation({
    required String? name,
    required String? email,
    required int? birthday,
  }) async {
    final url = '${ApiUrls().URL_8001}/App/Customer';
    try {
      final response = await api.put(
        url,
        data: {'name': name, 'email': email, 'birthday': birthday},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        ApiHelper.handleNon200Response(response);
        return false;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return false;
  }

  Future<bool> addPhone(
      {required bool? isPrimary, required String? phoneNumber}) async {
    final url = '${ApiUrls().URL_8001}/App/Customer/CustomerPhone';
    try {
      final response = await api.post(
        url,
        data: {'isPrimary': isPrimary, 'phoneNumber': phoneNumber},
      );

      if (response.statusCode == 200) {
        if (isPrimary == true) storePhoneId(response.data['data']);
        return true;
      } else {
        ApiHelper.handleNon200Response(response);
        return false;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return false;
  }

  Future<bool> addAddress({
    required String? address,
    required bool? isPrimary,
    required int? wardCode,
    required int? districtCode,
    required int? provinceCode,
  }) async {
    final url = '${ApiUrls().URL_8001}/App/Customer/CustomerAddress';
    try {
      final response = await api.post(
        url,
        data: {
          'address': address,
          'isPrimary': isPrimary,
          'wardCode': wardCode,
          'districtCode': districtCode,
          'provinceCode': provinceCode,
        },
      );

      if (response.statusCode == 200) {
        if (isPrimary == true) storeAddressId(response.data['data']);
        return true;
      } else {
        ApiHelper.handleNon200Response(response);
        return false;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return false;
  }

  Future<bool> changeAddress({
    required String? id,
    required String? address,
    required bool? isPrimary,
    required int? wardCode,
    required int? districtCode,
    required int? provinceCode,
  }) async {
    final url = '${ApiUrls().URL_8001}/App/Customer/CustomerAddress/$id';
    if (isPrimary == true) storeAddressId(id);
    try {
      final response = await api.put(
        url,
        data: {
          'address': address,
          'isPrimary': isPrimary,
          'wardCode': wardCode,
          'districtCode': districtCode,
          'provinceCode': provinceCode,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        ApiHelper.handleNon200Response(response);
        return false;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return false;
  }

  Future<bool> changePhone({
    required String? id,
    required String? phoneNumber,
    required bool? isPrimary,
  }) async {
    final url = '${ApiUrls().URL_8001}/App/Customer/CustomerPhone/$id';
    if (isPrimary == true) storePhoneId(id);
    try {
      final response = await api.put(
        url,
        data: {'phoneNumber': phoneNumber, 'isPrimary': isPrimary},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        ApiHelper.handleNon200Response(response);
        return false;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return false;
  }

  // cart ------------

  Future<bool> postProductToCart({
    required String? productItemId,
    required String? productItemName,
    required String? productItemImageUrl,
    required int? price,
  }) async {
    final url = '${ApiUrls().URL_8001}/App/Cart/Product';
    final currentCartId = await getCurrentCartId();
    try {
      final response = await api.post(
        url,
        data: {
          'cardId': currentCartId,
          'productItemId': productItemId,
          'productItemName': productItemName,
          'productItemImageUrl': productItemImageUrl,
          'quantity': 1,
          'price': price,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        ApiHelper.handleNon200Response(response);
        return false;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return false;
  }

  Future<CartModel?> getCurrentCart() async {
    cartProducts.clear();
    final url = '${ApiUrls().URL_8001}/App/Cart';
    try {
      final response = await api.get(url);

      if (response.statusCode == 200) {
        CartModel cartModel = CartModel.fromJson(response.data['data']);
        for (CartProducts cartProduct in cartModel.cartProducts!) {
          CartProduct product = CartProduct();
          product.productItemId = cartProduct.productItemId;
          product.productItemImageUrl = cartProduct.productItemImageUrl;
          product.productItemName = cartProduct.productItemName;
          product.quantity = cartProduct.quantity;
          product.price = cartProduct.price;
          cartProducts.add(product.toJson());
        }
        return cartModel;
      } else {
        ApiHelper.handleNon200Response(response);
        return null;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return null;
  }

  Future<void> getAndStoreCurrentCartId() async {
    final url = '${ApiUrls().URL_8001}/App/Cart';
    try {
      final response = await api.get(url);

      if (response.statusCode == 200) {
        storeCurrentCartId(response.data['data']['id']);
        NotificationCenter().notify<int>('currentCartLength',
            data: response.data['data']['cartProducts'].length);
      } else {
        ApiHelper.handleNon200Response(response);
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
  }

  Future<bool> delProductToCart({
    required String? id,
  }) async {
    final url = '${ApiUrls().URL_8001}/App/Cart/Product/$id';
    try {
      final response = await api.delete(url);

      if (response.statusCode == 200) {
        return true;
      } else {
        ApiHelper.handleNon200Response(response);
        return false;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return false;
  }

  Future<bool> payment() async {
    final url = '${ApiUrls().URL_8001}/App/Cart/Payment';
    String? addressId = await getAddressId();
    String? phoneId = await getPhoneId();
    if (addressId.toString() == 'null' || phoneId.toString() == 'null') {
      return false;
    }
    try {
      // for (Map<String, dynamic> cartProduct in cartProducts) {
      //   if (await checkSerialProductItem(id: cartProduct['productItemId']) ==
      //       false) {
      //     print('checkSerialProductItem ${cartProduct['productItemId']}');
      //     return false;
      //   }
      // }
      final response = await api.post(
        url,
        data: {
          'customerAddressId': addressId,
          'customerPhoneId': phoneId,
          'cartProducts': cartProducts
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        ApiHelper.handleNon200Response(response);
        return false;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return false;
  }

  Future<bool> updateProduct({
    required String? id,
    required int? quantity,
    required int? price,
  }) async {
    final url = '${ApiUrls().URL_8001}/App/Cart/Product/$id';
    try {
      final response = await api.put(
        url,
        data: {'quantity': quantity, 'price': price},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        ApiHelper.handleNon200Response(response);
        return false;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return false;
  }

  Future<ProductItemModel?> getProductItem({required String? id}) async {
    final url = '${ApiUrls().PRODUCT_URL}/App/Cart/ProductItem/$id';
    try {
      final response = await api.get(url);

      if (response.statusCode == 200) {
        return ProductItemModel.fromJson(response.data['data']);
      } else {
        ApiHelper.handleNon200Response(response);
        return null;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return null;
  }

  Future<bool> checkSerialProductItem({required String? id}) async {
    final url = '${ApiUrls().PRODUCT_URL}/App/ProductItemSerial';
    try {
      final response = await api.post(url, data: {'data': id});
      if (response.statusCode == 200) {
        return true;
      } else {
        ApiHelper.handleNon200Response(response);
        return false;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return false;
  }

  Future<bool> cancelCart({required String? id}) async {
    final url = '${ApiUrls().URL_8001}/App/Cart/$id';
    try {
      final response = await api.put(
        url,
        data: {'workflowStateId': '5744eeba-9457-4005-a5ec-a8d6354e74f8'},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        ApiHelper.handleNon200Response(response);
        return false;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return false;
  }

  Future<List<OldCartModel>?> getHistoryCart() async {
    final url = '${ApiUrls().URL_8001}/App/Cart/History';
    try {
      final response = await api.get(url);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> historyCarts = [];
        for (dynamic cart in response.data['data']) {
          historyCarts.add(cart);
        }
        return OldCartModel.fromList(historyCarts);
      } else {
        ApiHelper.handleNon200Response(response);
        return null;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return null;
  }

  Future<bool> rating({
    required int? ratingStar,
    required String? productItemId,
  }) async {
    // check exception ratingStar or productItemId
    if (ratingStar == null || productItemId == null) {
      ApiHelper.logUnexpectedError("Rating star or product item ID is null");
      return false;
    }

    if (ratingStar < 1 || ratingStar > 5) {
      ApiHelper.logUnexpectedError("Rating star must be between 1 and 5");
      return false;
    }

    final url = '${ApiUrls().PRODUCT_URL}/App/Rating';
    String? userId = await getUid();
    if (userId == null) {
      ApiHelper.logUnexpectedError("User ID is null");
      return false;
    }
    ProductItemModel? productItemModel =
        await getProductItem(id: productItemId);
    if (productItemModel == null) {
      ApiHelper.logUnexpectedError("Product item model is null");
      return false;
    }

    try {
      final response = await api.post(url, data: {
        "ratingStar": ratingStar,
        "productItemId": productItemId,
        "productItemCode": productItemModel.code.toString(),
        "userId": userId
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        ApiHelper.handleNon200Response(response);
        return false;
      }
    } on DioException catch (e) {
      ApiHelper.handleDioException(e);
    } catch (e) {
      ApiHelper.logUnexpectedError(e);
    }
    return false;
  }
}

class CurlLoggerDioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Log the request as cURL command
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
