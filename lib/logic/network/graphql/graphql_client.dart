// ignore: import_of_legacy_library_into_null_safe
import 'package:graphql/client.dart';

class GraphQL{
  GraphQLClient getGraphQLClient(String? url) {
    Link link = HttpLink(url);
    return GraphQLClient(
      link: link,
      cache: GraphQLCache(), //Have not used any persistence HiveStore
    );
  }
}
