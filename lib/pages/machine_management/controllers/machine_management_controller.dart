import 'dart:developer';
import 'dart:io';

import 'package:estacao_pilhas/services/usuario_service.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:system_settings/system_settings.dart';

import '../../../models/maquina.dart';
import '../../../services/maquina_service.dart';

class MachineManagementController {
  Future editMachine(int id, Map changes) async {
    try {
      Maquina maquina = await MaquinaService().editMaquina(id, changes);
      return maquina;
    } catch (error) {
      return error.toString();
    }
  }

  Future getMaquinaInfo(int id) async {
    try {
      Maquina response = await MaquinaService().getMaquinaInfo(id);
      return response;
    } catch (error) {
      // return error.toString();
      return false;
    }
  }

  Future emptyMachine(Map id) async {
    try {
      await MaquinaService().emptyMaquina(id);
      return true;
    } catch (error) {
      // return error.toString();
      log(error.toString());
      return false;
    }
  }

  Future registerNotification(String registrationId, String type) async {
    try {
      await UsuarioService().registerNotification(registrationId, type);
      return true;
    } catch (error) {
      return error.toString();
    }
  }

  Future getNotificationStatus() async {
    PermissionStatus permissionStatus =
        await NotificationPermissions.getNotificationPermissionStatus();

    if (permissionStatus == PermissionStatus.granted) return true;

    return false;
  }

  Future<bool> setNotification(bool isNotificationEnabled) async {
    SystemSettings.appNotifications();

    sleep(const Duration(seconds: 5));

    PermissionStatus permissionStatus =
        await NotificationPermissions.getNotificationPermissionStatus();

    if (permissionStatus == PermissionStatus.granted) return true;
    return false;
  }
}
