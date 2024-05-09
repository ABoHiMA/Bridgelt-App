// import 'package:dio/dio.dart';

// class DioHelper {
//   static Dio dio = Dio(
//     BaseOptions(
//       baseUrl: "https://student.valuxapps.com/api/",
//       receiveDataWhenStatusError: true,
//     ),
//   );

//   static Future<Response> getData({
//     required String url,
//     Map<String, dynamic>? query,
//     String lng = 'en',
//     String? token,
//   }) async {
//     dio.options.headers = {
//       'Content-Type': 'application/json',
//       'lang': lng,
//       'Authorization': token,
//     };

//     return await dio.get(
//       url,
//       queryParameters: query,
//     );
//   }

//   static Future<Response> postData({
//     required String url,
//     required Map<String, dynamic> data,
//     Map<String, dynamic>? query,
//     String lng = 'en',
//     String? token,
//   }) {
//     dio.options.headers = {
//       'Content-Type': 'application/json',
//       'lang': lng,
//       'Authorization': token,
//     };

//     return dio.post(
//       url,
//       queryParameters: query,
//       data: data,
//     );
//   }
  
//   static Future<Response> putData({
//     required String url,
//     required Map<String, dynamic> data,
//     Map<String, dynamic>? query,
//     String lng = 'en',
//     String? token,
//   }) {
//     dio.options.headers = {
//       'Content-Type': 'application/json',
//       'lang': lng,
//       'Authorization': token,
//     };

//     return dio.put(
//       url,
//       queryParameters: query,
//       data: data,
//     );
//   }
// }
