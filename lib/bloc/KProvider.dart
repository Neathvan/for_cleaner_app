
import 'package:flutter/cupertino.dart';
import 'package:clean_app/ui/widget/component/dialog_helper.dart';

class KProvider extends ChangeNotifier  {

  showLoading(BuildContext context, String message ) {
    DialogHelper.showLoading(context, message);
  }

  hideLoading(BuildContext context) {
    DialogHelper.hideLoading(context);
  }

  void update() {
    notifyListeners();
  }
}