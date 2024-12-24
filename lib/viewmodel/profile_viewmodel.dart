import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/common/service/logout_api_service.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_toast.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/user.dart';
import 'package:ampower_buzzit_mobile/util/dio_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileViewModel extends BaseViewModel {
  User user = User();
  DateTime dateTime =
      DateFormat('yyyy-MM-dd hh:mm:ss').parse('1960-01-01 12:00:00');
  XFile? file;
  var fullNameController = TextEditingController();
  var mobileNoController = TextEditingController();
  var emailController = TextEditingController();

  String version = '';

  Future logout(BuildContext context) async {
    await locator.get<LogoutService>().logOut(context);
    await DioHelper().signOut();
  }

  Future getUser() async {
    setState(ViewState.busy);
    // var userData = locator.get<OfflineStorage>().getItem('user');
    user = locator.get<HomeViewModel>().user;
    notifyListeners();
    setState(ViewState.idle);
  }

  void initData() async {
    if (user.fullName?.isNotEmpty == true) {
      fullNameController.text = user.fullName ?? '';
    }
    if (user.mobileNo?.isNotEmpty == true) {
      mobileNoController.text = user.mobileNo ?? '';
    }
    if (user.email?.isNotEmpty == true) {
      emailController.text = user.email ?? '';
    }
    var packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    notifyListeners();
  }

  void setImage(XFile? file) {
    this.file = file;
    notifyListeners();
  }

  Future updateUserImage(String imagePath) async {
    final url = '/api/resource/User/${user.email}';
    var data = {
      'user_image': imagePath,
    };
    try {
      final response = await DioHelper.dio?.put(url, data: data);
      if (response?.statusCode == 200) {
        await flutterSimpleToast(Colors.black, const Color(0xFF67DE81),
            'Your changes has been saved successfully!');
      }
    } catch (e) {
      exception(e, url, 'updateUserImage');
    }
  }

  Future refetchUpdatedUser() async {
    // fetch user
    await locator.get<HomeViewModel>().getUser();
    // update user object
    await getUser();
  }
}
