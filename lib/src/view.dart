part of dartpacman;

class PacmanView {
  final auflage = querySelector("#auflage");
  final wilkommen = querySelector("#wilkommen");
  final highscore = querySelector("#highscore");
  final pacmangame = querySelector('#PacmanGame');
  final gameover = querySelector('#gameover');
  final reasons = querySelector('#reasons');
  final punkte = querySelector('#punkte');
  HtmlElement get startButton => querySelector('#start');
  List<List<HtmlElement>> fields;

  void update(PacmanGame model) {
    wilkommen.style.display = model.stopped ? "block" : "none";
    punkte.innerHtml = "Punkte: ${scores}/105";
    gameover.innerHtml = model.gameOver ? "Game Over" : "";
    int rest = 105 - scores;
    reasons.innerHtml = "Restliche Punkte: ${rest}";
    if (model.gameOver) {
      if(scores >= 105){
        final onfield = model.pacman.notOnField ? "Sie haben Gewonnen,<br> Neuer Versuch?<br>" : "";
        reasons.innerHtml = "$onfield";
      }else{
      final onfield = model.pacman.notOnField ? "Es haben ${rest} Punkte gefehlt.<br>Neuer Versuch?<br>" : "";
      reasons.innerHtml = "$onfield";
      }
    }

    final field = model.field;
    for (int row = 0; row < field.length; row++) {
      for (int col = 0; col < field[row].length; col++) {
        final td = fields[row][col];
        if (td != null) {
          td.classes.clear();
          if (field[row][col] == #corn) td.classes.add('corn');
          if (field[row][col] == #block) td.classes.add('block');
          if (field[row][col] == #ghost1) td.classes.add('ghost1');
          if (field[row][col] == #ghost2) td.classes.add('ghost2');
          if (field[row][col] == #ghost3) td.classes.add('ghost3');
          if (field[row][col] == #ghost4) td.classes.add('ghost4');
          if (field[row][col] == #pacman_up) td.classes.add('pacman_up');
          if (field[row][col] == #pacman_down) td.classes.add('pacman_down');
          if (field[row][col] == #pacman_left) td.classes.add('pacman_left');
          if (field[row][col] == #pacman_right) td.classes.add('pacman_right');
          else if (field[row][col] == #empty) td.classes.add('empty');
        }
      }
    }
  }

  void erzeugtSpielFeld(PacmanGame model) {
    final field = model.field;
    String table = "";
    for (int row = 0; row < field.length; row++) {
      table += "<tr>";
      for (int col = 0; col < field[row].length; col++) {
        final assignment = field[row][col];
        final pos = "field_${row}_${col}";
        table += "<td id='$pos' class='$assignment'></td>";
      }
      
      table += "</tr>";
    }
    pacmangame.innerHtml = table;
    fields = new List<List<HtmlElement>>(field.length);
    for (int row = 0; row < field.length; row++) {
      fields[row] = [];
      for (int col = 0; col < field[row].length; col++) {
        fields[row].add(pacmangame.querySelector("#field_${row}_${col}"));
      }
    }
  }

  closeForm() => auflage.innerHtml = "";
}