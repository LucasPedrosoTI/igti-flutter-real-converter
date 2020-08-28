import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _realController = TextEditingController();
  final TextEditingController _dollarValueController = TextEditingController();
  final key = GlobalKey<ScaffoldState>();
  var _result = '';

  clear() {
    _realController.clear();
    _dollarValueController.clear();

    setState(() {
      _result = '';
    });
  }

  calc() {

    if (_realController.text.isEmpty || _dollarValueController.text.isEmpty){
      return key.currentState.showSnackBar(
          SnackBar(
              content: Text('Quantidade e Cotação são obrigatórios')
          )
      );
    }

    try {
      var real = double.parse(_realController.text);
      var dollarValue = double.parse(_dollarValueController.text);

      if ( real <= 0 || dollarValue <= 0 ){
        return key.currentState.showSnackBar(
            SnackBar(
                content: Text("Valores não podem ser menor que 0")
            )
        );
      }

      var inDollar = real / dollarValue;
      setState(() {
        _result =
        'Com $real reais é possível comprar ${inDollar.toStringAsFixed(2)} dólares a $dollarValue cada';
      });
    } catch (e) {
      key.currentState.showSnackBar(SnackBar(
        content: Text('Quantidade ou cotação foram informados em formato inválido.'),
      ));
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('Reais para Dólares', style: TextStyle(fontSize: 20)),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                  child: Image.asset(
                    "images/emoji.png",
                    width: 75,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _realController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                        hintText: 'Quantidade em reais',
                        icon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _dollarValueController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                        hintText: 'Cotação do Dólar',
                        icon: Icon(Icons.monetization_on),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                        onPressed: clear,
                        child: Container(
                          color: Colors.redAccent,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 25),
                          child: Text('Limpar',
                              style: TextStyle(color: Colors.white)),
                        )),
                    FlatButton(
                        onPressed: calc,
                        child: Container(
                          color: Colors.lightGreen,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 25),
                          child: Text('Calcular',
                              style: TextStyle(color: Colors.white)),
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(_result,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontSize: 18, height: 1.5))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
