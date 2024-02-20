import '../../utils/imports.dart';

// Widget to display Event details
class EventWidget extends StatelessWidget {
  final String? eventName; final String? organizer; final DateTime? start;
  final DateTime? end; final String? startDate; final String? startTime;
  final String? endDate; final String? endTime; final String? location;
  final String? summary; final BarcodeType type;

  const EventWidget({
    super.key,
    this.eventName, this.organizer, this.startDate, this.startTime,
    this.endDate, this.endTime, this.location, this.summary, 
    this.start, this.end, required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Uri generateCalendarEventUrl() {
      String formattedStartDate = DateFormat('yyyyMMddTHHmmss').format(start!);
      String formattedEndDate = DateFormat('yyyyMMddTHHmmss').format(end!);
      return Uri.parse('https://www.google.com/calendar/render?action=TEMPLATE&text=${Uri.encodeQueryComponent(eventName!)}'
          '&dates=${Uri.encodeQueryComponent('$formattedStartDate/$formattedEndDate')}&details=${Uri.encodeQueryComponent(summary!)}'
          '&location=${Uri.encodeQueryComponent(location!)}&allday=false&sf=true&output=xml');
    }

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
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Event name: $eventName", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 5),
                Text("Location: $location", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 5),
                Text("Organizer: $organizer", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 5),
                Text("Start date: $startDate", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 5),
                Text("Start time: $startTime", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 5),
                Text("End date: $endDate", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 5),
                Text("End time: $endTime", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 5),
                Text("Description: $summary", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
        if (eventName != null)
        CustomIconButton(
          onPressed: () async {
            final calendarEventUrl = generateCalendarEventUrl();
            if (await canLaunchUrl(calendarEventUrl)) {
              await launchUrl(calendarEventUrl);
            } 
          },
          buttonName: 'Add Event',
          iconName: Icons.event,
        )
      ],
    );
  }
}
