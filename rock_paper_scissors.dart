import 'dart:io';

/// List of valid moves.
const List<String> validMoves = ['rock', 'paper', 'scissors'];

/// Gets a player's name.
String getPlayerName(String playerNumber) {
  stdout.write('Enter Player $playerNumber name: ');
  String name = stdin.readLineSync()?.trim() ?? '';

  if (name.isEmpty) {
    name = 'Player $playerNumber';
  }

  return name;
}

/// Validates a player's move.
String? validateMove(String move) {
  String cleanedMove = move.trim().toLowerCase();

  if (validMoves.contains(cleanedMove)) {
    return cleanedMove;
  }

  return null;
}

/// Gets a valid move from a player.
String getMove(String playerName) {
  while (true) {
    stdout.write('$playerName, enter your move (rock/paper/scissors): ');
    String input = stdin.readLineSync() ?? '';

    String? move = validateMove(input);

    if (move != null) {
      return move;
    }

    print('Invalid move. Please type rock, paper, or scissors.');
  }
}

/// Determines the winner of a round.
/// Returns '1', '2', or null if the round is a draw.
String? decideWinner(String move1, String move2) {
  if (move1 == move2) {
    return null;
  }

  switch (move1) {
    case 'rock':
      if (move2 == 'scissors') {
        return '1';
      } else {
        return '2';
      }

    case 'paper':
      if (move2 == 'rock') {
        return '1';
      } else {
        return '2';
      }

    case 'scissors':
      if (move2 == 'paper') {
        return '1';
      } else {
        return '2';
      }
  }

  return null;
}

/// Hides Player 1's move before Player 2 enters a move.
void hidePlayerOneMove() {
  for (int i = 0; i < 30; i++) {
    print('');
  }
}

/// Asks the players whether they want to play again.
String getPlayAgain() {
  while (true) {
    stdout.write('Play again? (y/n): ');
    String answer = stdin.readLineSync()?.trim().toLowerCase() ?? '';

    if (answer == 'y' || answer == 'n') {
      return answer;
    }

    print('Please enter y or n.');
  }
}

/// Runs the game and displays the final scores.
void main() {
  print('===== ROCK, PAPER, SCISSORS =====');

  String player1 = getPlayerName('1');
  String player2 = getPlayerName('2');

  int score1 = 0;
  int score2 = 0;
  int round = 1;
  String playAgain;

  do {
    print('\n--- Round $round ---');

    String move1 = getMove(player1);

    hidePlayerOneMove();

    String move2 = getMove(player2);

    print('$player1 chose $move1.');
    print('$player2 chose $move2.');

    String? winner = decideWinner(move1, move2);

    if (winner == null) {
      print("Result: It's a draw!");
    } else if (winner == '1') {
      print('Result: $player1 wins the round!');
      score1++;
    } else {
      print('Result: $player2 wins the round!');
      score2++;
    }

    print('Score -> $player1: $score1 | $player2: $score2');

    round++;

    playAgain = getPlayAgain();
  } while (playAgain == 'y');

  print('\n===== FINAL SCORE =====');
  print('$player1: $score1 | $player2: $score2');

  if (score1 > score2) {
    print('Overall winner: $player1');
  } else if (score2 > score1) {
    print('Overall winner: $player2');
  } else {
    print("The game ends in a draw!");
  }
}