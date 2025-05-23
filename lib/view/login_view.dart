import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_snackbar.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_textformfield.dart';
import 'package:ampower_buzzit_mobile/config/styles.dart';
import 'package:ampower_buzzit_mobile/config/theme.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/util/constants/images.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/viewmodel/login_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//Login class contains ui of login form
class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final String? username = '';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController instanceUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>(debugLabel: 'login');
  bool _isDialogOpen = false; // Flag to prevent multiple dialogs

  Future login(formkey, LoginViewModel model, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var instanceUrl = locator.get<StorageService>().apiUrl;
      if (instanceUrl.isEmpty || instanceUrl == null) {
        await showDialogToEnterSiteUrl(model, context);
      } else {
        await model.login(instanceUrl, usernameController.text,
            locator.get<PasswordFieldViewModel>().passwordController.text);
      }
    }
  }

  Future getPrefs(LoginViewModel model, BuildContext context) async {
    model.setState(ViewState.idle);
    var uname = await model.getUsername();
    var url = await model.getInstanceUrl();
    if (uname.isNotEmpty) {
      usernameController.text = uname;
    }
    if (url.isNotEmpty) {
      instanceUrlController.text = url;
    } else {
      await showDialogToEnterSiteUrl(model, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      onModelReady: (model) async {
        model.getVersion();
        await getPrefs(model, context);

        // model.showNotification();
      },
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            if (_isDialogOpen) return false; // Prevent opening multiple dialogs
            _isDialogOpen = true;
            var exitApp = await Common.showExitConfirmationDialog(context);
            _isDialogOpen = false;
            return exitApp;
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color(0xFF006CB5), // Starting color
                        Color(0xFF002D4C) // ending color
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: displayWidth(context),
                        height: displayHeight(context) * 0.38,
                        child: const Center(child: Logo()),
                      ),
                      Stack(
                        children: [
                          Container(
                            height: displayHeight(context) -
                                (displayHeight(context) * 0.38),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Corners.xxlRadius,
                                ),
                                color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.paddingWidget(context)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: displayHeight(context) * 0.04,
                                  ),
                                  // const Logo(),
                                  Common.reusableTextWidget(
                                    'Ready to dive in?',
                                    28,
                                    context,
                                    color: Colors.black,
                                  ),
                                  verticalPadding(context,
                                      height:
                                          Sizes.smallPaddingWidget(context)),
                                  Common.reusableTextWidget(
                                      'Access your account with your login details.',
                                      14,
                                      context,
                                      color: Color(0xFF666666),
                                      fontWeight: FontWeight.w400),
                                  verticalPadding(context),
                                  verticalPadding(context,
                                      height:
                                          Sizes.smallPaddingWidget(context)),
                                  usernameTextField(context),
                                  verticalPadding(context),
                                  // passwordTextField(model, context),
                                  const PasswordField(),
                                  verticalPadding(context),
                                  loginButton(model, context),
                                  verticalPadding(context),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          await showDialogToEnterSiteUrl(
                                              model, context);
                                          // await locator
                                          //     .get<NavigationService>()
                                          //     .navigateTo(instanceUrlViewRoute);
                                        },
                                        child: Text(
                                          'Update your site URL!',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize:
                                                displayWidth(context) < 600
                                                    ? 16
                                                    : 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const PoweredByAmbibuzzLogo(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: defaultTargetPlatform ==
                                                TargetPlatform.iOS
                                            ? Sizes.paddingWidget(context)
                                            : 0),
                                    child: Text(
                                      'v${model.version}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget instanceUrlTextField(BuildContext context) {
    return CustomTextFormField(
      controller: instanceUrlController,
      decoration: Common.inputDecoration().copyWith(
        helperText: 'for eg : https://abc.com',
        hintText: 'Enter ERP URL',
        helperStyle: TextStyle(color: CustomTheme.iconColor),
      ),
      label: 'Enter ERP URL',
      labelStyle: Sizes.textAndLabelStyle(context),
      required: false,
      style: Sizes.textAndLabelStyle(context),
      validator: (val) =>
          val == '' || val == null ? 'Instance url should not be empty' : null,
    );
  }

  Future showDialogToEnterSiteUrl(
      LoginViewModel model, BuildContext context) async {
    var url = await model.getInstanceUrl();

    if (url.isNotEmpty) {
      instanceUrlController.text = url;
    }
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        insetPadding:
            EdgeInsets.symmetric(horizontal: Sizes.paddingWidget(context)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Sizes.paddingWidget(context),
          vertical: Sizes.paddingWidget(context),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Update your URL to get going      ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            SizedBox(width: Sizes.smallPaddingWidget(context)),
            GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const Icon(Icons.clear))
          ],
        ),
        content: SizedBox(height: 75, child: instanceUrlTextField(context)),
        actions: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: Sizes.buttonHeightWidget(context),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.secondary),
                    ),
                    onPressed: () async {
                      // check url is active
                      if (await model.isUrlActive(instanceUrlController.text)) {
                        locator.get<StorageService>().apiUrl =
                            instanceUrlController.text;
                        Navigator.of(context, rootNavigator: true).pop();
                      } else {
                        showSnackBar(
                            'The URL provided is invalid. Please check the URL and try again.',
                            context);
                      }
                    },
                    child: const Text(
                      'Confirm',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget verticalPadding(BuildContext context, {double? height}) {
    return SizedBox(height: height ?? Sizes.paddingWidget(context));
  }

  Widget loginButton(LoginViewModel model, BuildContext context) {
    return SizedBox(
      width: displayWidth(context),
      height: 50,
      child: TextButton(
        // key: const Key(TestCasesConstants.loginButton),
        child: Text(
          model.state == ViewState.busy ? 'Login...' : 'Login',
          style: TextStyle(
            fontSize: Sizes.fontSizeTextButtonWidget(context),
          ),
        ),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(const Color(0xFFFF731D))),
        onPressed: () => model.state == ViewState.busy
            ? null
            : login(_formKey, model, context),
      ),
    );
  }

  Widget usernameTextField(BuildContext context) {
    return CustomTextFormField(
      // key: const Key(TestCasesConstants.usernameField),
      controller: usernameController,
      decoration: Common.inputDecoration().copyWith(
          hintText: 'E-mail',
          prefixIcon: Icon(
            Icons.mail_outline,
            color: CustomTheme.iconColor,
          )),
      label: 'E-mail',
      labelStyle: Sizes.textAndLabelStyle(context),
      required: false,
      style: Sizes.textAndLabelStyle(context),
      validator: (val) =>
          val == '' || val == null ? 'Email should not be empty' : null,
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<PasswordFieldViewModel>(builder: (context, model, child) {
      return CustomTextFormField(
        // key: const Key(TestCasesConstants.passwordField),
        controller: model.passwordController,
        decoration: Common.inputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: CustomTheme.iconColor,
            ),
            suffixIcon: GestureDetector(
              onTap: () => model.showOrHidePassword(),
              child: Icon(
                model.hidePassword ? Icons.visibility : Icons.visibility_off,
                size: 24,
                color: Theme.of(context).primaryColor,
              ),
            )).copyWith(hintText: 'Password', isDense: false),
        label: 'Password',
        labelStyle: Sizes.textAndLabelStyle(context),
        obscureText: model.hidePassword,
        required: false,
        style: Sizes.textAndLabelStyle(context),
        textInputAction: TextInputAction.done,
        validator: (val) =>
            val == '' || val == null ? 'Password should not be empty' : null,
      );
    });
  }
}

class PasswordFieldViewModel extends BaseViewModel {
  final TextEditingController passwordController = TextEditingController();
  var hidePassword = true;

  // showNotification() {
  //   locator.get<PushNotificationService>().showNotification();
  // }

  void showOrHidePassword() {
    hidePassword = !hidePassword;
    notifyListeners();
  }
}

class PoweredByAmbibuzzLogo extends StatelessWidget {
  const PoweredByAmbibuzzLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Images.poweredByAmbibuzzLogo,
      width: 90,
      height: 65,
      fit: BoxFit.cover,
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 100,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: Corners.xlBorder,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.smallPaddingWidget(context)),
          child: Image.asset(
            Images.buzzItLogo,
            width: 166,
            height: 80,
          ),
        ),
      ),
    );
  }
}
