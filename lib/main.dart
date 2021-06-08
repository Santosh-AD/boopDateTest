import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/logic/bloc/list_profile/profile_bloc.dart';
import 'package:test_task/logic/network/graphql/graphql_client.dart';
import 'package:test_task/logic/network/profile_api.dart';
import 'package:test_task/logic/repositories/profile_repo.dart';
import 'package:test_task/presentation/home/dashboard.dart';
import 'package:test_task/presentation/route/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        ProfileRepo(ProfileApi(GraphQL())),
      ),
      child: MaterialApp(
        title: 'Boop Date Task',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: DashboardView.route,
      ),
    );
  }
}
