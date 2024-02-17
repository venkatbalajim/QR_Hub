import '../../utils/imports.dart';

class CustomDatePicker extends StatefulWidget {
  final String label;
  final void Function(String, DateTime) onDateChanged;

  const CustomDatePicker({super.key, required this.label, required this.onDateChanged});

  @override
  // ignore: library_private_types_in_public_api
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime selectedDate = DateTime.now();
  late String formattedSelectedDate = '';

  String _formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
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
                showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData(
                        colorScheme: const ColorScheme.light(
                          primary: Color.fromRGBO(13, 71, 161, 1),
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
                  if (value != null && value != selectedDate) {
                    setState(() {
                      selectedDate = value;
                      formattedSelectedDate = _formatDate(value);
                      widget.onDateChanged(formattedSelectedDate, selectedDate); 
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
                    Icons.calendar_month,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Text("Select", style: TextStyle(fontWeight: FontWeight.w400),),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Text(
              formattedSelectedDate,
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
