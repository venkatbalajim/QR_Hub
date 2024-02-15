import 'imports.dart';

void shareContent(Barcode value) async {
  final shareText = fetchData(value);
  await Share.share(shareText);
}
