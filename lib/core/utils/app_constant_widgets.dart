
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:recipe/core/utils/color_constant.dart';


class AppConstWidget {


  static void showSnackBar(var scaffoldKey, String message, Color? color) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: ColorConstant.whiteColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: color ?? ColorConstant.primaryColor,
        elevation: 10,
        shape: const StadiumBorder(),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  static toastMsg({required String msg, required Color backgroundColor}) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Widget circularProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: ColorConstant.green),
    );
  }

  static overlayLoaderShow(BuildContext context) {
    Loader.show(context,
        overlayColor: Colors.black54,
        progressIndicator: CircularProgressIndicator(color: ColorConstant.green),
        themeData: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.grey)));
  }

  static overlayLoaderHide(BuildContext context) {
    Loader.hide();
  }

 

  // static void showImagePicker(
  //     BuildContext context, ImagePickProvider imagePickProvider) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             SizedBox(height: 16.0),
  //             _buildButton(context, 'Capture with Camera', Icons.camera_alt,
  //                 () {
  //               imagePickProvider.pickImageFromCamera();
  //               Navigator.pop(context);
  //             }),
  //             SizedBox(height: 16.0),
  //             _buildButton(context, 'Pick from Gallery', Icons.photo_library,
  //                 () {
  //               imagePickProvider.pickImage();
  //               Navigator.pop(context);
  //             }),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
