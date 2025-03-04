import '../../../wordpress_client.dart';

final class RetriveApplicationPasswordRequest extends IRequest {
  RetriveApplicationPasswordRequest({
    required this.userId,
    required this.uuid,
    super.cancelToken,
    super.authorization,
    super.events,
    super.receiveTimeout,
    super.requireAuth = true,
    super.sendTimeout,
    super.validator,
    super.extra,
  });

  int userId;
  String uuid;

  @override
  WordpressRequest build(Uri baseUrl) {
    return WordpressRequest(
      method: HttpMethod.get,
      url: RequestUrl.relativeParts(
        [
          'users',
          userId.toString(),
          uuid,
        ],
      ),
      requireAuth: requireAuth,
      cancelToken: cancelToken,
      authorization: authorization,
      events: events,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      validator: validator,
    );
  }
}
