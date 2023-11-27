import 'package:dartz/dartz.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/auth_local_datasource.dart';
import 'package:http/http.dart' as http;

import '../../common/constants/variables.dart';
import '../models/requests/add_address_request_model.dart';
import '../models/responses/add_address_response_model.dart';
import '../models/responses/buyer_order_response_model.dart';
import '../models/responses/get_address_response_model.dart';
import '../models/responses/order_detail_response_model.dart';
import '../models/responses/order_response_model.dart';
import '../models/requests/order_request_model.dart';

class OrderRemoteDatasource {
  Future<Either<String, OrderResponseModel>> order(
      OrderRequestModel request) async {
    final token = await AuthLocalDataSource().getToken();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/orders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return right(OrderResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }

  Future<Either<String, OrderDetailResponseModel>> getOrderById(
      String id) async {
    final token = await AuthLocalDataSource().getToken();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/orders/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return right(OrderDetailResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }

  Future<Either<String, BuyerOrderResponseModel>> getOrderByBuyerId() async {
    final token = await AuthLocalDataSource().getToken();
    final user = await AuthLocalDataSource().getUser();
    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/orders?filters[buyerId][\$eq]=${user.id}}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return right(BuyerOrderResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }

  //add address
  Future<Either<String, AddAddressResponseModel>> addAddress(
      AddAddressRequestModel request) async {
    final token = await AuthLocalDataSource().getToken();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/addresses'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return right(AddAddressResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }

  //delete address
  Future<Either<String, String>> deleteAddress(String id) async {
    final token = await AuthLocalDataSource().getToken();
    final response = await http.delete(
      Uri.parse('${Variables.baseUrl}/api/addresses/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return right('Address Deleted');
    } else {
      return left('Server Error');
    }
  }

  Future<Either<String, AddAddressResponseModel>> editAddress(
      AddAddressRequestModel request, String id) async {
    final token = await AuthLocalDataSource().getToken();
    final response = await http.put(
      Uri.parse('${Variables.baseUrl}/api/addresses/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return right(AddAddressResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }

  //get address by user id
  Future<Either<String, GetAddressResponseModel>> getAddressByUserId() async {
    final token = await AuthLocalDataSource().getToken();
    final user = await AuthLocalDataSource().getUser();
    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/addresses?filters[user_id][\$eq]=${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return right(GetAddressResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }

  Future<Either<String, GetAddressResponseModel>>
      getAddressByUserIdDefault() async {
    final token = await AuthLocalDataSource().getToken();
    final user = await AuthLocalDataSource().getUser();
    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/addresses?filters[user_id][\$eq]=${user.id}&filters[is_default]=true'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return right(GetAddressResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }
}
