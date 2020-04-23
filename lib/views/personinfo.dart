import 'package:flutter/material.dart';
import 'package:covid19_flutter/widgets/switchbutton_widgets.dart';

class PersonalInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sobre',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        actions: <Widget>[SwitchButton()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 93.0,
                      backgroundColor: Theme.of(context).accentColor,
                      child: CircleAvatar(
                        radius: 90.0,
                        backgroundImage: AssetImage(
                            'assets/images/person.jpg'
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Lucas Alencar',
                        style: Theme.of(context).textTheme.headline.copyWith(
                            color: Theme.of(context).accentColor
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text('lucasbalencar05@gmail.com',
                        style: TextStyle(color: Colors.teal[200]),
                        textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text('https://github.com/lucasalencar05/covid19_flutter',
                        style: TextStyle(color: Colors.teal[200]),
                        textAlign: TextAlign.center
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Desenvolvido com '),
                    Icon(
                      Icons.favorite,
                      color: Colors.tealAccent,
                    ),
                    Text(' Flutter')
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
