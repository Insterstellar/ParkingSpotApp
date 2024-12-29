import 'package:flutter/cupertino.dart';
import 'package:parking/misc/mycolors/mycolors.dart';

class InitialiseMap extends StatelessWidget {
  const InitialiseMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text("Initialising map ....", style: TextStyle(color: MyColors.primary6),),
      ),
    );
  }
}
