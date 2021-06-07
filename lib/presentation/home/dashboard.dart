import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/logic/bloc/list_profile/listprofile_bloc.dart';
import 'package:test_task/logic/model/list_profile_response_model.dart';
import 'package:test_task/presentation/widget/common_loading.dart';
import 'package:test_task/presentation/widget/common_toasting.dart';

class DashboardView extends StatefulWidget {
  static const route = '/';
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  ProfileBloc? profileBloc;
  List<GetAllProfile> data = [];
  @override
  void initState() {
    if (mounted) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        profileBloc?.add(ProfileListGetEvent());
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Boop Date'),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileStateLoading) {
            showLoading(context);
          }
          if (state is ListProfileStateSuccess) {
            hideLoading(context);
            data = state.data.getAllProfiles;
            setState(() {});
          }
          if (state is ListProfileStateFailed) {
            hideLoading(context);
            showToast(context, message: state.data.msg, title: state.data.title);
          }
        },
        child: data.length == 0
            ? Center(
                child: OutlinedButton(
                  onPressed: () {
                    profileBloc?.add(ProfileListGetEvent());
                  },
                  child: Text('Retry'),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  GetAllProfile profile = data[index];
                  return Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getWidget(heading: "name", value: profile.name, showIfNull: true),
                          getWidget(
                              heading: "gender",
                              value: profile.gender?.index == 1 ? 'Male' : 'Female'),
                          getWidget(heading: "dob", value: profile.dob),
                          getWidget(heading: "bio", value: profile.bio, showIfNull: true),
                          getWidget(heading: "PhotoId 1st", value: profile.photos![0].id),
                          getWidget(heading: "PhotoType 1st Type", value: profile.photos![0].type),
                          getWidget(heading: "PhotoType 1st URL", value: profile.photos![0].url),
                          getPhoto(profile.photos![0].url),
                        ],
                      ),
                    ),
                  );
                }),
      ),
    );
  }

  Widget getWidget({required String heading, dynamic? value, bool showIfNull: false}) {
    if (value != null || showIfNull) {
      return Container(
        margin: EdgeInsets.all(4.0),
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Text('$heading: $value'),
      );
    } else {
      return Container();
    }
  }

  getPhoto(String? url) {
    print(url);
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => Container(
        height: 100,
        width: 80,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: 100,
        width: 80,
        child: Center(
          child: Text(error),
        ),
      ),
      height: 100,
      width: 100,
      fit: BoxFit.fill,
    );
  }
}
