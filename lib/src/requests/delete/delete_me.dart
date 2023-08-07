import '../../../wordpress_client.dart';
import '../../utilities/request_url.dart';

final class DeleteMeRequest extends IRequest {
  DeleteMeRequest({
    this.force,
    required this.reassign,
    super.cancelToken,
    super.authorization,
    super.events,
    super.receiveTimeout,
    super.requireAuth,
    super.sendTimeout,
    super.validator,
  });

  bool? force;
  int reassign;

  @override
  WordpressRequest build(Uri baseUrl) {
    final body = <String, dynamic>{}
      ..addIfNotNull('force', force)
      ..addIfNotNull('reassign', reassign);

    return WordpressRequest(
      body: body,
      method: HttpMethod.delete,
      url: RequestUrl.relativeParts(const ['users', 'me']),
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
