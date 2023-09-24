// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _UserApiService implements UserApiService {
  _UserApiService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://localhost:3005/api/v1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<UserModel>> registerUser(
    @Body() RegisterRequestData registerRequestData, // Specify the type
    @Header('Content-Type')
    String contentType, // Specify the type and add @Header annotation
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};

    // Remove the following line, it's not needed
    // _headers.removeWhere((k, v) => v == null);

    final _data = registerRequestData
        .toJson(); // Assuming you have a toJson method in RegisterRequestData
    final _result = await _dio.fetch<Map<String, dynamic>>(
      _setStreamType<HttpResponse<UserModel>>(Options(
        method: 'POST',
        headers: _headers,
        extra: _extra,
        contentType: contentType,
      ))
          .compose(
            _dio.options,
            '/auth/register',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
    );

    final value = UserModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  Options _setStreamType<T>(Options requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
