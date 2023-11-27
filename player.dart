class Player {
  String name;
  int score;
  int highScore;

  Player({required this.name, required this.score, required this.highScore});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
      'highScore': highScore,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      name: map['name'],
      score: map['score'],
      highScore: map['highScore'],
    );
  }
}
