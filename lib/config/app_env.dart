import 'dart:io';

class EnvironmentConfig {
  static String secretKeyIv({bool isGetKey = true}) =>
      isGetKey ? 'm4wW.@2.m4wW.@4.' : 'm4wW.3%.m4wW.1#.';
}
