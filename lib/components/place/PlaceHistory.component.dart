import 'package:flutter/material.dart';

class PlaceHistory extends StatefulWidget {
  const PlaceHistory({Key? key}) : super(key: key);

  @override
  State<PlaceHistory> createState() => PlaceHistoryState();
}

class PlaceHistoryState extends State<PlaceHistory> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      physics: NeverScrollableScrollPhysics(),
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: const Text('Step 1 title'),
          content: Container(alignment: Alignment.centerLeft, child: const Text('Content for Step 1')),
        ),
        Step(
          title: Text('Step 2 title'),
          content: Text('Content for Step 2'),
        )
      ],
    );
  }
}
