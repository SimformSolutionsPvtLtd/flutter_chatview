import '../constants.dart';

bool isImageUrl(String message) =>
    (message.contains(jpg) || message.contains(png) || message.contains(jpeg));
