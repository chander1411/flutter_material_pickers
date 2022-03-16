import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:intl/intl.dart';

import 'model.dart';
import 'theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.light,
      light: buildTheme(Brightness.light),
      dark: buildTheme(Brightness.dark),
      builder: (context, theme) {
        return MaterialApp(
          title: 'Material Picker Examples',
          theme: theme,
          home: TestPage(),
        );
      },
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var model = ExampleModel();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Material Picker Examples'),
          actions: <Widget>[
            IconButton(
              icon: Theme.of(context).brightness == Brightness.dark
                  ? Icon(Icons.brightness_7)
                  : Icon(Icons.brightness_4),
              onPressed: () => AdaptiveTheme.of(context).toggleThemeMode(),
            )
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(text: 'New Pickers'),
              Tab(text: 'Convenience Pickers'),
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: TabBarView(
              children: <Widget>[
                Card(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: ListView(
                      children: <Widget>[
                        buildEmptyRow(context),
                        Divider(),
                        buildScrollRow(context),
                        Divider(),
                        buildNumberRow(context),
                        Divider(),
                        buildCheckboxRow(context),
                        Divider(),
                        buildRadioRow(context),
                        Divider(),
                        buildSelectionRow(context),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: ListView(
                      children: <Widget>[
                        buildTimeRow(context),
                        Divider(),
                        buildDateRow(context),
                        Divider(),
                        buildColorRow(context),
                        Divider(),
                        buildPaletteRow(context),
                        Divider(),
                        buildSwatchRow(context),
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
  }

  Row buildEmptyRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150.0,
          child: ElevatedButton(
            child: Text('Empty Dialog'),
            onPressed: () => showMaterialResponsiveDialog<void>(
              context: context,
              hideButtons: false,
              confirmText: 'Yes',
              cancelText: 'No',
              onConfirmed: () => print('Dialog confirmed'),
              onCancelled: () => print('Dialog cancelled'),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(30.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'This is the base dialog widget for the pickers. Unlike the off-the-shelf Dialog widget, it handles landscape orientations. You may place any content here you desire.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: '\n\n'),
                        TextSpan(
                            text:
                                'This example has the button bar hidden, so you dismiss it by clicking outside the window.',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300)),
                        //TextSpan(text: 'your text',style: TextStyle(color: Colors.redAccent,fontSize: 38))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            'n/a',
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Row buildScrollRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150.0,
          child: ElevatedButton(
            child: Text('Scroll Picker'),
            onPressed: () => showMaterialScrollPicker<PickerModel>(
              context: context,
              title: 'Pick Your City',
              showDivider: false,
              items: ExampleModel.usStates,
              selectedItem: model.selectedUsState,
              onChanged: (value) =>
                  setState(() => model.selectedUsState = value),
              onCancelled: () => print('Scroll Picker cancelled'),
              onConfirmed: () => print('Scroll Picker confirmed'),
            ),
          ),
        ),
        Expanded(
          child: Text(
            '${model.selectedUsState} (${model.selectedUsState.code})',
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Row buildNumberRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150.0,
          child: ElevatedButton(
            child: Text('Number Picker'),
            onPressed: () => showMaterialNumberPicker(
              context: context,
              title: 'Pick a Number',
              maxNumber: 100,
              minNumber: 15,
              step: 5,
              confirmText: 'Count me in',
              cancelText: 'Negatory',
              selectedNumber: model.age,
              onChanged: (value) => setState(() => model.age = value),
            ),
          ),
        ),
        Expanded(
          child: Text(
            model.age.toString(),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Row buildCheckboxRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150.0,
          child: ElevatedButton(
            child: Text('Checkbox Picker'),
            onPressed: () => showMaterialCheckboxPicker<PickerModel>(
              context: context,
              title: 'Pick Your Toppings',
              items: ExampleModel.iceCreamToppings,
              selectedItems: model.selectedIceCreamToppings,
              onChanged: (value) =>
                  setState(() => model.selectedIceCreamToppings = value),
            ),
          ),
        ),
        Expanded(
          child: Text(
            model.selectedIceCreamToppings.toString(),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Row buildRadioRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150.0,
          child: ElevatedButton(
            child: Text('Radio Picker'),
            onPressed: () => showMaterialRadioPicker<PickerModel>(
              context: context,
              title: 'Pick Your City',
              items: ExampleModel.usStates,
              selectedItem: model.selectedUsState,
              onChanged: (value) =>
                  setState(() => model.selectedUsState = value),
            ),
          ),
        ),
        Expanded(
          child: Text(
            '${model.selectedUsState} (${model.selectedUsState.code})',
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Row buildSelectionRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150.0,
          child: ElevatedButton(
            child: Text('Selection Picker'),
            onPressed: () => showMaterialSelectionPicker<PickerModel>(
              context: context,
              title: 'Starship Speed',
              items: ExampleModel.speedOptions,
              selectedItem: model.speed,
              iconizer: (item) => item.icon,
              onChanged: (value) => setState(() => model.speed = value),
            ),
          ),
        ),
        Expanded(
          child: Text(
            '${model.speed} (${model.speed.code})',
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Row buildTimeRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150.0,
          child: ElevatedButton(
            child: Text('Time Picker'),
            onPressed: () => showMaterialTimePicker(
              context: context,
              selectedTime: model.time,
              onChanged: (value) => setState(() => model.time = value),
            ),
          ),
        ),
        Expanded(
          child: Text(
            MaterialLocalizations.of(context).formatTimeOfDay(model.time),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Row buildDateRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150.0,
          child: ElevatedButton(
            child: Text('Date Picker'),
            onPressed: () => showMaterialDatePicker(
              title: 'Pick a date',
              firstDate: DateTime(1990, 1, 1),
              lastDate: DateTime(2050, 12, 31),
              context: context,
              selectedDate: model.date,
              onChanged: (value) => setState(() => model.date = value),
            ),
          ),
        ),
        Expanded(
          child: Text(
            DateFormat.yMMMd().format(model.date),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Row buildColorRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150.0,
          child: ElevatedButton(
            child: Text('Color Picker'),
            onPressed: () => showMaterialColorPicker(
              context: context,
              selectedColor: model.color,
              onChanged: (value) => setState(() => model.color = value),
            ),
          ),
        ),
        Expanded(child: Container()),
        Container(
          height: 20.0,
          width: 100.0,
          decoration: BoxDecoration(
            color: model.color,
          ),
        ),
      ],
    );
  }

  Row buildPaletteRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150.0,
          child: ElevatedButton(
            child: Text('Palette Picker'),
            onPressed: () => showMaterialPalettePicker(
              context: context,
              selectedColor: model.palette,
              onChanged: (value) => setState(() => model.palette = value),
            ),
          ),
        ),
        Expanded(child: Container()),
        Container(
          height: 20.0,
          width: 100.0,
          decoration: BoxDecoration(
            color: model.palette,
          ),
        ),
      ],
    );
  }

  Row buildSwatchRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150.0,
          child: ElevatedButton(
            child: Text('Swatch Picker'),
            onPressed: () => showMaterialSwatchPicker(
              context: context,
              selectedColor: model.swatch,
              onChanged: (value) => setState(() => model.swatch = value),
            ),
          ),
        ),
        Expanded(child: Container()),
        Container(
          height: 20.0,
          width: 100.0,
          decoration: BoxDecoration(
            color: model.swatch,
          ),
        ),
      ],
    );
  }
}
