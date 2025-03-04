import '../../../wordpress_client.dart';

final class RetriveCommentRequest extends IRequest {
  RetriveCommentRequest({
    required this.id,
    this.context,
    this.password,
    super.cancelToken,
    super.authorization,
    super.events,
    super.receiveTimeout,
    super.requireAuth = false,
    super.sendTimeout,
    super.validator,
    super.extra,
  });

  RequestContext? context;
  String? password;
  int id;

  @override
  WordpressRequest build(Uri baseUrl) {
    final queryParameters = <String, dynamic>{}
      ..addIfNotNull('context', context?.name)
      ..addIfNotNull('password', password)
      ..addAllIfNotNull(extra);

    return WordpressRequest(
      method: HttpMethod.get,
      url: RequestUrl.relativeParts(['comments', id]),
      queryParameters: queryParameters,
      requireAuth: requireAuth || context == RequestContext.edit,
      cancelToken: cancelToken,
      authorization: authorization,
      events: events,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      validator: validator,
    );
  }
}
