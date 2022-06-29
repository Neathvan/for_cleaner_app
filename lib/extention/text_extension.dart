import 'package:flutter/material.dart';

extension TextStyleHelpers on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold, color: Colors.black, decoration: TextDecoration.none,);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle letterSpace(double value) => copyWith(letterSpacing: value);
}


/*
 * File: text_theme.dart
 * Project: extensions
 * -----
 * Created Date: Tuesday November 2nd 2021
 * Author: Sony Sum
 * -----
 * Copyright (c) 2021 ERROR-DEV All rights reserved.
 */


extension KContext on State {

  TextTheme get textTheme => Theme.of(context).textTheme;

}
extension KtextTheme on TextTheme {
  TextStyle get krDateItemTitleRed =>
      subtitle2!.copyWith(color: Colors.red, fontWeight: FontWeight.w500);

  TextStyle get krDateItemTitle =>
      subtitle2!.copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20);

  TextStyle get krDateItemTitle1 =>
      subtitle2!.copyWith(color: Colors.white, fontWeight: FontWeight.w400, );

  TextStyle get krTitleDetailBold =>
      subtitle1!.copyWith(fontSize: 18, fontWeight: FontWeight.w600);

  TextStyle get krTitle =>
      subtitle1!.copyWith(fontSize: 16);

  TextStyle get krTitleBold =>
      subtitle2!.copyWith(fontSize: 16, fontWeight: FontWeight.w600);

  TextStyle get krTitleItemBlack =>
      subtitle1!.copyWith(fontSize: 12);

  TextStyle get krSubTitleItemGray =>
      subtitle1!.copyWith(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w500);

  TextStyle get krSubTitleItemGray2 =>
      subtitle1!.copyWith(fontSize: 15);

  TextStyle get krSubTitleItemGray3 =>
      subtitle1!.copyWith(fontSize: 16, color: Colors.grey[600]);



  TextStyle get propertyPrice =>
      headline6!.copyWith(fontSize: 16, color: Colors.red);

  TextStyle get status =>
      headline6!.copyWith(fontSize: 16, color: Colors.red);
}