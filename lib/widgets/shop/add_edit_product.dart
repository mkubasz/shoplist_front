import 'package:flutter/material.dart';

class AddEditProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddEditProductState();
  }
}

class _AddEditProductState extends State<AddEditProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Produkt"),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Opis"),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Ilość"),
            ),
            DropdownButton(
              disabledHint: Text("Wybierz kategorię produktu"),
              items: [
                DropdownMenuItem(
                  value: "1",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.build),
                      SizedBox(width: 10),
                      Text(
                        "Owoce",
                      ),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  setState(() {
//                    BlocProvider.of<ManagerBloc>(context).add(AddProduct(
//                        Product(
//                            id: Uuid().v1(),
//                            name: name,
//                            description: description,
//                            number: int.parse(amount))));
//                  });

                    //Navigator.of(context).pop();
                  });
                },
                child: Text('Dodaj'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
