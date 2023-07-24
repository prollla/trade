import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:trade/models/paymentMethod.dart';
import 'package:trade/models/productModel.dart';
import 'package:trade/models/cartModel.dart';
import 'package:trade/models/orderListModel.dart';

import 'package:trade/service/authInterceptor.dart';

import '../models/deliveryModel.dart';
import '../models/sortingOptionModel.dart';

part 'apiService.g.dart';

@RestApi(baseUrl: "https://farm.fbtw.ru")
abstract class ApiService {
  factory ApiService(Dio dio) {
    String? authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkyNTI3ODM0LCJpYXQiOjE2ODk5MzU4MzQsImp0aSI6IjlhYmQwZTA0NTBmOTRiOTg5OTEyMjcwYTkyYWVhMWVhIiwidXNlcl9pZCI6NDYsImlzX3ZlcmlmaWVkIjp0cnVlfQ.aWFLKgY7jyU_f-CEt-XHuN2DwsvUcM9JWngKmE9BQA8"; // Замените на код получения токена

    dio.interceptors.add(AuthInterceptor(authToken));
    return _ApiService(dio);
  }
  @POST("/catalog/products/")
  Future<ApiResponse> postProductData(@Body() Map<String, dynamic> requestBody);

  @POST("/cart/cart/")
  Future<CartResponse> postCartData(@Body() Map<String, dynamic> requestBody);

  @PUT("/cart/cart/")
  Future<CartResponse> putCartData(@Body() Map<String, dynamic> requestBody);

  @DELETE("/cart/cart/")
  Future<CartResponse> deleteCartData(@Body() Map<String, dynamic> requestBody);

  @POST("/cart/calculate/")
  Future<CartResponse> calculateCart();

  @POST("/payments/")
  Future<List<PaymentMethod>> paymentData();

  @GET("/order/list/")
  Future<List<Order>> orderData();

  @GET("/catalog/sort_types/")
  Future<List<SortingOption>> sortData();

  @POST("/order/order/")
  Future<Order> makeOrder(@Body() Map<String, dynamic> requestBody);

  @POST("/deliveries/deliveries/")
  Future<List<Delivery>> deliveryData();
}
