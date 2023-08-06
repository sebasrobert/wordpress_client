import '../../wordpress_client.dart';

final class PostsInterface extends IRequestInterface
    with
        CreateOperation<Post, CreatePostRequest>,
        DeleteOperation<DeletePostRequest>,
        RetriveOperation<Post, RetrivePostRequest>,
        UpdateOperation<Post, UpdatePostRequest>,
        ListOperation<Post, ListPostRequest> {}
