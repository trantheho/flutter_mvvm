import '../presentation/widgets/dialog.dart';
import 'manager/loading_manager.dart';
import 'manager/toast_manager.dart';
import 'utils/app_helper.dart';

class AppController {
  final LoadingManager _loading;
  final DialogController _dialog;
  final ToastManager _toast;
  final AppHelper _helper;

  AppController()
      : _dialog = DialogController(),
        _loading = LoadingManager(),
        _toast = const ToastManager(),
        _helper = AppHelper();

  DialogController get dialog => _dialog;

  ToastManager get toast => _toast;

  LoadingManager get loading => _loading;

  AppHelper get helper => _helper;
}

final appController = AppController();
