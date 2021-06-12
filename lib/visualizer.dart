import 'package:flutter/material.dart';
import 'status-handler.dart';
import 'visualizer-input.dart';
import 'dart:math';

class Visualizer extends StatelessWidget {
  final Random rng = new Random();
  final List<double> fakeEQ = [70.0,65.0,60.0,50.0,48.0,50.0,60.0,65.0,70.0];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: StreamBuilder(
        stream: CurrentStatus.status == TalkStatus.user_talking ? MicInput.noiseStream : null,
        builder: (context, snapshot) {
          if (snapshot.data == null) return Container();

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: fakeEQ.map((e) => Bar(snapshot.data.meanDecibel + (rng.nextDouble() * snapshot.data.meanDecibel / 50), e)).toList(),
          );
        },
      )
    );
  }
}

class Bar extends StatelessWidget {
  const Bar(this.live, this.sub, { Key key }) : super(key: key);
  final double live;
  final double sub;
  
  @override
  Widget build(BuildContext context) {
    
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      width: 15,
      height: (live - sub).clamp(0, 100).toDouble() * 1.5,
      child: Card(
        color: Colors.black,
      ),
    );
  }
}