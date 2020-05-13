import 'package:douban_movie_flutter/i10n/localization_intl.dart';
import 'package:douban_movie_flutter/model/view_state.dart';
import 'package:douban_movie_flutter/service/resource_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonErrorWidget extends StatelessWidget {
  final VoidCallback onPressed;
  String message;
  final ViewStateError error;

  CommonErrorWidget(
      {Key key, @required this.error, this.onPressed, this.message})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    if(message == null) {
      if(error.errorType == ViewStateErrorType.defaultError) {
        message = error.errorMessage ?? DouBanLocalizations.of(context).load_data_failed_tip;
      }else {
        message = error.errorMessage ?? DouBanLocalizations.of(context).network_poor_tip;
      }
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40),
      child: Align(
        alignment: Alignment(0.0, -0.3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              ImageHelper.wrapAssets('error.png'),
              width: 100,
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 40),
              child: Text(
                message,
                style: TextStyle(color: Colors.black38, fontSize: 16),
              ),
            ),
            OutlineButton(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  DouBanLocalizations.of(context).refresh,
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: onPressed,
                textColor: Theme.of(context).primaryColor,
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
          ],
        ),
      )
    );
  }
}
