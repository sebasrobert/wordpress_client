import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'authorization/authorization_base.dart';
import 'constants.dart';
import 'utilities/typedefs.dart';

@immutable
final class BootstrapConfiguration {
  const BootstrapConfiguration({
    this.requestTimeout = kDefaultRequestTimeout,
    this.responsePreprocessorDelegate,
    this.defaultAuthorization,
    this.defaultUserAgent,
    this.defaultHeaders,
    this.shouldFollowRedirects = false,
    this.maxRedirects = 5,
    this.synchronized = false,
    this.statisticsDelegate,
    this.interceptors,
    this.enableDebugMode = false,
  });

  final bool enableDebugMode;
  final Duration requestTimeout;
  final bool Function(dynamic)? responsePreprocessorDelegate;
  final IAuthorization? defaultAuthorization;
  final String? defaultUserAgent;
  final Map<String, dynamic>? defaultHeaders;
  final bool shouldFollowRedirects;
  final int maxRedirects;
  final List<Interceptor>? interceptors;
  final bool synchronized;
  final StatisticsCallback? statisticsDelegate;

  @override
  bool operator ==(covariant BootstrapConfiguration other) {
    if (identical(this, other)) {
      return true;
    }
    final collectionEquals = const DeepCollectionEquality().equals;

    return other.enableDebugMode == enableDebugMode &&
        other.requestTimeout == requestTimeout &&
        other.responsePreprocessorDelegate == responsePreprocessorDelegate &&
        other.defaultAuthorization == defaultAuthorization &&
        other.defaultUserAgent == defaultUserAgent &&
        collectionEquals(other.defaultHeaders, defaultHeaders) &&
        other.shouldFollowRedirects == shouldFollowRedirects &&
        other.maxRedirects == maxRedirects &&
        collectionEquals(other.interceptors, interceptors) &&
        other.synchronized == synchronized &&
        other.statisticsDelegate == statisticsDelegate;
  }

  @override
  int get hashCode {
    return enableDebugMode.hashCode ^
        requestTimeout.hashCode ^
        responsePreprocessorDelegate.hashCode ^
        defaultAuthorization.hashCode ^
        defaultUserAgent.hashCode ^
        defaultHeaders.hashCode ^
        shouldFollowRedirects.hashCode ^
        maxRedirects.hashCode ^
        interceptors.hashCode ^
        synchronized.hashCode ^
        statisticsDelegate.hashCode;
  }

  BootstrapConfiguration copyWith({
    bool? enableDebugMode,
    Duration? requestTimeout,
    bool Function(dynamic)? responsePreprocessorDelegate,
    IAuthorization? defaultAuthorization,
    String? defaultUserAgent,
    Map<String, dynamic>? defaultHeaders,
    bool? shouldFollowRedirects,
    int? maxRedirects,
    List<Interceptor>? interceptors,
    bool? synchronized,
    StatisticsCallback? statisticsDelegate,
  }) {
    return BootstrapConfiguration(
      enableDebugMode: enableDebugMode ?? this.enableDebugMode,
      requestTimeout: requestTimeout ?? this.requestTimeout,
      responsePreprocessorDelegate:
          responsePreprocessorDelegate ?? this.responsePreprocessorDelegate,
      defaultAuthorization: defaultAuthorization ?? this.defaultAuthorization,
      defaultUserAgent: defaultUserAgent ?? this.defaultUserAgent,
      defaultHeaders: defaultHeaders ?? this.defaultHeaders,
      shouldFollowRedirects:
          shouldFollowRedirects ?? this.shouldFollowRedirects,
      maxRedirects: maxRedirects ?? this.maxRedirects,
      interceptors: interceptors ?? this.interceptors,
      synchronized: synchronized ?? this.synchronized,
      statisticsDelegate: statisticsDelegate ?? this.statisticsDelegate,
    );
  }
}
