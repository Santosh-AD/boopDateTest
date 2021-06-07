import 'package:graphql/client.dart';

class QueryFields {
  static QueryOptions getQueryOptionsForListProfile({
    bool id: true,
    bool bio: true,
    bool country: true,
    bool dob: true,
    bool gender: true,
    bool lat: true,
    bool lng: true,
    bool name: true,
    bool optin_marketing: true,
    bool photos: true,
    bool photosId: true,
    bool photosUrl: true,
    bool photosType: true,
  }) {
    return QueryOptions(
      document: gql(
        '''
          query fetchProfile{
            getAllProfiles{
             ${id ? 'id' : ''}
             ${bio ? 'bio' : ''}
             ${country ? 'country' : ''}
              dob
              gender
              lat
              lng
              name
              optin_marketing
              photos {
                id
                url
                type
              }
            }
          }
      ''',
      ),
    );
  }
}
