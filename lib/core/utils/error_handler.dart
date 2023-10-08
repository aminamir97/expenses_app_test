import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';

import '../../app/api_info.dart';
import '../../app/routes.dart';
import '../../injections.dart';
import '../errors/failures.dart';
import '../extensions/context_ext.dart';
import 'navigation_service.dart';
import 'overlay_service.dart';

Future handleErrors(
  Future Function() callBack, {
  VoidCallback? onError,
  void Function(ApiError err)? onReceiveError,
}) async {
  String? errMsg;

  try {
    await callBack();
  } on ApiError catch (e) {
    errMsg = e.message;
    if (e.code == AppApi.sessionExpiredCode) {
      final databaseApi = Injections.instance.databaseApi;
      // databaseApi.deleteSession();

      NavigationService.instance.context.replaceAll(AppRoutes.first);
    }
    if (onReceiveError != null) onReceiveError(e);
  } on HttpException catch (e) {
    errMsg = e.message;
  } on SocketException catch (e) {
    errMsg = e.message;
  } on Exception catch (e) {
    errMsg = e.toString();
  } catch (e) {
    errMsg = e.toString();
  }
  if (errMsg != null) {
    OverlayService.instance.showError(errMsg);
    if (onError != null) onError();
  }
}

Type extractDataFrom<Type>(String json) {
  final info = jsonDecode(json);
  final success = info['success'] as bool;
  if (success) {
    final data = info['data'];
    log(data.toString());
    return data as Type;
  }
  throw ApiError.from(info['error']);
}
