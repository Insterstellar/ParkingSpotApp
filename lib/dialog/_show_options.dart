import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking/misc/mycolors/mycolors.dart';

class ShowPopUp {



  Future showOptions(BuildContext context, VoidCallback openGallery, VoidCallback openCamera ) async {
    showCupertinoModalPopup(
      context: context,

      builder: (context) => CupertinoActionSheet(
        actions: [
          Container(
            child: CupertinoActionSheetAction(
              child: Text('Photo Gallery',style: TextStyle(color: MyColors.primary1)),
              onPressed: openGallery,
            ),
          ),
          Container(
           // color: MyColors.primary1,
            child: CupertinoActionSheetAction(
              child: Text('Camera', style: TextStyle(color: MyColors.primary1),),
              onPressed:  openCamera,
            ),
          ),
        ],
      ),
    );
  }
}