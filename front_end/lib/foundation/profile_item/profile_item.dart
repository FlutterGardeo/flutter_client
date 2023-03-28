import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end/foundation/sp_icon/sp_icon.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    required this.title,
    this.subtitle,
    required this.assetName,
    required this.isLast,
    Key? key,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final String assetName;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 68,
          child: ListTile(
            leading: const SPIcon(
              assetname: assetName,
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1!,
            ),
            subtitle: subtitle != null
                ? Text(
              subtitle!,
              style: Theme.of(context).textTheme.caption!,
            )
                : Container(),
            trailing: InkWell(
              onTap: () {},
              child: const Icon(
                CupertinoIcons.chevron_forward,
                size: 18,
              ),
            ),
          ),
        ),
        if (!isLast) const Divider(height: 1, thickness: 1),
      ],
    );
  }
}
