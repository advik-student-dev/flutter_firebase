import 'package:flutter/material.dart';
import 'my_list_tile.dart';
import 'profile_page.dart'; // Import ProfilePage if not already imported

class MyDrawer extends StatefulWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;

  const MyDrawer({
    Key? key,
    required this.onProfileTap,
    required this.onSignOut,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _isOnline = false;
  bool _isAtWorkplace = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          // Header
          DrawerHeader(
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 64,
            ),
          ),

          // Home list title
          MyListTitle(
            icon: Icons.home,
            text: 'H O M E',
            onTap: () => Navigator.pop(context),
          ),

          // Profile list title
          MyListTitle(
            icon: Icons.person,
            text: 'P R O F I L E',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            ),
          ),

          // Spacer to push switches to the bottom
          Spacer(),

          // Switch for Online
          SwitchListTile(
            title: Text('Online', style: TextStyle(color: Colors.white),),
            value: _isOnline,
            onChanged: (value) {
              setState(() {
                _isOnline = value;
              });
            },
          ),

          // Switch for Workplace
          SwitchListTile(
            title: Text('Workplace', style: TextStyle(color: Colors.white),),
            value: _isAtWorkplace,
            onChanged: (value) {
              setState(() {
                _isAtWorkplace = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
