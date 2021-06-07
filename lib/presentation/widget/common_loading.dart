import 'package:flutter/material.dart';
//This is common loading view 
bool isShowLoading = false;
showLoading(BuildContext context, {dissmissable: false, text: 'Loading'}) {
  if (!isShowLoading) {
    //LoadingScreen is not shown
    isShowLoading = true;
    showDialog(
        barrierDismissible: dissmissable,
        context: context,
        useRootNavigator: false,
        builder: (context) {
          return Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Material(
                    child: Text(
                      text,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

hideLoading(BuildContext context) {
  if (isShowLoading) {
    isShowLoading = false;
    Navigator.of(context, rootNavigator: false).pop();
  }
}
