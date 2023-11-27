import 'dart:async';
import 'package:flutter/material.dart';

class MemoryMatchGame extends StatefulWidget {
  final String playerName;
  final void Function(int) onGameComplete;

  MemoryMatchGame({required this.playerName, required this.onGameComplete});

  @override
  _MemoryMatchGameState createState() => _MemoryMatchGameState();
}

class _MemoryMatchGameState extends State<MemoryMatchGame> {
  List<int> data = [];
  List<bool> flipped = [];
  int previousIndex = -1;
  bool isChecking = false;
  int elapsedSeconds = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    initializeGame();
    startTimer();
  }

  void initializeGame() {
    const numberOfPairs = 8;
    List<int> pairs = List.generate(numberOfPairs, (index) => index + 1);
    data = [...pairs, ...pairs]..shuffle();
    flipped = List.filled(data.length, false);
    elapsedSeconds = 0;
  }

  void resetGame() {
    setState(() {
      initializeGame();
      previousIndex = -1;
      isChecking = false;
      elapsedSeconds = 0;
    });
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        elapsedSeconds = t.tick;
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void _onTileTap(int index) {
    if (isChecking || flipped[index]) {
      return;
    }

    setState(() {
      flipped[index] = true;

      if (previousIndex == -1) {
        previousIndex = index;
      } else {
        isChecking = true;
        Timer(Duration(seconds: 1), () {
          if (data[index] != data[previousIndex]) {
            flipped[index] = false;
            flipped[previousIndex] = false;
          }
          previousIndex = -1;
          isChecking = false;
          checkGameCompletion();
        });
      }
    });
  }

  void checkGameCompletion() {
    if (flipped.every((tile) => tile)) {
      stopTimer();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Congratulations, ${widget.playerName}!'),
            content: Text('You completed the game in $elapsedSeconds seconds.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onGameComplete(elapsedSeconds);
                  resetGame();
                },
                child: Text('Play Again'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onGameComplete(elapsedSeconds);
                  Navigator.pop(context); 
                },
                child: Text('Main Menu'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Match Game - Player: ${widget.playerName}'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onTileTap(index),
            child: Card(
              color: flipped[index] ? Colors.blue : Colors.grey,
              child: Center(
                child: flipped[index]
                    ? Text(
                  data[index].toString(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
                    : Text(''),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }
}
