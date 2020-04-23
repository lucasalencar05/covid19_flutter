import 'package:flutter/material.dart';
import 'package:covid19_flutter/controllers/countries_controller.dart';
import 'package:covid19_flutter/widgets/collectcard_widgets.dart';
import 'package:covid19_flutter/widgets/switchbutton_widgets.dart';
import 'package:covid19_flutter/widgets/loading_widgets.dart';
import 'package:covid19_flutter/models/country_model.dart';

class CountryDetailPage extends StatefulWidget {
  final String countryName;

  CountryDetailPage({@required this.countryName});

  @override
  _CountryDetailPageState createState() => _CountryDetailPageState();
}

class _CountryDetailPageState extends State<CountryDetailPage> {
  Country _countryInfo;
  double deathPercentage;
  double activePercentage;
  bool _isLoading = false;
  CountriesController _countriesController = CountriesController();
  double recoveryPercentage;

  @override
  void initState() {
    super.initState();
    _getCountryDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.countryName,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).accentColor,
          ),
        ),
        actions: <Widget>[
          SwitchButton(),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? Loading()
            : _countryInfo == null
                ? handleErrorMessage()
                : ListView(
                    children: <Widget>[
                      CollectCard(
                        color: Colors.deepOrangeAccent[100],
                        text: 'Total de casos',
                        icon: Icons.show_chart,
                        stats: _countryInfo.cases,
                      ),
                      CollectCard(
                        color: Colors.pinkAccent[700],
                        text: 'Ativos',
                        icon: Icons.add_alert,
                        stats: _countryInfo.active,
                      ),
                      CollectCard(
                        color: Colors.green[200],
                        text: 'Recuperados',
                        icon: Icons.beenhere,
                        stats: _countryInfo.recovered,
                      ),
                      CollectCard(
                        color: Colors.grey[700],
                        text: 'Críticos',
                        icon: Icons.report,
                        stats: _countryInfo.critical,
                      ),
                      CollectCard(
                        color: Colors.blueAccent[100],
                        text: 'Testados',
                        icon: Icons.threesixty,
                        stats: _countryInfo.tests,
                      ),
                      CollectCard(
                        color: Colors.redAccent,
                        text: 'Mortes',
                        icon: Icons.hotel,
                        stats: _countryInfo.deaths,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          elevation: 4.0,
                          child: ListTile(
                            leading: Icon(Icons.mood_bad),
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
                            leading: Icon(Icons.mood),
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

  void _getCountryDetails() async {
    setState(() => _isLoading = true);
    try {
      var countryInfo = await _countriesController.getCountryByName(widget.countryName);
      deathPercentage = (countryInfo.deaths / countryInfo.cases) * 100;
      recoveryPercentage = (countryInfo.recovered / countryInfo.cases) * 100;
      activePercentage = 100 - (deathPercentage + recoveryPercentage);
      setState(() => _countryInfo = countryInfo);
    } catch (ex) {
      setState(() => _countryInfo = null);
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
