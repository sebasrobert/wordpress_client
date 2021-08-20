import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';

import '../../../wordpress_client.dart';
import '../../utilities/helpers.dart';
import '../authorization_base.dart';

/// Similar to [BasicJwtAuth], this plugin is in active development and has much more features than the previous one. It is recommended to use this plugin instead of the previous one.
///
/// Implemented on basis of https://github.com/usefulteam/jwt-auth wordpress plugin.
class UsefulJwtAuth extends IAuthorization {
  UsefulJwtAuth(String? username, String? password, {Callback? callback}) : super(username, password, callback: callback);

  String? _encryptedAccessToken;
  DateTime? _lastAuthorizedTime;
  bool _hasValidatedOnce = false;
  bool _hasInit = false;
  Dio? _client;

  static final int daysUntilTokenExpiry = 3;
  static final String scheme = 'Bearer';

  @override
  bool get isValidAuth => !isNullOrEmpty(_encryptedAccessToken);

  bool get _isAuthExpiried => _lastAuthorizedTime != null && DateTime.now().difference(_lastAuthorizedTime!).inHours > (daysUntilTokenExpiry * 24);

  @override
  FutureOr<bool> authorize() async {
    if (isValidAuth) {
      return true;
    }

    if (_client == null) {
      return false;
    }

    if (!_isAuthExpiried && !_hasValidatedOnce && !isNullOrEmpty(_encryptedAccessToken)) {
      return validate();
    }

    try {
      final response = await _client!.post(
        parseUrl(WordpressClient.baseUrl, 'jwt-auth/v1/token'),
        data: {
          'username': userName,
          'password': password,
        },
        options: Options(
          method: 'POST',
          contentType: 'application/x-www-form-urlencoded',
        ),
      );

      if (response.statusCode != 200 || response.data == null) {
        return false;
      }

      callback?.invokeResponseCallback(response.data);

      if (response.data['data'] == null || !(response.data['success'] as bool)) {
        return false;
      }

      _encryptedAccessToken = response.data['data']['token'];

      if (_encryptedAccessToken != null) {
        _lastAuthorizedTime = DateTime.now();
      }

      return _hasValidatedOnce = !isNullOrEmpty(_encryptedAccessToken);
    } on DioError catch (e) {
      callback?.invokeRequestErrorCallback(e);
      return false;
    } catch (ex) {
      callback?.invokeUnhandledExceptionCallback(ex as dynamic);
      return false;
    }
  }

  @override
  FutureOr<bool> init(Dio? client) {
    if (_hasInit) {
      return true;
    }

    _client = client;
    _encryptedAccessToken = '';
    _hasValidatedOnce = false;
    return _hasInit = true;
  }

  @override
  FutureOr<bool> isAuthenticated() {
    if (_hasValidatedOnce && !isNullOrEmpty(_encryptedAccessToken)) {
      return true;
    }

    return false;
  }

  @override
  FutureOr<bool> validate() async {
    if (_client == null || isNullOrEmpty(_encryptedAccessToken)) {
      return false;
    }

    try {
      final response = await _client!.post(
        parseUrl(WordpressClient.baseUrl, 'jwt-auth/v1/token/validate'),
        options: Options(
          method: 'POST',
          headers: {'Authorization': await generateAuthUrl()},
        ),
      );

      if (response.statusCode != 200 || response.data == null) {
        return false;
      }

      callback?.invokeResponseCallback(response.data);
      return _hasValidatedOnce = ((response.data['code'] as String) == 'jwt_auth_valid_token');
    } on DioError catch (e) {
      callback?.invokeRequestErrorCallback(e);
      return false;
    } catch (ex) {
      callback?.invokeUnhandledExceptionCallback(ex as dynamic);
      return false;
    }
  }

  @override
  FutureOr<String?> generateAuthUrl() async {
    if (!await isAuthenticated()) {
      return null;
    }

    return '$scheme $_encryptedAccessToken';
  }
}