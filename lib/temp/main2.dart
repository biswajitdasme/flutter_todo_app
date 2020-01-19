import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator app",
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _currencies = ['Taka', 'USD', 'Euro'];
  final _minPadding = 5.0;
  var _currentItemSelected = '';

  TextEditingController principleController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  String displayResult = "";

  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.body2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minPadding * 2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principleController,
                  validator: (String value) {
                    if (value.isEmpty) return "Please enter principle ammount";
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Principle',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      hintText: 'Enter Principle eg. 12000'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: TextFormField(
                  style: textStyle,
                  controller: roiController,
                  validator: (String value) {
                    if (value.isEmpty) return "Please enter principle ammount";
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: "Interest",
                    labelStyle: textStyle,
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 15.0,
                    ),
                    hintText: "In Percent",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        style: textStyle,
                        controller: termController,
                        validator: (String value) {
                          if (value.isEmpty || !isDouble(value))
                            return "Please enter principle ammount";
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Term",
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                            ),
                            hintText: "Term in years",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(_minPadding),
                            )),
                      ),
                    ),
                    Container(
                      width: _minPadding * 5,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        style: textStyle,
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String newSelected) {
                          _onDropDownItemSelected(newSelected);
                        },
                        value: _currentItemSelected,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          "Calculate",
                          textScaleFactor: 1.2,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              this.displayResult = _calculateTotalReturns();
                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Reset",
                          textScaleFactor: 1.2,
                        ),
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: Text(
                  "$displayResult",
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isDouble(String str) {
    try {
      double.parse(str);
    } on FormatException {
      return false;
    }

    return true;
  }

  void _onDropDownItemSelected(String newSelected) {
    return setState(() {
      this._currentItemSelected = newSelected;
    });
  }

  String _calculateTotalReturns() {
    double principle = double.parse(principleController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalPayable = principle + (principle * roi * term) / 100;

    return "After $term, your investment will be worth $totalPayable $_currentItemSelected";
  }

  void _reset() {
    principleController.text = "";
    roiController.text = "";
    termController.text = "";
    displayResult = "";
    _currentItemSelected = _currencies[0];
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Center(
      child: Container(
        child: image,
        margin: EdgeInsets.only(
          top: _minPadding * 10,
          bottom: _minPadding * 5,
        ),
      ),
    );
  }
}

class FavoriteCity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoriteCityState();
  }
}

class _FavoriteCityState extends State<FavoriteCity> {
  String nameCity = "";
  var _currencies = ['Taka', 'Dollar', 'Euro'];

  String _currentCurrency = 'Taka';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateful App Example"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (String userInput) {
                setState(() {
                  nameCity = userInput;
                });
              },
            ),
            DropdownButton<String>(
              items: _currencies.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (String value) {
                _onDropDownItemChanged(value);
              },
              value: _currentCurrency,
            ),
            Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  "Your best city is $nameCity",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Nunito',
                    fontStyle: FontStyle.normal,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void _onDropDownItemChanged(String value) {
    setState(() {
      this._currentCurrency = value;
    });
  }
}
