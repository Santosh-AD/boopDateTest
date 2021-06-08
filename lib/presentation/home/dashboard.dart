// ignore: import_of_legacy_library_into_null_safe
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_task/core/colors.dart';
import 'package:test_task/logic/bloc/list_profile/profile_bloc.dart';
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
    final size = MediaQuery.of(context).size;
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.appThemeColor,
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
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: (size.width / 2) / 305,
                    mainAxisSpacing: 8.0),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  GetAllProfile profile = data[index];
                  return Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          getPhoto(profile.photos![0].url),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    '${profile.name}',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),
                                  ),
                                ),
                                getWidget(value: profile.gender?.index == 1 ? 'Male' : 'Female'),
                                getWidget(value: getDob(profile.dob)),
                                Container(
                                  height: 50,
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    '${profile.bio}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                getWidget(value: profile.photos![0].type),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
      ),
    );
  }

  Widget getWidget({dynamic? value, bool showIfNull: false}) {
    if (value != null || showIfNull) {
      return Container(
        padding: EdgeInsets.all(4.0),
        child: Text(
          '$value',
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      );
    } else {
      return Container();
    }
  }

  getPhoto(String? url) {
    print(url);
    return Stack(
      children: [
        Opacity(
          opacity: 0.8,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 130,
            color: AppColor.appThemeColor,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
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
                  color: Colors.grey,
                ),
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }

  getDob(DateTime? dob) {
    String? str = DateFormat('dd-MMMM-y').format(dob!);
    print(str);
    return str;
  }
}
