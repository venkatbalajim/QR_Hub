import '../../utils/imports.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isNightModeEnabled = false;

  @override
  void initState() {
    super.initState();
    isNightModeEnabled = Provider.of<ThemeProvider>(context, listen: false).isNightModeEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Options', style: TextStyle(fontSize: 25)),
                  CloseIconButton(),
                ],
              ),
            );
          } else if (index == 1) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              titleAlignment: ListTileTitleAlignment.center,
              leading: Text(
                'Night Mode: ',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              trailing: Transform.scale(
                scale: 0.7,
                child: Switch(
                  activeColor: Colors.amber[900],
                  value: isNightModeEnabled,
                  onChanged: (value) async {
                    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                    setState(() {
                      isNightModeEnabled = !isNightModeEnabled;
                    });
                  },
                ),
              ),
            );
          } else {
            return ListTile(
              title: Text('Additional Option ${index - 2}'),
            );
          }
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 0.0,
            color: Colors.transparent,
          );
        },
        itemCount: 2, // Increment the count when adding new options.
      )
    );
  }
}

class CloseIconButton extends StatelessWidget {
  const CloseIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
