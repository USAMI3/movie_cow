import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_cow/core/services/api/client/dio_client.dart';

final Provider<UserApi> exampleApiProvider =
    Provider<UserApi>((ProviderRef<UserApi> ref) {
  final DioClient dioClient = ref.read(dioClientProvider);
  return UserApi(dioClient, ref);
});

class UserApi {
  UserApi(
    this._dioClient,
    this._ref,
  );

  final DioClient _dioClient;
  final Ref _ref;

  // // This is an example api call that reads another provider to find out the auth session token
  // // for the user and then uses our Dio client to make a GET request
  // Future<Response<dynamic>> getUserData() async {
  //   try {
  //     final String? authToken = await _ref.read(awsCognitoAuthProvider).authSessionToken;
  //     final Response<dynamic> response = await _dioClient.get(
  //       Endpoints.getUserData,
  //       options: Options(
  //         headers: <String, dynamic>{
  //           'Authorization': 'Bearer $authToken',
  //           'Accept': 'application/json',
  //         },
  //       ),
  //     );
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
