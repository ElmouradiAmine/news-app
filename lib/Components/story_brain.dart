import 'story.dart';

class StoryBrain {
  List<Story> _storyData = [
    Story(
        storyTitle:
            'In Order to Register an account, We would like to play a game to see if you are eligible to be part of the family',
        choice1: 'Continue',
        choice2: ''),
    Story(
        storyTitle: 'Woke up at 8am , What should u do',
        choice1: 'take a bath',
        choice2: 'continue Sleeping'),
    Story(
      storyTitle: 'You felt fresh and clean, what next?',
      choice1: 'Go to Work',
      choice2: 'lets get coffee',
    ),
    Story(
      storyTitle:
          'You contiune sleeping, the moment u woke up u see nothing but darkness',
      choice1: 'keep on Sleeping',
      choice2: 'wake up',
    ),
    Story(
      storyTitle:
          'Arriving at your workplace, u see a hot intern walk right past u with a smell of flower ',
      choice1: 'ignore',
      choice2: 'introduce ur self',
    ),
    Story(
      storyTitle:
          'a nice cup of coffe in your hand but absolutly late for work',
      choice1: 'Pronto',
      choice2: 'Skip Work today',
    ),
    Story(
      storyTitle:
          'By skipping Work today, u manage to acheive again absolutly nothing again. Unemployment is your way to go',
      choice1: 'Story success',
      choice2: 'Story fail',
    ),
    Story(
      storyTitle:
          'Nothing interesting hapen to you today, infact, nothing happen every day',
      choice1: 'Story success',
      choice2: 'Story fail',
    ),
    Story(
      storyTitle:
          'U introduce yourself and also make a fool out of yourself. That was no intern, that’s the boss\'s daughter. U got fired and went to deep sleep',
      choice1: 'Story success',
      choice2: 'Story fail',
    ),
  ];
  int _storyNumber = 0;

  String getStory() {
    return _storyData[_storyNumber].storyTitle;
  }

  String getChoice1() {
    return _storyData[_storyNumber].choice1;
  }

  String getChoice2() {
    return _storyData[_storyNumber].choice2;
  }

  void nextStory(int choiceNumber) {
    switch (_storyNumber) {
      case 0:
        if (choiceNumber == 1) _storyNumber = 1;
        if (choiceNumber == 2) _storyNumber = 1;
        break;
      case 1:
        if (choiceNumber == 1) _storyNumber = 2;
        if (choiceNumber == 2) _storyNumber = 3;
        break;
      case 2:
        if (choiceNumber == 1) _storyNumber = 4;
        if (choiceNumber == 2) _storyNumber = 5;
        break;
      case 3:
        if (choiceNumber == 1) _storyNumber = 6;
        if (choiceNumber == 2) _storyNumber = 6;
        break;
      case 4:
        if (choiceNumber == 1) _storyNumber = 7;
        if (choiceNumber == 2) _storyNumber = 8;
        break;
      case 5:
        if (choiceNumber == 1) _storyNumber = 4;
        if (choiceNumber == 2) _storyNumber = 6;
        break;
      case 6:
        if (choiceNumber == 1) restart();
        if (choiceNumber == 2) _storyNumber = null;
        break;
      case 7:
        if (choiceNumber == 1) restart();
        if (choiceNumber == 2) _storyNumber = null;
        break;
      case 8:
        if (choiceNumber == 1) restart();
        if (choiceNumber == 2) _storyNumber = null;
        break;
    }
  }

  void restart() {
    _storyNumber = 0;
  }

  bool buttonShouldBeVisible1() {
    if ([0, 1, 2, 3, 4, 5, 7].contains(_storyNumber)) {
      return true;
    } else {
      return false;
    }
  }
//  input case number of all story except fail ending.

  bool buttonShouldBeVisible2() {
    if ([1, 2, 3, 4, 5, 6, 8].contains(_storyNumber)) {
      return true;
    } else {
      return false;
    }
  }
//  input case number of all story except successful ending.

  bool storySuccess() {
    if ([7].contains(_storyNumber)) {
      return true;
    } else {
      return false;
    }
  }

// input Successful ending only.
  bool storyFail() {
    if ([6, 8].contains(_storyNumber)) {
      return true;
    } else {
      return false;
    }
  }
//  input Fail ending only.
}
