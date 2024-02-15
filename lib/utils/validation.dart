import '../utils/imports.dart';

class Validation {
  String formatDate(DateTime dateTime) {
    return DateFormat('MMM dd yyyy').format(dateTime);
  }

  String formatTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime).toString();
  }

  String getDataType(BarcodeType valueType) {
    switch (valueType) {
      case BarcodeType.text:
        return 'Text';
      case BarcodeType.url:
        return 'URL';
      case BarcodeType.geo:
        return 'Geo';
      case BarcodeType.phone:
        return 'Phone';
      case BarcodeType.wifi:
        return 'Wi-fi';
      case BarcodeType.calendarEvent:
        return 'Event';
      case BarcodeType.contactInfo:
        return 'vCard';
      case BarcodeType.email:
        return 'Email';
      case BarcodeType.sms:
        return 'SMS';
      case BarcodeType.unknown:
        return 'Unknown';
      default:
        return 'Unknown';
    }
  }
}
