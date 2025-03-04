// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../flutter_material_pickers.dart';

/// This helper widget manages a scrollable checkbox list inside a picker widget.
class CheckboxPicker<T> extends StatefulWidget {
  CheckboxPicker({
    Key? key,
    required this.items,
    required this.selectedItems,
    this.transformer,
  }) : super(key: key);

  // Constants
  static const double defaultItemHeight = 40.0;

  // Variables
  final List<T> items;
  final List<T> selectedItems;

  // Callbacks
  final Transformer<T>? transformer;

  @override
  CheckboxPickerState createState() {
    return CheckboxPickerState<T>(selectedItems);
  }
}

class CheckboxPickerState<T> extends State<CheckboxPicker<T>> {
  CheckboxPickerState(this.selectedValues);

  List<T> selectedValues;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    int itemCount = widget.items.length;

    return Container(
      child: Scrollbar(
        child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            final item = widget.items[index];
            bool isSelected = selectedValues.contains(item);

            return CheckboxListTile(
              activeColor: theme.colorScheme.secondary,
              checkColor: theme.dialogBackgroundColor,
              title: Text(
                widget.transformer?.call(item) ?? '$item',
                style: (isSelected)
                    ? TextStyle(color: theme.colorScheme.secondary)
                    : TextStyle(color: theme.textTheme.bodyText2?.color),
              ),
              value: isSelected,
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedValues.add(item);
                  } else {
                    selectedValues.remove(item);
                  }
                });
              },
            );
          },
        ),
      ),
    );
  }
}
