
import 'dart:io';

/// Stores the valid moves.
const List<String> validMoves = ['rock', 'paper', 'scissors'];

/// Gets a player's name or uses a default name if it is empty.
String getPlayerName(String prompt, String defaultName) {
  stdout.write(prompt);
  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    print('No name entered. Using "$defaultName".');
    return defaultName;
  }

  return input.trim();
}

/// Checks whether a move is valid.
String? validateMove(String? input) {
  if (input == null) {
    return null;
  }

  String move = input.trim().toLowerCase();

  if (validMoves.contains(move)) {
    return move;
  }

  return null;
}

/// Keeps asking until the player enters a valid move.
String getMove(String playerName) {
  while (true) {
    stdout.write('$playerName, enter your move (rock/paper/scissors): ');
    String? input = stdin.readLineSync();
    String? move = validateMove(input);

    if (move != null) {
      return move;
    }

    print('Invalid move. Please type rock, paper, or scissors.');
  }
}

/// Decides the round winner. Returns null for a draw.
String? decideWinner(String playerOneMove, String playerTwoMove) {
  if (playerOneMove == playerTwoMove) {
    return null;
  }

  switch (playerOneMove) {
    case 'rock':
      if (playerTwoMove == 'scissors') {
        return '1';
      }
      break;
    case 'paper':
      if (playerTwoMove == 'rock') {
        return '1';
      }
      break;
    case 'scissors':
      if (playerTwoMove == 'paper') {
        return '1';
      }
      break;
  }

  return '2';
}

/// Prints blank lines to hide Player 1's move.
void hidePlayerOneMove() {
  for (int i = 0; i < 30; i++) {
    print('');
  }
}

/// Asks whether the players want to play again.
String getPlayAgain() {
  while (true) {
    stdout.write('Play again? (y/n): ');
    String? input = stdin.readLineSync();
    String answer = (input ?? '').trim().toLowerCase();

    if (answer == 'y' || answer == 'n') {
      return answer;
    }

    print('Please enter y or n.');
  }
}

/// Runs the game and displays the final scores.
void main() {
  int playerOneScore = 0;
  int playerTwoScore = 0;

  print('===== ROCK, PAPER, SCISSORS =====');

  String playerOneName =
      getPlayerName('Enter Player 1 name: ', 'Player 1');

  String playerTwoName =
      getPlayerName('Enter Player 2 name: ', 'Player 2');

  String playAgain;

  do {
    int roundNumber = playerOneScore + playerTwoScore + 1;
    print('\n--- Round $roundNumber ---');

    String playerOneMove = getMove(playerOneName);

    hidePlayerOneMove();

    String playerTwoMove = getMove(playerTwoName);

    print('$playerOneName chose $playerOneMove.');
    print('$playerTwoName chose $playerTwoMove.');

    String? winner = decideWinner(playerOneMove, playerTwoMove);

    String resultMessage;

    if (winner == null) {
      resultMessage = winner ?? "It's a draw!";
    } else if (winner == '1') {
      playerOneScore++;
      resultMessage = '$playerOneName wins the round!';
    } else {
      playerTwoScore++;
      resultMessage = '$playerTwoName wins the round!';
    }

    print('Result: $resultMessage');
    print('Score -> $playerOneName: $playerOneScore | '
        '$playerTwoName: $playerTwoScore');

    playAgain = getPlayAgain();
  } while (playAgain == 'y');

  print('\n===== FINAL SCORE =====');
  print('$playerOneName: $playerOneScore | '
      '$playerTwoName: $playerTwoScore');

  if (playerOneScore > playerTwoScore) {
    print('Overall winner: $playerOneName');
  } else if (playerTwoScore > playerOneScore) {
    print('Overall winner: $playerTwoName');
  } else {
    print("Overall winner: It's a draw!");
  }
}
