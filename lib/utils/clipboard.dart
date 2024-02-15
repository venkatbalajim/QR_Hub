import 'imports.dart';

String fetchData(Barcode data) {
  String copyText = '';

  Validation validation = Validation();

  switch (data.type) {
    case BarcodeType.text:
      copyText = data.rawValue ?? '';
      break;

    case BarcodeType.url:
      copyText = data.url?.url ?? '';
      break;

    case BarcodeType.wifi:
      String ssid = data.wifi?.ssid ?? '';
      String password = data.wifi?.password ?? '';
      String encryption = data.wifi?.encryptionType.name ?? '';
      copyText = 'Wi-fi Info:\nSSID: $ssid\nPassword: $password\nEncryption: $encryption';
      break;

    case BarcodeType.geo:
      double latitude = data.geoPoint?.latitude ?? 0.0;
      double longitude = data.geoPoint?.longitude ?? 0.0;
      copyText = 'Geo Info:\nLatitude: $latitude\nLongitude: $longitude';
      break;

    case BarcodeType.phone:
      copyText = data.phone?.number ?? '';
      break;

    case BarcodeType.calendarEvent:
      String summary = data.calendarEvent?.summary ?? '';
      String location = data.calendarEvent?.location ?? '';
      String organizer = data.calendarEvent?.organizer ?? '';
      String startDate = validation.formatDate(data.calendarEvent?.start ?? DateTime.now());
      String startTime = validation.formatTime(data.calendarEvent?.start ?? DateTime.now());
      String endDate = validation.formatDate(data.calendarEvent?.end ?? DateTime.now());
      String endTime = validation.formatTime(data.calendarEvent?.end ?? DateTime.now());
      String notes = data.calendarEvent?.description ?? '';
      copyText = 'Event Info:\nName: $summary\nLocation: $location\nOrganizer: $organizer\nStart Date: $startDate\nStart Time: $startTime\nEnd Date: $endDate\nEnd Time: $endTime\nDescription: $notes';
      break;

    case BarcodeType.contactInfo:
      String name = data.contactInfo?.name?.formattedName ?? '';
      String title = data.contactInfo?.title ?? '';
      String organization = data.contactInfo?.organization ?? '';
      List<Phone>? phones = data.contactInfo?.phones ?? [];
      List<Email>? emails = data.contactInfo?.emails ?? [];
      List<Address>? addresses = data.contactInfo?.addresses ?? [];
      dynamic websites = data.contactInfo?.urls ?? [];
      copyText = 'vCard Info:\nName: $name\nTitle: $title\nOrganization: $organization\nPhones: ${phones.map((phone) => phone.number).join(", ")}\nEmails: ${emails.map((email) => email.address).join(", ")}\nAddresses: ${addresses.map((address) => address.addressLines.join(", ")).join(", ")}\nWebsites: ${websites.map((website) => website.toString()).join(",")}';
      break;

    case BarcodeType.email:
      String email = data.email?.address ?? '';
      String subject = data.email?.subject ?? '';
      String body = data.email?.body ?? '';
      copyText = 'Email Info:\nEmail: $email\nSubject: $subject\nBody: $body';
      break;

    case BarcodeType.sms:
      String phoneNumber = data.sms?.phoneNumber ?? '';
      String message = data.sms?.message ?? '';
      copyText = 'SMS Info:\nPhone Number: $phoneNumber\nMessage: $message';
      break;

    default:
      copyText = data.rawValue ?? '';
  }

  return copyText;

}

void copyToClipboard(BuildContext context, Barcode value) {
  String data = fetchData(value);
  Clipboard.setData(ClipboardData(text: data));

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      behavior: SnackBarBehavior.floating,
      width: 200,
      duration: Duration(seconds: 2),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      content: Text(
        'Copied to Clipboard',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    ),
  );
}
