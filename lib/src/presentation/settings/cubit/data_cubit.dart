import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/main.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/settings/file_handler.dart';

part 'data_state.dart';

@injectable
class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial());

  void importDataFromJSON() {
    emit(DataLoading());
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    deviceInfo.androidInfo.then((androidInfo) {
      Permission.manageExternalStorage
          .request()
          .then((statusManageExternalStorage) {
        if (statusManageExternalStorage.isGranted &&
            androidInfo.version.sdkInt > 29) {
          _importFile();
        } else if (androidInfo.version.sdkInt < 30) {
          Permission.storage.request().isGranted.then((value) {
            if (value) {
              _importFile();
            } else {
              emit(const DataError('Permission error'));
            }
          });
        }
      });
    });
  }

  void _importFile() {
    final FileHandler fileHandler = getIt.get<FileHandler>();
    fileHandler.importFromFile().then((value) => emit(DataSuccess()));
  }
}
