// Temporarily not for media and document files. 

// ignore_for_file: non_constant_identifier_names, avoid_print

import '../utils/imports.dart';

Future<dynamic> ShowCapturedWidget(
  BuildContext context, Uint8List? capturedImage) {
  return showDialog(
    useSafeArea: false,
    context: context,
    builder: (context) => AlertDialog(
      content: Image.memory(capturedImage!),
    ),
  );
}

class GeneratorPage extends StatefulWidget {
  final String? qrCodeType;
  const GeneratorPage({super.key, this.qrCodeType});

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  final qrDataController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final bodyController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final websiteController = TextEditingController();
  final screenShotController = ScreenshotController();
  final List<String> wifiEncryptionOptions = ['WPA', 'WEP', 'Open'];
  String selectedEncryption = 'WPA'; 
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  dynamic qrData = '';
  bool showQrCode = false;
  bool isEditMode = true;

  void showEmptyDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Empty Data'),
          content: const Text('Kindly enter important data to generate QR Code.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(LinearBorder.none),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                fixedSize: MaterialStateProperty.all(const Size(50, 30)),
              ),
              child: Text(
                'OK', 
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary
                )
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String qrCodeName = widget.qrCodeType ?? '';
    // ignore: deprecated_member_use
    return WillPopScope(
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            if (!FocusScope.of(context).hasPrimaryFocus) {
              FocusScope.of(context).unfocus();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[900],
              foregroundColor: Colors.white,
              title: Text(
                'Generate $qrCodeName QR Code',
                style: const TextStyle(fontSize: 18),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    if (isEditMode)
                      inputFields(qrCodeName),
                    const SizedBox(height: 20,),
                    if (!isEditMode) 
                      CustomTextButton(
                        buttonName: 'Edit the Data', 
                        onPressed: toggleEditMode
                      ),
                    const SizedBox(height: 30,),
                    if (showQrCode) 
                      Screenshot(
                        controller: screenShotController,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          width: 250, height: 250,
                          child: GeneratedQRCode(qrData: qrData),
                        )
                      ),
                    const SizedBox(height: 30,),
                    if (showQrCode) 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomIconButton(onPressed: () async {
                            screenShotController
                              .capture(delay: const Duration(milliseconds: 10))
                              .then((capturedImage) async { 
                                ShowCapturedWidget(context,capturedImage!);
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.of(context).pop();
                                });
                              }
                            ).catchError((onError) {
                              print(onError);
                            });
                            await downloadQRCode(screenShotController, context);
                          },
                          buttonName: 'Download',
                          iconName: Icons.download),
                          const SizedBox(width: 100,),
                          CustomIconButton(onPressed: () async {
                            shareQRImage(screenShotController, context);
                          },
                          buttonName: 'Share',
                          iconName: Icons.share,)
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.settings.name == '/qrcodetype');
        return true;
      },
    );
  }

  void toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
      showQrCode = !showQrCode;
    });
  }

  String extractMobileNumber(String text) {
    RegExp regExp = RegExp(r'\b\d{10}\b');
    RegExpMatch? match = regExp.firstMatch(text);
    return match != null ? match.group(0) ?? '' : '';
  }

  String dateTimeFormat(DateTime dateTime) {
    return DateFormat('yyyyMMddTHHmmss').format(dateTime);
  }

  String generateICalendarData(DateTime start, DateTime end) {

    String convertedStart = dateTimeFormat(start);
    String convertedEnd = dateTimeFormat(end);

    String iCalendarData = '''
BEGIN:VEVENT
SUMMARY:${qrDataController.text}
LOCATION:${subjectController.text}
ORGANIZER:${bodyController.text}
DTSTART:$convertedStart
DTEND:$convertedEnd 
DESCRIPTION:${descriptionController.text}
END:VEVENT
''';
  return iCalendarData;
}

  Widget inputFields(String qrCodeName) {
    switch (qrCodeName) {

      // Input field for URL
      case 'URL':
        return Column(
          children: [
            CustomTextField(
              keyboardType: TextInputType.url,
              textController: qrDataController,
              hintText: 'Enter the URL',
              onDataChanged: (data) {
                setState(() {
                  qrData = data;
                });
              },
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: 200,
              child: CustomTextButton(
                buttonName: 'Generate QR Code',
                onPressed: () {
                  if (qrDataController.text.isEmpty) {
                    showEmptyDataDialog(context); 
                  } else {
                    setState(() {
                      qrData = qrDataController.text;
                      isEditMode = !isEditMode;
                      showQrCode = !showQrCode;
                    });
                  }
                },
              ),
            ),
          ],
        );

      // Input fields for Geo
      case 'Geo':
        String latitude = '';
        String longitude = '';
        return Column(
          children: [
            CustomTextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              textController: qrDataController,
              hintText: 'Enter the latitude',
              onDataChanged: (data) {
                setState(() {
                  qrData = data;
                });
              },
            ),
            const SizedBox(height: 15,),
            CustomTextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              textController: subjectController,
              hintText: 'Enter the longitude',
              onDataChanged: (data) {
                setState(() {
                  qrData = data;
                });
              },
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: 200,
              child: CustomTextButton(
                buttonName: 'Generate QR Code',
                onPressed: () {
                  if (qrDataController.text.isEmpty || subjectController.text.isEmpty) {
                    showEmptyDataDialog(context); 
                  } else {
                    setState(() {
                      latitude = qrDataController.text;
                      longitude = subjectController.text;
                      String geoData = 'geo:$latitude,$longitude';
                      qrData = geoData;
                      isEditMode = !isEditMode;
                      showQrCode = !showQrCode;
                    });
                  }
                },
              ),
            ),
          ],
        );

      // Input field for phone
      case 'Phone':
        return Column(
          children: [
            CustomTextField(
              keyboardType: TextInputType.phone,
              textController: qrDataController,
              hintText: 'Enter mobile number',
              onDataChanged: (data) {
                setState(() {
                  qrData = data;
                });
              },
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: 200,
              child: CustomTextButton(
                buttonName: 'Generate QR Code',
                onPressed: () {
                  if (qrDataController.text.isEmpty) {
                    showEmptyDataDialog(context); 
                  } else {
                    setState(() {
                      String mobilePhone = extractMobileNumber(qrDataController.text);
                      qrData = 'tel:$mobilePhone';
                      isEditMode = !isEditMode;
                      showQrCode = !showQrCode;
                    });
                  }
                },
              ),
            ),
          ],
        );

      // Input fields for Wifi
      case 'Wifi':
        return Column(
          children: [
            CustomTextField(
              keyboardType: TextInputType.text,
              textController: qrDataController,
              hintText: 'Enter the SSID/Name',
              onDataChanged: (data) {
                setState(() {
                  qrData = data;
                });
              },
            ),
            const SizedBox(height: 15,),
            CustomTextField(
              keyboardType: TextInputType.visiblePassword,
              textController: subjectController,
              hintText: 'Enter the password',
              onDataChanged: (data) {
                setState(() {
                  qrData = data;
                });
              },
            ),
            const SizedBox(height: 15,),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Wi-Fi Encryption',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700]
                    ),
                  ),
                  const SizedBox(height: 5),
                  DropdownButton<String>(
                    value: selectedEncryption,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        selectedEncryption = newValue;
                      }
                    },
                    items: wifiEncryptionOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: 200,
              child: CustomTextButton(
                buttonName: 'Generate QR Code',
                onPressed: () {
                  if (qrDataController.text.isEmpty || subjectController.text.isEmpty) {
                    showEmptyDataDialog(context); 
                  } else {
                    setState(() {
                      String ssid = qrDataController.text;
                      String password = subjectController.text;
                      String encryptType = selectedEncryption;
                      qrData = 'WIFI:T:$encryptType;S:$ssid;P:$password';
                      isEditMode = !isEditMode;
                      showQrCode = !showQrCode;
                    });
                  }
                },
              ),
            ),
          ],
        );

      // Input fields for event 
      case 'Event':
        return Column(
          children: [
            CustomTextField(
              keyboardType: TextInputType.text,
              textController: qrDataController,
              hintText: 'Enter the event name',
              onDataChanged: (data) {
                setState(() {
                  qrData = data;
                });
              },
            ),
            const SizedBox(height: 15,),
            CustomTextField(
              keyboardType: TextInputType.text,
              textController: subjectController,
              hintText: 'Enter the location',
              onDataChanged: (data) {
                setState(() {
                  qrData = data;
                });
              },
            ),
            const SizedBox(height: 15,),
            CustomTextField(
              keyboardType: TextInputType.text,
              textController: bodyController,
              hintText: 'Enter the organizer',
              onDataChanged: (data) {
                setState(() {
                  qrData = data;
                });
              },
            ),
            const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: CustomDatePicker(
                label: 'Start Date', 
                onDateChanged: (value, check) {
                  setState(() {
                    start = check;
                  });
                },
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: CustomTimePicker(
                label: 'Start Time', 
                onTimeChanged: (value, check) {
                  int hour = check.hour;
                  int minute = check.minute;
                  DateTime newStart = DateTime(
                    start.year, start.month, start.day, hour, minute
                  );
                  setState(() {
                    start = newStart;
                  });
                }
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: CustomDatePicker(
                label: 'End Date', 
                onDateChanged: (value, check) {
                  setState(() {
                    end = check;
                  });
                },
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: CustomTimePicker(
                label: 'End Time', 
                onTimeChanged: (value, check) {
                  DateTime newEnd = DateTime(
                    end.year, end.month, end.day, check.hour, check.minute
                  );
                  setState(() {
                    end = newEnd;
                  });
                }
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.only(
                left: 10
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5)
              ),
              height: 300,
              child: TextField(
                keyboardType: TextInputType.multiline,
                cursorColor: Theme.of(context).colorScheme.primary,
                controller: descriptionController,
                onChanged: (data) {
                  
                },
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter the description',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400
                  )
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: 200,
              child: CustomTextButton(
                buttonName: 'Generate QR Code',
                onPressed: () {
                  if (qrDataController.text.isEmpty || subjectController.text.isEmpty) {
                    showEmptyDataDialog(context); 
                  } else {
                    setState(() {
                      String calData = generateICalendarData(start, end);
                      qrData = calData;
                      isEditMode = !isEditMode;
                      showQrCode = !showQrCode;
                    });
                  }
                },
              ),
            ),
          ],
        );

      // Input fields for vCard
      case 'vCard':
        return Column(
          children: [
            CustomTextField(
              keyboardType: TextInputType.name,
              textController: qrDataController,
              onDataChanged: (data) {
                setState(() {
                  qrDataController.text = data;
                });
              },
              hintText: 'Enter the name',
            ),
            const SizedBox(height: 15,),
            CustomTextField(
              keyboardType: TextInputType.text,
              textController: subjectController,
              onDataChanged: (data) {
                setState(() {
                  subjectController.text = data;
                });
              },
              hintText: 'Enter the title',
            ),
            const SizedBox(height: 15,),
            CustomTextField(
              keyboardType: TextInputType.text,
              textController: bodyController,
              onDataChanged: (data) {
                setState(() {
                  bodyController.text = data;
                });
              },
              hintText: 'Enter the organization',
            ),
            const SizedBox(height: 15,),
            CustomTextField(
              keyboardType: TextInputType.phone,
              textController: descriptionController,
              onDataChanged: (data) {
                setState(() {
                  descriptionController.text = data;
                });
              },
              hintText: 'Enter the mobile number',
            ),
            const SizedBox(height: 15,),
            CustomTextField(
              keyboardType: TextInputType.emailAddress,
              textController: emailController,
              onDataChanged: (data) {
                setState(() {
                  emailController.text = data;
                });
              },
              hintText: 'Enter the email',
            ),
            const SizedBox(height: 15,),
            CustomTextField(
              keyboardType: TextInputType.url,
              textController: websiteController,
              onDataChanged: (data) {
                setState(() {
                  websiteController.text = data;
                });
              },
              hintText: 'Enter the website',
            ),
            const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.only(
                left: 10
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5)
              ),
              height: 300,
              child: TextField(
                keyboardType: TextInputType.streetAddress,
                cursorColor: Theme.of(context).colorScheme.primary,
                controller: addressController,
                onChanged: (data) {
                  addressController.text = data;
                },
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter the address',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400
                  )
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: 200,
              child: CustomTextButton(
                buttonName: 'Generate QR Code',
                onPressed: () {
                  if (
                    qrDataController.text.isEmpty ||
                    subjectController.text.isEmpty ||
                    descriptionController.text.isEmpty ||
                    bodyController.text.isEmpty
                  ) {
                    showEmptyDataDialog(context); 
                  } else {
                    setState(() {
                      String vCardData = '''
BEGIN:VCARD
VERSION:3.0
FN:${qrDataController.text}
ORG:${bodyController.text}
TITLE:${subjectController.text}
TEL;TYPE=CELL:${descriptionController.text}
EMAIL:${emailController.text}
URL:${websiteController.text}
ADR:${addressController.text}
END:VCARD
''';
                      qrData = vCardData;
                      isEditMode = !isEditMode;
                      showQrCode = !showQrCode;
                    });
                  }
                },
              ),
            ),
          ],
        );

      // Input fields for email
      case 'Email':
        String email = '';
        String subject = '';
        String body = '';
        return Column(
          children: [
            CustomTextField(
              keyboardType: TextInputType.emailAddress,
              textController: emailController,
              onDataChanged: (data) {
                setState(() {
                  email = data;
                });
              },
              hintText: 'Enter the email',
            ),
            const SizedBox(height: 15,),
            CustomTextField(
              keyboardType: TextInputType.text,
              textController: subjectController,
              onDataChanged: (data) {
                setState(() {
                  subject = data;
                });
              },
              hintText: 'Enter the subject',
            ),
            const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.only(
                left: 10
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5)
              ),
              height: 300,
              child: TextField(
                keyboardType: TextInputType.multiline,
                cursorColor: Theme.of(context).colorScheme.primary,
                controller: bodyController,
                onChanged: (data) {
                  setState(() {
                    body = data;
                  });
                },
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter the body',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400
                  )
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: 200,
              child: CustomTextButton(
                buttonName: 'Generate QR Code',
                onPressed: () {
                  if (emailController.text.isEmpty) {
                    showEmptyDataDialog(context); 
                  } else {
                    setState(() {
                      email = emailController.text;
                      subject = subjectController.text;
                      body = bodyController.text;
                      String mailtoData = 'mailto:$email?subject=$subject&body=$body';
                      qrData = mailtoData;
                      isEditMode = !isEditMode;
                      showQrCode = !showQrCode;
                    });
                  }
                },
              ),
            ),
          ],
        );
      
      // Input fields for SMS
      case 'SMS':
        String smsbody = '';
        return Column(
          children: [
            CustomTextField(
              keyboardType: TextInputType.phone,
              textController: qrDataController,
              hintText: 'Enter mobile number',
              onDataChanged: (data) {
                setState(() {
                  qrData = qrDataController.text;
                });
              },
            ),
            const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.only(
                left: 10
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5)
              ),
              height: 300,
              child: TextField(
                keyboardType: TextInputType.multiline,
                cursorColor: Theme.of(context).colorScheme.primary,
                controller: bodyController,
                onChanged: (data) {
                  setState(() {
                    smsbody = data;
                  });
                },
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter the body',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400
                  )
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: 200,
              child: CustomTextButton(
                buttonName: 'Generate QR Code',
                onPressed: () {
                  if (qrDataController.text.isEmpty) {
                    showEmptyDataDialog(context);
                  } else {
                    setState(() {
                      String number = extractMobileNumber(qrDataController.text);
                      smsbody = bodyController.text;
                      String smsData = 'SMSTO:$number:$smsbody';
                      qrData = smsData;
                      isEditMode = !isEditMode;
                      showQrCode = !showQrCode;
                    });
                  }
                },
              ),
            ),
          ],
        );

      // Input field for text
      default:
        return Column(
          children: [
            CustomTextField(
              keyboardType: TextInputType.text,
              textController: qrDataController,
              hintText: 'Enter the text',
              onDataChanged: (data) {
                setState(() {
                  qrData = qrDataController.text;
                });
              },
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: 200,
              child: CustomTextButton(
                buttonName: 'Generate QR Code',
                onPressed: () {
                  if (qrDataController.text.isEmpty) {
                    showEmptyDataDialog(context);
                  } else {
                    setState(() {
                      qrData = qrDataController.text;
                      isEditMode = !isEditMode;
                      showQrCode = !showQrCode;
                    });
                  }
                },
              ),
            ),
          ],
        );

    }
  }
}
