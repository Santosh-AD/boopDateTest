// ignore: import_of_legacy_library_into_null_safe
import 'package:graphql/client.dart';
import 'package:test_task/core/lang.dart';
import 'package:test_task/logic/model/exception_model.dart';
import 'package:test_task/logic/model/list_profile_response_model.dart';
import 'package:test_task/logic/network/base_network.dart';
import 'package:test_task/logic/network/base_network_status.dart';
import 'package:test_task/logic/network/graphql/graphql_client.dart';
import 'package:test_task/logic/network/graphql/query_options.dart';

//Comments
class ProfileApi {
  GraphQL graphQL;
  ProfileApi(this.graphQL);
  Future<ApiResult> getListApi() async {
    GraphQLClient client = graphQL.getGraphQLClient(BaseNetwork.URL);
    QueryOptions options = QueryFields.getQueryOptionsForListProfile();
    try {
      QueryResult result = await client.query(options);
      if (result.hasException) {
        print(result.exception.linkException.originalException.toString());

        return ApiResult(
            status: ApiStatus.failed,
            response: ExceptionModel(
                title: "Exception Found", msg: result.exception.graphqlErrors.iterator.toString()));
      }

      return ApiResult(status: ApiStatus.success, response: Data.fromJson(result.data));
    } catch (_) {
      return ApiResult(
          status: ApiStatus.failed,
          response: ExceptionModel(
              title: English.connectivityErrorTitle, msg: English.connectivityErrorMsg));
    }
  }
}
