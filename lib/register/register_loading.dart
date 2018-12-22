import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          SpinKitRing(
            color: Colors.white,
            lineWidth: 3,
            size: 30,
          ),
          SizedBox(
            width: 30,
          ),
          Text(
            '加载中...',
            style: TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w100),
          )
        ],
      ),
    );
  }
}
