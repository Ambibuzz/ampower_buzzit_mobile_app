import 'dart:convert';
import 'dart:io';

import 'package:ampower_buzzit_mobile/common/widgets/custom_toast.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/util/dio_helper.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CameraService {
  late CameraController _cameraController;
  CameraController get cameraController => _cameraController;

  String? _imagePath;
  String? get imagePath => _imagePath;

  Future<void> initialize() async {
    var description = await _getCameraDescription();
    await _setupCameraController(description);
    // this._cameraRotation = rotationIntToImageRotation(
    //   description.sensorOrientation,
    // );
  }

  Future<CameraDescription> _getCameraDescription() async {
    var cameras = await availableCameras();
    return cameras.firstWhere((CameraDescription camera) =>
        camera.lensDirection == CameraLensDirection.front);
  }

  Future _setupCameraController(
    CameraDescription description,
  ) async {
    _cameraController = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _cameraController.initialize();
  }

  Future<XFile> takePicture() async {
    await _cameraController.stopImageStream();
    var file = await _cameraController.takePicture();
    _imagePath = file.path;
    return file;
  }

  Size getImageSize() {
    assert(_cameraController.value.previewSize != null, 'Preview size is null');
    return Size(
      _cameraController.value.previewSize!.height,
      _cameraController.value.previewSize!.width,
    );
  }

  Future dispose() async {
    await _cameraController.dispose();
  }

  Future uploadImage(BuildContext context, String imgData, File file,
      int isPrivate, String? doctype, String? docname) async {
    try {
      var fileName = file.path.split('/').last;
      /*
      var formData = FormData.fromMap({
        'filedata': MultipartFile.fromString(
          imgData,
        ),
        'cmd': 'uploadfile',
        'doctype': 'My Visits',
        'docname': docname,
        'filename': fileName,
        // 'filedata': imgData,
        'from_form': '1'
      });
      */

      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
        'docname': docname,
        'doctype': doctype,
        'is_private': isPrivate,
        'folder': 'Home/Attachments'
      });

      var response = await DioHelper.dio?.post(
        '/api/method/upload_file',
        data: formData,
      );
      if (response?.statusCode == 200) {
        var finalData = response?.data;
        return await finalData;
      } else {
        await flutterSimpleToast(Colors.white, Colors.black,
            'Couldnt Upload Image. Please try again');
      }
      // */
    } catch (e) {
      exception(e, '/api/method/upload_file', 'uploadImage');
    }
  }

  Future checkinUser(
      BuildContext context,
      String? empId,
      String? empName,
      String? customer,
      String? plannedDate,
      String finalFilePath,
      String type,
      double lat,
      double long) async {
    var finalLocation = '$lat,$long';
    var data = jsonEncode(<String, dynamic>{
      'data': {
        'employee': empId,
        'planned_date': plannedDate,
        'customer': customer,
        'face_detected': finalFilePath,
        'device_id': finalLocation,
        'log_type': type,
      }
    });
    var response = await DioHelper.dio?.post(
      '/api/method/ampower_targetit.ampower_targetit.doctype.my_visits.my_visits.checkin',
      data: data,
    );
    var a = {
      'employee': empId,
      'face_detected': finalFilePath,
      'device_id': finalLocation,
      'log_type': type,
      'face_detection_status': 1,
      'face_detection_comment': 'success',
    };
    if (response?.statusCode == 200) {
      return response?.data;
    } else {
      return false;
    }
  }
}
