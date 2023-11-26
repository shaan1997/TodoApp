import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

abstract class BaseView<Controller> extends GetView<Controller> {

  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  Widget body(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: [
          annotatedRegion(context),
            const SizedBox(),
        ],
      ),
      onWillPop: () async {
        return onBackPressed();
      },
    );
  }

  Widget annotatedRegion(BuildContext context) {
    return AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: statusBarColor(),
          statusBarIconBrightness: statusBarIconBrightness(),
          statusBarBrightness: statusBarBrightness(),
        ),
        child: Material(
          color: Colors.transparent,
          child: pageScaffold(context),
        )
    );
  }

  Brightness statusBarBrightness() => Brightness.light;

  Brightness statusBarIconBrightness() =>
      statusBarBrightness() == Brightness.light ? Brightness.dark : Brightness.light;

  Widget pageScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackgroundColor(),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
      extendBody: extendBody(),
      key: globalKey,
      body: body(context),
      appBar: appBar(),
      bottomNavigationBar: bottomNavigationBar(),
      drawer: appDrawer(),
    );
  }

  Widget showErrorSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
    });

    return Container();
  }



  void showToast(String message) {}

  Color pageBackgroundColor() => Get.theme.backgroundColor;

  bool resizeToAvoidBottomInset() => true;

  bool extendBody() => false;

  Color statusBarColor() => Colors.transparent;

  Widget bottomNavigationBar() {
    return null;
  }
  AppBar appBar() {
    return null;
  }
  Widget appDrawer() {
    return null;
  }



  bool isLoading() {
    return false;
  }

  bool onBackPressed() {
    return true;
  }
}
