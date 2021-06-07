import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_task/logic/model/exception_model.dart';
import 'package:test_task/logic/model/list_profile_response_model.dart';
import 'package:test_task/logic/network/base_network_status.dart';
import 'package:test_task/logic/repositories/profile_repo.dart';

part 'listprofile_event.dart';
part 'listprofile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.profileRepo) : super(ListProfileInitial());
  final ProfileRepo profileRepo;

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileListGetEvent) {
      //get an Event of List Get Event
      yield ProfileStateLoading();
      ApiResult result = await profileRepo.getProfileList();
      ApiStatus status = result.status;
      if (status == ApiStatus.success) {
        Data patchData = result.response;
        List<GetAllProfile> listPatch =
            patchData.getAllProfiles.where((e) => (e.photos!.length > 0)).toList();
        Data data = Data(getAllProfiles: listPatch);
        yield ListProfileStateSuccess(data);
      } else {
        yield ListProfileStateFailed(result.response);
      }
    }
  }
}
