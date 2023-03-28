import 'package:flutter/material.dart';
import 'package:flutter_client/models/option.dart';
import 'package:flutter_client/widgets/option_tile.dart';

// Color for the options in the dashboard
const Color kOptionColor = Color(0xffffcc80);

// Widget to display the dashboard for the admin
class Dashboard extends StatelessWidget {
  final List<Option> optionList;

  const Dashboard({Key? key, required this.optionList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Flexible(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
            ),
            itemCount: optionList.length,
            itemBuilder: (context, index) {
              final data = optionList[index];
              return InkWell(
                onTap: data.action,
                child: OptionTile(
                  option: data,
                  color: kOptionColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
