import 'package:flutter/material.dart';
import 'package:covid19_flutter/controllers/countries_controller.dart';
import 'package:covid19_flutter/widgets/switchbutton_widgets.dart';
import 'package:covid19_flutter/widgets/loading_widgets.dart';
import 'package:covid19_flutter/models/country_model.dart';
import 'countrydetail.dart';

class CountryListPage extends StatefulWidget {
  @override
  _CountryListPageState createState() => _CountryListPageState();
}

class _CountryListPageState extends State<CountryListPage> {
  bool _isLoading = false;
  CountriesController _countriesController = CountriesController();
  var items = List<Country>();
  var _focusNode = FocusNode();
  List<Country> _countries = List<Country>();
  var _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCountries();
  }

  void filterSearchResults(String query) {
    List<Country> dummySearchList = List<Country>();
    dummySearchList.addAll(_countries);
    if (query.isNotEmpty) {
      List<Country> dummyListData = List<Country>();
      dummySearchList.forEach((item) {
        if (item.country.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(_countries);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Países',
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
      body: _isLoading
          ? Loading()
          : _countries == null
              ? handleErrorMessage()
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        child: TextFormField(
                          focusNode: _focusNode,
                          controller: _controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).accentColor,
                              ),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor)),
                              labelText: 'Pesquisar',
                              labelStyle: TextStyle(
                                  color: Theme.of(context).accentColor),
                              hintText: 'Digite o nome do país'),
                          onChanged: filterSearchResults,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          var country = items[index];
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () {
                                _controller.clear();
                                filterSearchResults('');
                                _focusNode.unfocus();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CountryDetailPage(
                                            countryName:
                                            country.country),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 4.0,
                                child:  Container(
                                  height: 100.0,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        height: 80.0,
                                        width: 80.0,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(50),
                                                topLeft: Radius.circular(50),
                                                bottomRight: Radius.circular(50),
                                                topRight: Radius.circular(50)
                                            ),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "${country.countryInfo}"
                                                ),
                                            )
                                        ),
                                      ),
                                      Container(
                                        height: 100,
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                country.country,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 10),
                                                child: Container(
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.teal),
                                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                                  ),
                                                  child: Text(
                                                    'Casos: ' + country.cases.toString(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  Center handleErrorMessage() {
    return Center(
      child: Text(
        'Não foi possível retornar os dados.',
        style: Theme.of(context).textTheme.title.copyWith(color: Colors.grey),
      ),
    );
  }

  void _getCountries() async {
    try {
      setState(() => _isLoading = true);
      var countries = await _countriesController.getAllCountriesInfo();
      setState(() {
        _countries = countries;
        items.addAll(_countries);
      });
    } catch (ex) {
      setState(() => _countries = null);
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
