import '../../../wordpress_client.dart';

final class RetriveMediaRequest extends IRequest {
  RetriveMediaRequest({
    required this.id,
    this.context = RequestContext.view,
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
  int id;

  @override
  WordpressRequest build(Uri baseUrl) {
    final queryParameters = <String, dynamic>{}
      ..addIfNotNull('context', context?.name)
      ..addAllIfNotNull(extra);

    return WordpressRequest(
      method: HttpMethod.get,
      url: RequestUrl.relativeParts(['media', id]),
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
