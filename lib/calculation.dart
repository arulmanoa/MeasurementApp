import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './model/measurement.dart';

class CalculationPage extends StatefulWidget {
  static String tag = 'calculation';
  @override
  _CalculationPage createState() => _CalculationPage();
}

class _CalculationPage extends State<CalculationPage> {
  double _kgToPounds = 2.2046,
      _poundsToKg =
          0.4536; // lbToKgConverter = 0.45359237, kgToLbConverter= 2.20462262
  double _cmToInch = 0.3937,
      _cmToFeet =
          0.0328; // cmToFeetConverter = 0.032808399, feetToCmConverter=30.48
  double cm_to_feet = 30.48, cm_to_inch = 2.54;
  final _types = ["Imperial to Metric", "Metric to Imperial"];
  final _units = ["Weight", "Height", "Temperature"];
  Measurements measurements;
  int _measurementype, _measuremenunit;

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  double _output = 0;
  String _selectedType;
  String _selectedUnit;
  String _labelSuffix = '', _labelSuffixOutput = '';

  final TextEditingController _inputNumber = TextEditingController(text: '');
  final TextEditingController _txtOutput = TextEditingController();

  double measurementConverter(double inputValue) {
    double convertedValue = 0;
    if (_measurementype == 1) {
      // KG to LB and LB to KG
      convertedValue = _measuremenunit == 1
          ? (inputValue * _kgToPounds)
          : _measuremenunit == 2
              ? (inputValue / cm_to_inch)
              : ((inputValue * 9 / 5 + 32));
      // : ((inputValue * 9 / 5 + 32).roundToDouble());
    } else if (_measurementype == 2) {
      // CM to INCH and INCH to CM
      convertedValue = _measuremenunit == 1
          ? (inputValue * _poundsToKg)
          : _measuremenunit == 2
              ? (inputValue * cm_to_inch)
              : (((inputValue - 32) * 5 / 9));
      // : (((inputValue - 32) * 5 / 9).roundToDouble());
    }
    return convertedValue;
  }

  void showInSnackBar(String message) {
    _key.currentState.showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    ));

    setState(() {
      _output = 0;
    });
  }

  _onSubmit() {
    try {
      if (_inputNumber.text.isEmpty ||
          _inputNumber.text == '' ||
          _inputNumber.text == null) {
        print('dsdf${_inputNumber.text}');
        showInSnackBar("Please enter a key value");
        return;
      } else if (_measurementype == null) {
        showInSnackBar("Kindly specify your Measurement type");
        return;
      } else if (_measuremenunit == null) {
        showInSnackBar("Kindly specify your Measurement unit");
        return;
      }
      double _beforeConversion = double.parse(_inputNumber.text);
      var _afterConversion = measurementConverter(_beforeConversion.toDouble());
      setState(() {
        // _output = _measurementype == 1 ? 'Result : $_inputNumber(Kg) Converted to $_output (Lbs)' :  'Result : $_inputNumber(Lbs) Converted to $_output (Kg)';
        _output = _afterConversion;
        _txtOutput.text = _output.toString();
      });
    } catch (e) {
      showInSnackBar(e);
    }
  }

  void updateType(String value) {
    switch (value) {
      case 'Metric to Imperial':
        _measurementype = 1;
        break;
      case 'Imperial to Metric':
        _measurementype = 2;
        break;
    }
    setState(() {
      _output = 0;
      _selectedType = value; // unused
      updateLabelSuffix();
    });
  }

  void updateUnit(String value) {
    switch (value) {
      case 'Weight':
        _measuremenunit = 1;
        break;
      case 'Height':
        _measuremenunit = 2;
        break;
      case 'Temperature':
        _measuremenunit = 3;
        break;
    }
    setState(() {
      _output = 0;
      _selectedUnit = value; // unused line
      updateLabelSuffix();
    });
  }

  void updateLabelSuffix() {
    var consoleStr = (_measurementype != null && _measuremenunit != null) &&
            _measurementype == 1
        ? (_measuremenunit == 1 ? 'kg' : _measuremenunit == 2 ? 'cm' : "C")
        : (_measuremenunit == 1 ? 'lbs' : _measuremenunit == 2 ? 'inch' : 'F');
    var consoleStr1 = (_measurementype != null && _measuremenunit != null) &&
            _measurementype == 1
        ? (_measuremenunit == 1 ? 'lbs' : _measuremenunit == 2 ? 'inch' : "F")
        : (_measuremenunit == 1 ? 'kg' : _measuremenunit == 2 ? 'cm' : 'C');
    setState(() {
      _labelSuffix = consoleStr.toString();
      _labelSuffixOutput = consoleStr1.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    var loginBtn = RaisedButton(
      onPressed: _onSubmit,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Text(
        "Convert",
        style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            textBaseline: TextBaseline.alphabetic),
      ),
      textColor: Colors.white,
      color: Colors.deepPurple,
    );

    var loginForm = Column(
      children: <Widget>[
        Form(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    ':: Form :: ',
                    style: TextStyle(fontSize: 16.0, letterSpacing: 2),
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                autocorrect: false,
                // maxLength: 15,
                decoration: InputDecoration(
                  labelText: 'Key Input',
                  hintText: 'Enter a value',

                  // labelText: _label,
                  suffixText: _labelSuffix,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[0-9.]")),
                  BlacklistingTextInputFormatter(RegExp('[ -]'))
                ],
                controller: _inputNumber,
                textInputAction: TextInputAction.next,
                autofocus: false,
              ),
              const SizedBox(height: 8.0),
              DropdownButton(
                isExpanded: true,
                hint: Text('Select an option'),
                value: _selectedType,
                onChanged: (newValue) {
                  updateType(newValue);
                },
                items: _types.map((type) {
                  return DropdownMenuItem(
                    child: Text(type),
                    value: type,
                  );
                }).toList(),
              ),
              const SizedBox(height: 10.0),
              DropdownButton(
                isExpanded: true,
                hint: Text('Select an option'),
                value: _selectedUnit,
                onChanged: (newValue) {
                  updateUnit(newValue);
                },
                items: _units.map((unit) {
                  return DropdownMenuItem(
                    child: Text(unit),
                    value: unit,
                  );
                }).toList(),
              ),
              // const SizedBox(height: 5.0),
              TextFormField(
                controller: _txtOutput,
                decoration: InputDecoration(
                  hintText: 'Output',
                  labelText: 'Output',
                  suffixText: _labelSuffixOutput,
                ),
                obscureText: false,
                readOnly: true,
              ),
              SizedBox(height: 30.0),
              // Text(
              //   // _measurementype == 1 && _measuremenunit != null
              //   //     ? 'Output : ${_inputNumber.text}Kg   ${_output}lbs'
              //   //     :
              //       'Output : $_output',
              //   style: Theme.of(context).textTheme.headline5,
              // ),
            ],
          ),
        ),
        loginBtn
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Conversion Screen'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            _inputNumber.clear();
          },
          child: Center(
            child: Container(
              child: loginForm,
            ),
          ),
        ),
      ),
    );
  }
}
