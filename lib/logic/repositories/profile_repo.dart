import 'package:test_task/logic/network/base_network_status.dart';
import 'package:test_task/logic/network/profile_api.dart';

class ProfileRepo {
  final ProfileApi api;
  ProfileRepo(this.api);

  Future<ApiResult> getProfileList() async {
    //We can add a connection check here and return local data or network data
    return api.getListApi();
  }
}
