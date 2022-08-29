import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app.locator.dart';

class CustomBaseViewModel extends BaseViewModel {
  final dialogService = locator<DialogService>();
  final navigationService = locator<NavigationService>();
  final bottomSheetService = locator<BottomSheetService>();
  final snackbarService = locator<SnackbarService>();
}
