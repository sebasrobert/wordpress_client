import 'dart:convert';
import 'dart:io';

import 'package:wordpress_client/src/responses/user_response.dart';
import 'package:wordpress_client/wordpress_client.dart';

void main() async {
  File file = await File('example/test_settings.json');
  final json = jsonDecode(await file.readAsString());

  WordpressClient client = WordpressClient(
    json['base_url'],
    json['path'],
    bootstrapper: (builder) => builder
        .withDefaultMaxRedirects(5)
        .withFollowRedirects(true)
        .withRequestTimeout(60)
        .withDefaultAuthorization(
          Authorization(userName: json['username'], password: json['password'], authType: AuthorizationType.JWT),
        )
        .build(),
  );
  /*
  var listPostsResponse = await client.listPosts(
    (builder) => builder
        .withPerPage(10)
        .orderResultsBy(FilterOrder.DESCENDING)
        .withResponseValidationOverride((List<Post> response) {
          print('Response received in validator. (${response.length} posts)');
          return true;
        })
        .withCallback(
          Callback(
            unhandledExceptionCallback: (e) {
              print('Unhandled exception: ${e.toString()}');
            },
            responseCallback: (responseRaw) {
              print('Response received in Callback');
            },
          ),
        )
        .build(),
  );

  if (listPostsResponse == null || listPostsResponse.responseCode != 200) {
    print('Error: ' + listPostsResponse.responseCode.toString());
  }

  print('Request completed in ${listPostsResponse.duration.inSeconds} second(s)');
  print('Status Code: ${listPostsResponse.responseCode}');
  print('Total posts count: ${listPostsResponse.totalPostsCount}');
  print('Total pages count: ${listPostsResponse.totalPagesCount}');

  for (var post in listPostsResponse.value) {
    print('ID: ' + post.id.toString());
    print('Title: ' + post.title.parsedText.substring(0, 40) + '...');
    print('Content: ' + post.content.parsedText.substring(0, 40) + '...');
  }

  print('-------------------------------------------------------');

  var retrivePostResponse = await client.retrivePost(
    (builder) => builder
        .withPostId(466206)
        .withResponseValidationOverride((Post response) {
          print('Response received in validator. (${response.id})');
          return true;
        })
        .withCallback(
          Callback(
            unhandledExceptionCallback: (e) {
              print('Unhandled exception: ${e.toString()}');
            },
            responseCallback: (responseRaw) {
              print('Response received in Callback');
            },
          ),
        )
        .build(),
  );

  print('Request completed in ${retrivePostResponse.duration.inSeconds} second(s)');
  print('Status Code: ${retrivePostResponse.responseCode}');

  print('ID: ' + retrivePostResponse.value.id.toString());
  print('Title: ' + retrivePostResponse.value.title.parsedText.substring(0, 40) + '...');
  print('Content: ' + retrivePostResponse.value.content.parsedText.substring(0, 40) + '...');

  var listUsersResponse = await client.listUsers(
    (builder) => builder
        .withPerPage(10)
        .withResponseValidationOverride((List<User> response) {
          print('Response received in validator. (${response.length} users)');
          return true;
        })
        .withCallback(
          Callback(
            unhandledExceptionCallback: (e) {
              print('Unhandled exception: ${e.toString()}');
            },
            responseCallback: (responseRaw) {
              print('Response received in Callback');
            },
          ),
        )
        .build(),
  );

  print('Request completed in ${listUsersResponse.duration.inSeconds} second(s)');
  print('Status Code: ${listUsersResponse.responseCode}');

  for (var user in listUsersResponse.value) {
    print('ID: ' + user.id.toString());
    print('Username: ' + user.name);
    print('Slug: ${user.slug}');
  }
*/

  ResponseContainer<User> createUserResponse = await client.createUser(
    (builder) => builder
        .withNickname('Test User NName')
        .withPassword('testPasswordGenerated')
        .withDisplayName('Test User DName')
        .withEmail('xomifag205@nhmty.com')
        .withFirstName('test_firstName')
        .withLastName('test_lastName')
        .withLocale(Locale.en_US)
        .withSlug('testNewsDesk')
        .withUserName('testNewsDesk')
        .withCallback(
          Callback(unhandledExceptionCallback: (e) {
            print('Unhandled exception: ${e.toString()}');
          }, responseCallback: (responseRaw) {
            print('Response received in Callback');
          }, requestErrorCallback: (dioError) {
            print('Request error: ${dioError.response.data.toString()}');
          }, onSendProgress: (current, max) {
            print('onSendProgress: ' + current.toString() + ' - ' + max.toString());
          }, onReceiveProgress: (current, max) {
            print('onReceiveProgress: ' + current.toString() + ' - ' + max.toString());
          }),
        )
        .build(),
  );

  print('Request completed in ${createUserResponse?.duration?.inSeconds} second(s)');
  print('Status Code: ${createUserResponse.responseCode}');
  print('User created with ID: ${createUserResponse.value?.id}');
}
