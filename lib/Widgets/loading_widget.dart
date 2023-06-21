import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        IgnorePointer(
          ignoring: true,
          child: Opacity(
            opacity: 0.5,
            child: ModalBarrier(
              color: Colors.black,
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Loading',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//Calling the loading widget
// showDialog(
//   context: context,
//   barrierDismissible: false,
//   builder: (context) => LoadingWidget(),
// );
//
// Timer(
//   Duration(seconds: 5),
//   () {
//     Navigator.of(context).pop();
//   },
// );
