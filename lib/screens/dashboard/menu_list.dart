import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  final IconData micon;
  final String mname;
  // final Function() onTap;
  final VoidCallback onTap;

  MenuList(
    {
      required this.micon, 
      required this.mname, 
      required this.onTap
    }
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        micon,
        size: 20,
        color: Colors.white,
      ),
      title: Text(mname, style: const TextStyle(fontSize: 20.0),),
      minLeadingWidth: 0,
      horizontalTitleGap: 10,
      visualDensity: const VisualDensity(vertical: 1),
      dense: true,
      onTap: onTap,
    );
  }
}
