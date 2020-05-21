import 'package:flutter/material.dart';
import 'package:shapp/Components/story_brain.dart';
import 'package:shapp/Screens/registration_screen.dart';

StoryBrain storyBrain = StoryBrain();

class QuestionTask extends StatefulWidget {
  static const String id = 'questiontask_screen';
  @override
  _QuestionTaskState createState() => _QuestionTaskState();
}

class _QuestionTaskState extends State<QuestionTask> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Sh...'),
                    content: Text('Is too late now you made your choose!'),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('ok'))
                    ],
                  ));
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
            constraints: BoxConstraints.expand(),
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 12,
                  child: Center(
                    child: Text(
                      storyBrain.getStory(),
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Visibility(
                      visible: storyBrain.buttonShouldBeVisible1(),
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            storyBrain.storySuccess()
                                ? Navigator.pushNamed(
                                    context, RegistrationScreen.id)
                                : storyBrain.nextStory(1);
                          });
                        },
                        color: Colors.black54,
                        child: Text(
                          storyBrain.getChoice1(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: storyBrain.buttonShouldBeVisible2(),
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            storyBrain.storyFail()
                                ? Navigator.pop(context)
                                : storyBrain.nextStory(2);
                          });
                        },
                        color: Colors.black54,
                        child: Text(storyBrain.getChoice2(),
                            style: TextStyle(fontSize: 20.0)),
                      ),
                    )
                  ],
                )
              ],
            )),
          ),
        ));
  }
}
