import '../../utils/imports.dart';

// Widget to display Geo details
class GeoWidget extends StatelessWidget {
  final double? latitude;
  final double? longitude;
  final BarcodeType type;
  const GeoWidget({super.key, this.latitude, this.longitude, required this.type});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(13, 71, 161, 1),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Latitude: $latitude", style: const TextStyle(fontSize: 18,),),
                const SizedBox(height: 5,),
                Text("Longitude: $longitude", style: const TextStyle(fontSize: 18,),),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
        GeoIconButton(
          onPressed: () async {
          final mapUrl = Uri.parse(
              'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude'
            );
            if (await canLaunchUrl(mapUrl)) {
              await launchUrl(mapUrl);
            } 
          }
        )
      ]
    );
  }
}
