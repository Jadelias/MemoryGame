import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'scoreboard_page.dart'; // Assuming you have the ScoreboardPage class in a separate file
import 'player.dart';
import 'memory_match_game.dart';

class MainMenuPage extends StatefulWidget {
  final List<Player> players;

  MainMenuPage({required this.players});

  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Enter your name',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _startGame();
            },
            child: Text('Start Game'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _viewScoreboard();
            },
            child: Text('View Scoreboard'),
          ),
        ],
      ),
    );
  }

  void _startGame() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemoryMatchGame(
          playerName: _nameController.text,
          onGameComplete: (score) {
            // This code will be executed when the MemoryMatchGame screen is popped
            // You can add any logic you need here, such as updating the scoreboard.
            // For example:
            _updateScoreboard(_nameController.text, score);
          },
        ),
      ),
    );
  }

  void _viewScoreboard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScoreboardPage(players: widget.players),
      ),
    );
  }

  void _updateScoreboard(String playerName, int score) {
    setState(() {
      // Check if the player already exists in the scoreboard
      var existingPlayer = widget.players.firstWhereOrNull((player) => player.name == playerName);

      if (existingPlayer != null) {
        // Update the high score if the new score is higher
        if (score > existingPlayer.highScore) {
          existingPlayer.highScore = score;
        }
      } else {
        // Add a new player to the scoreboard
        widget.players.add(Player(name: playerName,score: score, highScore: score));
      }
    });
  }
}
