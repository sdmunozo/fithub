import 'package:flutter/material.dart';

class NumberPickerWidget extends StatefulWidget {
  final int initialValue;
  final bool isDecimal;
  final Function(int) onValueChanged;
  final FixedExtentScrollController controller;

  const NumberPickerWidget({
    super.key,
    required this.initialValue,
    required this.onValueChanged,
    required this.controller,
    this.isDecimal = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPickerWidget> {
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    int maxItems = widget.isDecimal ? 100 : 200;

    return SizedBox(
      height: 150,
      width: 80,
      child: ListWheelScrollView.useDelegate(
        controller: _scrollController,
        itemExtent: 50,
        onSelectedItemChanged: (index) {
          widget.onValueChanged(index);
        },
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            return Center(
              child: Text(
                widget.isDecimal
                    ? index.toString().padLeft(2, '0')
                    : index.toString(),
                style: const TextStyle(fontSize: 44),
              ),
            );
          },
          childCount: maxItems,
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';

class NumberPickerWidget extends StatefulWidget {
  final int initialValue;
  final bool isDecimal;
  final Function(int) onValueChanged;
  final FixedExtentScrollController controller;

  NumberPickerWidget({
    required this.initialValue,
    required this.onValueChanged,
    required this.controller,
    this.isDecimal = false,
  });

  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPickerWidget> {
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    int maxItems = widget.isDecimal ? 100 : 200;

    return Container(
      height: 150,
      width: 80,
      child: ListWheelScrollView.useDelegate(
        controller: _scrollController,
        itemExtent: 50,
        onSelectedItemChanged: (index) {
          widget.onValueChanged(index);
        },
        physics: FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            return Center(
              child: Text(
                widget.isDecimal
                    ? index.toString().padLeft(2, '0')
                    : index.toString(),
                style: TextStyle(fontSize: 44),
              ),
            );
          },
          childCount: maxItems,
        ),
      ),
    );
  }
}
*/