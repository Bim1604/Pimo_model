import 'package:pimo/models/styles.dart';

class StylesViewModel {
  Styles _styles;
  StylesViewModel({Styles styles}) : _styles = styles;

  String get name {
    return _styles.name;
  }
}
