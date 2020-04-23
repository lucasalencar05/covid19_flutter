import 'package:flutter/material.dart';
import 'package:covid19_flutter/controllers/global_controller.dart';
import 'package:covid19_flutter/widgets/collectcard_widgets.dart';
import 'package:covid19_flutter/widgets/switchbutton_widgets.dart';
import 'package:covid19_flutter/widgets/loading_widgets.dart';
import 'package:covid19_flutter/models/globalinfo_model.dart';

class GlobalInfoPage extends StatefulWidget {
  @override
  _GlobalInfoPageState createState() => _GlobalInfoPageState();
}

class _GlobalInfoPageState extends State<GlobalInfoPage> {
  GlobalInfo _stats;
  double deathPercentage;
  double activePercentage;
  bool _isLoading = false;
  GlobalController _globalController = GlobalController();
  double recoveryPercentage;

  @override
  void initState() {
    super.initState();
    _getGlobalStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COVID-19',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        leading: Icon(
          Icons.public,
          color: Theme.of(context).accentColor,
        ),
        actions: <Widget>[
          SwitchButton(),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? Loading()
            : _stats == null
                ? handleErrorMessage()
                : ListView(
                    children: <Widget>[
                      CollectCard(
                        color: Colors.deepOrangeAccent[100],
                        text: 'Total de casos',
                        icon: Icons.show_chart,
                        stats: _stats.cases,
                      ),
                      CollectCard(
                        color: Colors.pinkAccent[700],
                        text: 'Total de ativos',
                        icon: Icons.add_alert,
                        stats: _stats.active,
                      ),
                      CollectCard(
                        color: Colors.green[200],
                        text: 'Total de recuperados',
                        icon: Icons.beenhere,
                        stats: _stats.recovered,
                      ),
                      CollectCard(
                        color: Colors.redAccent,
                        text: 'Total de mortes',
                        icon: Icons.hotel,
                        stats: _stats.deaths,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          elevation: 4.0,
                          child: ListTile(
                            leading: Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.grey[500],
                            ),
                            title: Text('Letalidade'),
                            trailing: Text(
                              deathPercentage.toStringAsFixed(2) + ' %',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          elevation: 4.0,
                          child: ListTile(
                            leading: Icon(
                              Icons.insert_emoticon,
                              color: Colors.grey[500],
                            ),
                            title: Text('Recuperação'),
                            trailing: Text(
                              recoveryPercentage.toStringAsFixed(2) + ' %',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
      ),
    );
  }

  Center handleErrorMessage() {
    return Center(
      child: Text(
        'Não foi possível retornar os dados.',
        style: TextStyle(
            color: Colors.grey,
            fontSize: 20
        ),
      ),
    );
  }

  void _getGlobalStats() async {
    setState(() => _isLoading = true);
    try {
      var stats = await _globalController.getGlobalInfo();
      deathPercentage = (stats.deaths / stats.cases) * 100;
      recoveryPercentage = (stats.recovered / stats.cases) * 100;
      activePercentage = 100 - (deathPercentage + recoveryPercentage);
      setState(() => _stats = stats);
    } catch (ex) {
      setState(() => _stats = null);
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
