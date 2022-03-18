import 'package:flutter/material.dart';
import 'package:quizz_app_flutter/widgets/custom_text.dart';
import 'package:quizz_app_flutter/models/question.dart';

class PageQuizz extends StatefulWidget {
  const PageQuizz({Key? key}) : super(key: key);

  @override
  State<PageQuizz> createState() => _PageQuizzState();
}

class _PageQuizzState extends State<PageQuizz> {
  late Question question;

  List<Question> listeQuestions = [
    new Question('La devise de la Belgique est l\'union fait la force', true,
        '', 'belgique.JPG'),
    new Question('La lune va finir par tomber sur terre à cause de la gravité',
        false, 'Au contraire la lune s\'éloigne', 'lune.jpg'),
    new Question('La Russie est plus grande en superficie que Pluton', true, '',
        'russie.jpg'),
    new Question('Nyctalope est une race naine d\'antilope', false,
        'C’est une aptitude à voir dans le noir', 'nyctalope.jpg'),
    new Question('Le Commodore 64 est l\’oridnateur de bureau le plus vendu',
        true, '', 'commodore.jpg'),
    new Question('Le nom du drapeau des pirates es black skull', false,
        'Il est appelé Jolly Roger', 'pirate.png'),
    new Question('Haddock est le nom du chien Tintin', false, 'C\'est Milou',
        'tintin.jpg'),
    new Question('La barbe des pharaons était fausse', true,
        'A l\'époque déjà ils utilisaient des postiches', 'pharaon.jpg'),
    new Question(
        'Au Québec tire toi une bûche veut dire viens viens t\'asseoir',
        true,
        'La bûche, fameuse chaise de bucheron',
        'buche.jpg'),
    new Question('Le module lunaire Eagle de possédait de 4Ko de Ram', true,
        'Dire que je me plains avec mes 8GO de ram sur mon mac', 'eagle.jpg'),
  ];

  int index = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    question = listeQuestions[index];
  }

  @override
  Widget build(BuildContext context) {
    double taille = MediaQuery.of(context).size.width * 0.75;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText('Le quizz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomText(
              "Question numéro ${index + 1}",
              color: Colors.grey[900],
            ),
            CustomText(
              "Score: $score / $index",
              color: Colors.grey[900],
            ),
            Card(
              elevation: 10.0,
              child: Container(
                height: taille,
                width: taille,
                child: Image.asset(
                  //'assets/images/1.jpg',
                  'assets/images/${question.imagePath}',
                  //'assets/images/${question.imagePath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            CustomText(
              question.question,
              color: Colors.grey[900],
              factor: 1.3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[boutonBool(true), boutonBool(false)],
            )
          ],
        ),
      ),
    );
  }

  RaisedButton boutonBool(bool b) {
    return new RaisedButton(
      elevation: 10.0,
      onPressed: (() => dialogue(b)),
      color: Colors.blue,
      child: new CustomText(
        (b) ? "Vrai" : "Faux",
        factor: 1.25,
      ),
    );
  }

  Future<Null> dialogue(bool b) async {
    bool bonneReponse = (b == question.reponse);
    //String vrai = 'assets/images/1.png';
    String vrai = 'assets/images/vrai.jpg';
    //String faux = 'assets/images/1.png';
    String faux = 'assets/images/faux.jpg';
    if (bonneReponse) {
      score++;
    }

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: CustomText(
              (bonneReponse) ? "C'est gagné!" : "Oups! perdu...",
              factor: 1.4,
              color: (bonneReponse) ? Colors.green : Colors.red,
            ),
            contentPadding: EdgeInsets.all(20.0),
            children: <Widget>[
              Image.asset(
                (bonneReponse) ? vrai : faux,
                fit: BoxFit.cover,
              ),
              Container(
                height: 25.0,
              ),
              CustomText(
                question.explication,
                factor: 1.25,
                color: Colors.grey[900],
              ),
              Container(
                height: 25.0,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  questionSuivante();
                },
                child: CustomText(
                  "Au suivant",
                  factor: 1.25,
                ),
                color: Colors.blue,
              ),
            ],
          );
        });
  }

  Future<Null> alerte() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: CustomText(
              "C'est fini",
              color: Colors.blue,
              factor: 1.25,
            ),
            contentPadding: EdgeInsets.all(10.0),
            content: CustomText(
              "Votre socre: $score / $index",
              color: Colors.grey[900],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: (() {
                    Navigator.pop(buildContext);
                    Navigator.pop(context);
                  }),
                  child: CustomText(
                    "OK",
                    factor: 1.25,
                    color: Colors.blue,
                  ))
            ],
          );
        });
  }

  void questionSuivante() {
    if (index < listeQuestions.length - 1) {
      index++;
      setState(() {
        question = listeQuestions[index];
      });
    } else {
      alerte();
    }
  }
}
