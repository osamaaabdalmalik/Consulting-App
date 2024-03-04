import 'dart:convert';
import 'dart:io';
import 'package:consultancy/core/constant/app_api_routes.dart';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_pages_routes.dart';
import 'package:consultancy/core/constant/app_shared_keys.dart';
import 'package:consultancy/core/constant/app_status_code_request.dart';
import 'package:consultancy/core/constant/app_status_views.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:consultancy/core/functions/helper_function.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'shared_preferences_service.dart';


class ApiService {
  SharedPreferencesService sharedService = Get.find();

  Future<Either<StatusView, Map>> post(String url, Map<String, dynamic> data, {Map<String, String> headers = const {}}) async {
    try {
      var response = await http.post(Uri.http(AppApiRoute.server, url), body: data, headers: headers);
      if (response.statusCode == StatusCodeRequest.ok ||
          response.statusCode == StatusCodeRequest.badRequest || response.statusCode == StatusCodeRequest.unauthorised) {
        return Right(jsonDecode(response.body));
      } else if (response.statusCode == StatusCodeRequest.invalidToken) {
        Get.snackbar(
          AppTranslationKeys.youAreOuterSession.tr,
          AppTranslationKeys.yorMustLoginToApp.tr,
          icon: const Icon(
            Icons.error,
            color: AppColors.white,
          ),
          backgroundColor: AppColors.red,
        );
        sharedService.sharedPreferences
            .setBool(AppSharedKeys.isAuthenticated, false);
        Get.offNamed(AppPagesRoutes.choseGarde);
      } else {
        printNote('post Server Problem ${response.statusCode}');
        Get.snackbar(
          AppTranslationKeys.serverProblem.tr,
          AppTranslationKeys.pleaseTryLater.tr,
          duration: const Duration(seconds: 10),
          icon: const Icon(
            Icons.error,
            color: AppColors.white,
          ),
          backgroundColor: AppColors.red,
        );
      }
    } catch (e) {
      printNote('post ApiService unKnownException: $e');
      Get.snackbar(
        AppTranslationKeys.unknownProblem.tr,
        AppTranslationKeys.pleaseTryLater.tr,
        icon: const Icon(
          Icons.error,
          color: AppColors.white,
        ),
        backgroundColor: AppColors.red,
      );
    }
    return const Left(StatusView.failure);
  }
  Future<Either<StatusView, Map>> get(String url, Map<String, String> headers) async {
    try {
      var response = await http.get(Uri.http(AppApiRoute.server, url), headers: headers);
      if (response.statusCode == StatusCodeRequest.ok || response.statusCode == StatusCodeRequest.badRequest) {
        return Right(jsonDecode(response.body));
      } else if (response.statusCode == StatusCodeRequest.invalidToken) {
        Get.snackbar(
          AppTranslationKeys.youAreOuterSession.tr,
          AppTranslationKeys.yorMustLoginToApp.tr,
          icon: const Icon(
            Icons.error,
            color: AppColors.white,
          ),
          backgroundColor: AppColors.red,
        );
        sharedService.sharedPreferences
            .setBool(AppSharedKeys.isAuthenticated, false);
        Get.offNamed(AppPagesRoutes.choseGarde);
      } else {
        printNote('post Server Problem ${response.statusCode}');
        Get.snackbar(
          AppTranslationKeys.serverProblem.tr,
          AppTranslationKeys.pleaseTryLater.tr,
          duration: const Duration(seconds: 10),
          icon: const Icon(
            Icons.error,
            color: AppColors.white,
          ),
          backgroundColor: AppColors.red,
        );
      }
    } catch (e) {
      printNote('post ApiService unKnownException: $e');
      Get.snackbar(
        AppTranslationKeys.unknownProblem.tr,
        AppTranslationKeys.pleaseTryLater.tr,
        icon: const Icon(
          Icons.error,
          color: AppColors.white,
        ),
        backgroundColor: AppColors.red,
      );
    }
    return const Left(StatusView.failure);
  }
  Future<Either<StatusView, Map>> postMultiPart(String url, Map<String, String> data, Map<String, String> headers, File file) async {
    try {
      var request = http.MultipartRequest("POST", Uri.http(AppApiRoute.server, url));
      request.fields.addAll(data);
      request.files.add(await http.MultipartFile.fromPath('photo', file.path, filename: file.path.split('/').last,),);
      request.headers.addAll(headers);
      var res=await request.send();
      var response = await http.Response.fromStream(res);
      if (response.statusCode == StatusCodeRequest.ok || response.statusCode == StatusCodeRequest.badRequest) {
        return Right(jsonDecode(response.body));
      } else if (response.statusCode == StatusCodeRequest.invalidToken) {
        Get.snackbar(
          AppTranslationKeys.youAreOuterSession.tr,
          AppTranslationKeys.yorMustLoginToApp.tr,
          icon: const Icon(
            Icons.error,
            color: AppColors.white,
          ),
          backgroundColor: AppColors.red,
        );
        sharedService.sharedPreferences
            .setBool(AppSharedKeys.isAuthenticated, false);
        Get.offNamed(AppPagesRoutes.choseGarde);
      } else {
        printNote('post Server Problem ${response.statusCode}');
        Get.snackbar(
          AppTranslationKeys.serverProblem.tr,
          AppTranslationKeys.pleaseTryLater.tr,
          duration: const Duration(seconds: 10),
          icon: const Icon(
            Icons.error,
            color: AppColors.white,
          ),
          backgroundColor: AppColors.red,
        );
      }
    } catch (e) {
      printNote('post ApiService unKnownException: $e');
      Get.snackbar(
        AppTranslationKeys.unknownProblem.tr,
        AppTranslationKeys.pleaseTryLater.tr,
        icon: const Icon(
          Icons.error,
          color: AppColors.white,
        ),
        backgroundColor: AppColors.red,
      );
    }
    return const Left(StatusView.failure);
  }

}