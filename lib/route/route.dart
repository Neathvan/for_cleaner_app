// import 'package:flutter/material.dart';
//
// class RouteGenerator {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     final args = settings.arguments;
//
//     switch (settings.name) {
//       case '/':
//         String variable = args as String;
//         return _buildPageRoute(const NewsFeedPage(), settings);
//
//       case '/newsfeed':
//         return _buildPageRoute(const NewsFeedPage(), settings);
//
//       case '/logout':
//         return _buildPageRoute(const LoginPage(), settings);
//
//       case '/reporter/detail':
//         return _buildPageRoute(ReportDetailPage(args as Post), settings);
//
//       default:
//         // var pageRoute = AccountRoute.generateRoute(settings);
//         // pageRoute ??= BookRoute.generateRoute(settings);
//         // pageRoute ??= BookReportRoute.generateRoute(settings);
//         // pageRoute ??= AccountRoute.generateRoute(settings);
//         return pageRoute ?? _buildPageRoute(const LoginPage(), settings);
//     }
//   }
//
//   static _buildPageRoute(Widget page, RouteSettings? settings) {
//     return MaterialPageRoute(builder: (context) => page, settings: settings);
//   }
// }import 'package:flutter/material.dart';
//
// class RouteGenerator {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     final args = settings.arguments;
//
//     switch (settings.name) {
//       case '/':
//         String variable = args as String;
//         return _buildPageRoute(const NewsFeedPage(), settings);
//
//       case '/newsfeed':
//         return _buildPageRoute(const NewsFeedPage(), settings);
//
//       case '/logout':
//         return _buildPageRoute(const LoginPage(), settings);
//
//       case '/reporter/detail':
//         return _buildPageRoute(ReportDetailPage(args as Post), settings);
//
//       default:
//         // var pageRoute = AccountRoute.generateRoute(settings);
//         // pageRoute ??= BookRoute.generateRoute(settings);
//         // pageRoute ??= BookReportRoute.generateRoute(settings);
//         // pageRoute ??= AccountRoute.generateRoute(settings);
//         return pageRoute ?? _buildPageRoute(const LoginPage(), settings);
//     }
//   }
//
//   static _buildPageRoute(Widget page, RouteSettings? settings) {
//     return MaterialPageRoute(builder: (context) => page, settings: settings);
//   }
// }