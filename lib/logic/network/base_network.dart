import 'package:flutter/foundation.dart';

class BaseNetwork {
  static const String _debugUrl = "http://boopdating.com/graphql"; //This Url is for Testing
  static const String _releaseUrl = "http://boopdating.com/graphql"; //This Url is for production
  static const String URL = kDebugMode ? _debugUrl : _releaseUrl;
}
