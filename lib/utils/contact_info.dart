import 'imports.dart';

class ContactHandler {

  final String? name;
  final String? title;
  final String? organization;
  final String? email;
  final String? address;
  final String? phone;
  final String? website;

  static const openCreateContact = MethodChannel('com.example.qr_hub/openCreateContact');

  ContactHandler({
    this.name,  this.title,  
    this.organization,  this.email,  
    this.address,  this.phone,  this.website
  });

  Future<void> openCreateContactMethod(
    String? name, String? title,
    String? organization, String? email,
    String? address, String? phone, String?  website
  ) async {
    try {
      await openCreateContact.invokeMethod('openCreateContact', {
        'name': name ?? '',
        'phone': phone ?? '',
        'title': title ?? '',
        'orgnization': organization ?? '',
        'email' : email ?? '',
        'address': address ?? '',
        'website': website ?? ''
      });
    } catch (e) {
      debugPrint('Error invoking openCreateContact: $e');
    }
  }

}
