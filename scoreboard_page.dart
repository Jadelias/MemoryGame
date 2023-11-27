import 'package:flutter/material.dart';
import 'player.dart';

class ScoreboardPage extends StatelessWidget {
  final List<Player> players;

  ScoreboardPage({required this.players});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scoreboard'),
      ),
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(players[index].name),
            subtitle: Text('High Score: ${players[index].highScore} seconds'),
          );
        },
      ),
    );
  }
}
