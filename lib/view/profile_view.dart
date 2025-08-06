import 'dart:io';
import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/service/navigation_service.dart';
import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_textformfield.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_toast.dart';
import 'package:ampower_buzzit_mobile/config/theme.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/route/routing_constants.dart';
import 'package:ampower_buzzit_mobile/service/camera_service.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/dio_helper.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/util/helpers.dart';
import 'package:ampower_buzzit_mobile/view/login_view.dart';
import 'package:ampower_buzzit_mobile/viewmodel/profile_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final _formKey = GlobalKey<FormState>(debugLabel: 'profile');
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      onModelReady: (model) async {
        await model.getUser();
        model.initData();
      },
      builder: (context, model, child) {
        return Scaffold(
            appBar: Common.commonAppBar(
                'Profile',
                [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.onSecondary),
                    ),
                    onPressed: () async {
                      await locator
                          .get<NavigationService>()
                          .navigateTo(errorLogListViewRoute);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.smallPaddingWidget(context)),
                      child: Text(
                        'Error Log',
                        style: Sizes.titleTextStyle(context)?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Sizes.paddingWidget(context)),
                ],
                context),
            body: model.state == ViewState.busy
                ? WidgetsFactoryList.circularProgressIndicator()
                : profileScreenUi(model, context));
      },
    );
  }

  Widget profileScreenUi(ProfileViewModel model, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.smallPaddingWidget(context),
        right: Sizes.smallPaddingWidget(context),
        top: Sizes.paddingWidget(context),
        bottom: Sizes.smallPaddingWidget(context),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            UserImage(model: model),
            SizedBox(height: Sizes.paddingWidget(context)),
            fullNameField(model, context),
            SizedBox(height: Sizes.paddingWidget(context)),
            emailAddressField(model, context),
            SizedBox(height: Sizes.paddingWidget(context)),
            mobileNoField(model, context),
            SizedBox(height: Sizes.paddingWidget(context)),
            connectedToUrlField(model, context),
            SizedBox(height: Sizes.paddingWidget(context)),
            SizedBox(
              width: displayWidth(context) < 600
                  ? displayWidth(context)
                  : displayWidth(context) * 0.5,
              height: Sizes.buttonHeightTargetitWidget(context),
              child: ElevatedButton(
                onPressed: () async {
                  await model.logout(context);
                },
                child: const Text('Logout'),
              ),
            ),
            const Spacer(),
            const PoweredByAmbibuzzLogo(),
            Padding(
              padding: EdgeInsets.only(
                  bottom: defaultTargetPlatform == TargetPlatform.iOS
                      ? Sizes.smallPaddingWidget(context)
                      : 0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'v${model.version}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailAddressField(ProfileViewModel model, BuildContext context) {
    return CustomTextFormField(
      key: const Key('email_address_field'),
      controller: model.emailController,
      decoration: Common.inputDecoration().copyWith(
          prefixIcon: Icon(
        Icons.mail_outline,
        color: CustomTheme.iconColor,
      )),
      label: 'Email',
      readOnly: true,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget mobileNoField(ProfileViewModel model, BuildContext context) {
    return CustomTextFormField(
      key: const Key('mobile_no_field'),
      controller: model.mobileNoController,
      decoration: Common.inputDecoration().copyWith(
          prefixIcon: Icon(
        Icons.phone_iphone,
        color: CustomTheme.iconColor,
      )),
      label: 'Mobile No',
      readOnly: true,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget fullNameField(ProfileViewModel model, BuildContext context) {
    return CustomTextFormField(
      key: const Key('full_name_field'),
      controller: model.fullNameController,
      decoration: Common.inputDecoration().copyWith(
          prefixIcon: Icon(
        Icons.account_circle_outlined,
        color: CustomTheme.iconColor,
      )),
      label: 'Full Name',
      style: Theme.of(context).textTheme.bodyMedium,
      readOnly: true,
    );
  }

  Widget connectedToUrlField(ProfileViewModel model, BuildContext context) {
    return CustomTextFormField(
      initialValue: locator.get<StorageService>().apiUrl,
      decoration: Common.inputDecoration().copyWith(
          prefixIcon: Icon(
        Icons.cast_connected,
        color: CustomTheme.iconColor,
      )),
      label: 'Connected To',
      style: Theme.of(context).textTheme.bodyMedium,
      readOnly: true,
    );
  }
}

class UserImage extends StatelessWidget {
  final ProfileViewModel model;
  const UserImage({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var imageDimension = displayWidth(context) < 600 ? 140.0 : 240.0;
    String finalFilePath;

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          useRootNavigator: false,
          builder: (ctx) => AlertDialog(
            title: const Text(
              'Pick Image',
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
              height: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        final picker = ImagePicker();
                        // Capture a photo.
                        var image =
                            await picker.pickImage(source: ImageSource.gallery);
                        model.setImage(image);
                        if (image != null) {
                          if (image.path.endsWith('jpg') ||
                              image.path.endsWith('jpeg')) {
                            // compress image
                            var finalImg = await compressFile(model.file, 50);
                            var img64 = getBase64FormateFile(finalImg!.path);

                            // upload image
                            await locator
                                .get<CameraService>()
                                .uploadImage(
                                    context,
                                    img64,
                                    File(finalImg.path),
                                    0,
                                    'User',
                                    model.user.email)
                                .then(
                                  (value) => {
                                    if (value['message']['file_url'] != null)
                                      {
                                        finalFilePath =
                                            value['message']['file_url']
                                      }
                                    else
                                      {finalFilePath = ''},
                                    if (finalFilePath != '')
                                      {
                                        // upload image to user doctype
                                        model
                                            .updateUserImage(finalFilePath)
                                            .then((value) async {
                                          // refetch update user
                                          await model.refetchUpdatedUser();
                                        })
                                      }
                                    else
                                      {
                                        flutterSimpleToast(
                                            Colors.white,
                                            Colors.black,
                                            'Couldnt Upload Image')
                                      }
                                  },
                                );
                          } else {
                            flutterSimpleToast(Colors.black, Colors.white,
                                'Can only compress image which is of jpg or jpeg format');
                          }
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.smallPaddingWidget(context)),
                        child: const Text('Gallery'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        final picker = ImagePicker();
                        // Pick an image.
                        final image =
                            await picker.pickImage(source: ImageSource.camera);
                        model.setImage(image);
                        if (image != null) {
                          if (image.path.endsWith('jpg') ||
                              image.path.endsWith('jpeg')) {
                            // compress image
                            var finalImg = await compressFile(model.file, 50);
                            var img64 = getBase64FormateFile(finalImg!.path);
                            // upload image
                            await locator
                                .get<CameraService>()
                                .uploadImage(
                                    context,
                                    img64,
                                    File(finalImg.path),
                                    0,
                                    'User',
                                    model.user.email)
                                .then(
                                  (value) => {
                                    if (value['message']['file_url'] != null)
                                      {
                                        finalFilePath =
                                            value['message']['file_url']
                                      }
                                    else
                                      {finalFilePath = ''},
                                    if (finalFilePath != '')
                                      {
                                        // upload image to user doctype
                                        model
                                            .updateUserImage(finalFilePath)
                                            .then((value) async {
                                          // refetch update user
                                          await model.refetchUpdatedUser();
                                        })
                                      }
                                    else
                                      {
                                        flutterSimpleToast(
                                            Colors.white,
                                            Colors.black,
                                            'Couldnt Upload Image')
                                      }
                                  },
                                );
                          } else {
                            flutterSimpleToast(Colors.black, Colors.white,
                                'Can only compress image which is of jpg or jpeg format');
                          }
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.smallPaddingWidget(context)),
                        child: const Text('Camera'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: model.user.userImage == null ||
              model.user.userImage?.isEmpty == true
          ? Container(
              width: imageDimension,
              height: imageDimension,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColorLight,
              ),
              child: Center(
                child: Text(
                  model.user.firstName != null
                      ? model.user.firstName![0] ?? ''
                      : '',
                  style: displayWidth(context) < 600
                      ? Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600)
                      : Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600),
                ),
              ),
            )
          : ClipOval(
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl:
                    '${locator.get<StorageService>().apiUrl}${model.user.userImage}',
                httpHeaders: {
                  HttpHeaders.cookieHeader: DioHelper.cookies ?? ''
                },
                width: imageDimension,
                height: imageDimension,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Icon(Icons.error),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
    );
  }
}

class LogoutTile extends StatelessWidget {
  final ProfileViewModel? model;
  const LogoutTile({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.padding),
      width: displayWidth(context),
      height: 70,
      child: TextButton(
        key: const Key('logout'),
        onPressed: () async {
          await model?.logout(context);
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Logout',
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.logout,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
