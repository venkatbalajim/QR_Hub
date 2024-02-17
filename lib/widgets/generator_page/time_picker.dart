import '../../utils/imports.dart';

class CustomTimePicker extends StatefulWidget {
  final String label;
  final void Function(String, TimeOfDay) onTimeChanged;

  const CustomTimePicker({super.key, required this.label, required this.onTimeChanged});

  @override
  // ignore: library_private_types_in_public_api
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late TimeOfDay selectedTime = TimeOfDay.now();
  late String formattedSelectedTime = '';

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Color.fromRGBO(13, 71, 161, 1),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            TextButton(
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData(
                        colorScheme: const ColorScheme.light(
                          primary: Color.fromRGBO(13, 71, 161, 1),
                          secondary: Color.fromRGBO(13, 71, 161, 1),
                          onSecondary: Colors.white,
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: SizedBox(
                              height: 550,
                              width: 700,
                              child: child,
                            ),
                          ),
                        ],
                      )
                    );
                  },
                ).then((value) {
                  if (value != null && value != selectedTime) {
                    setState(() {
                      selectedTime = value;
                      formattedSelectedTime = _formatTime(value);
                      widget.onTimeChanged(formattedSelectedTime, selectedTime); 
                    });
                  }
                });
              },
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  const BorderSide(color: Color.fromRGBO(13, 71, 161, 1), width: 2)
                ),
                backgroundColor: MaterialStateProperty.all(
                  Colors.white,
                ),
                foregroundColor: MaterialStateProperty.all(
                  Colors.blue[900]
                ),
                fixedSize: MaterialStateProperty.all(
                  const Size(120,40)
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Text("Select", style: TextStyle(fontWeight: FontWeight.w400),),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Text(
              formattedSelectedTime,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
