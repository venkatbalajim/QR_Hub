import 'imports.dart';

class ResultContainer extends StatelessWidget {

  final Barcode data;
  const ResultContainer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    
    Validation validation = Validation();
    String dataType = validation.getDataType(data.type);

    switch (dataType) {

      // Text data 
      case "Text":
        String? textValue = data.rawValue;
        return TextWidget(type: data.type, text: textValue,);

      // URL data 
      case 'URL':
        dynamic url = data.url?.url;
        return URLWidget(link: url, type: data.type);

      // Wi-fi data
      case 'Wi-fi':
        String? password = data.wifi?.password;
        String? name = data.wifi?.ssid;
        String? encryption = data.wifi?.encryptionType.name;
        return WifiWidget(
          name: name ?? '', password: password, 
          encryption: encryption, type: data.type
        );

      // Geo data
      case 'Geo':
        double? latitude = data.geoPoint?.latitude;
        double? longitude = data.geoPoint?.longitude;
        return GeoWidget(latitude: latitude, longitude: longitude, type: data.type);

      // Phone data
      case "Phone":
        String? phoneNo = data.phone?.number;
        return PhoneWidget(link: phoneNo, type: data.type);

      // Calendar Event data
      case 'Event':
        String? summary = data.calendarEvent?.description;
        String? location = data.calendarEvent?.location;
        String? eventName = data.calendarEvent?.summary;
        DateTime? start = data.calendarEvent?.start;
        DateTime? end = data.calendarEvent?.end;
        String? organizer = data.calendarEvent?.organizer;
        String? startDate = validation.formatDate(start!);
        String? endDate = validation.formatDate(end!);
        String? startTime = validation.formatTime(start);
        String? endTime = validation.formatTime(end);
        return EventWidget(
          eventName: eventName, location: location, summary: summary,
          startDate: startDate, endDate: endDate, startTime: startTime,
          endTime: endTime, organizer: organizer, start: start, end: end,
          type: data.type,
        );

      // vCard data
      case 'vCard':
        String? name = data.contactInfo?.name?.formattedName;
        String? title = data.contactInfo?.title;
        List<Phone>? phones = data.contactInfo?.phones;
        List<Email>? emails = data.contactInfo?.emails;
        List<Address>? addresses = data.contactInfo?.addresses;
        String? organization = data.contactInfo?.organization;
        dynamic websites = data.contactInfo?.urls;
        return VCardWidget(
          name: name, title: title, organization: organization,
          phones: phones, emails: emails, addresses: addresses,
          urls: websites, type: data.type,
        );

      case 'Email':
        String? email = data.email?.address;
        String? type = data.email?.type.name;
        String? subject = data.email?.subject;
        String? body = data.email?.body;
        return EmailWidget(
          email: email,
          subject: subject,
          body: body,
          emailType: type,
          type: data.type,
        );
      
      case 'SMS':
        String?  phoneNumber = data.sms?.phoneNumber;
        String?  message = data.sms?.message;
        return SMSWidget(
          phoneNumber : phoneNumber ,
          message: message,
          type: data.type,
        );

      // Default condition
      default: 
        dynamic rawData = data.rawValue;
        return Text("data: $rawData");

    }
  }
}
