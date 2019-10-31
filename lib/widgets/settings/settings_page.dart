import 'package:duck_shop/blocs/settings_bloc.dart';
import 'package:duck_shop/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  Settings settings;
  SettingsPage({this.settings});

  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  Settings settings;
  @override
  void initState() {
    super.initState();
    settings = widget.settings ?? Settings();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            initialValue: widget.settings?.session,
            decoration: InputDecoration(
              hintText: 'Nazwa sesji',
            ),
            onChanged: (value) {
              setState(() {
                settings.session = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                BlocProvider.of<SettingsBloc>(context)
                    .add(UpdateSettings(settings: settings));
              },
              child: Text('Zapisz'),
            ),
          ),
        ],
      ),
    );
  }
}
