import 'package:fithub_v1/providers/global_config_provider.dart';
import 'package:fithub_v1/widgets/number_picker_widget.dart';
import 'package:flutter/material.dart';

class NumberSelectorWidget extends StatefulWidget {
  final String title;
  final String type; // 'height', 'weight', o 'heartRate'
  final Function(double, String) onValueChanged;

  NumberSelectorWidget({
    required this.title,
    required this.type,
    required this.onValueChanged,
  });

  @override
  _NumberSelectorWidgetState createState() => _NumberSelectorWidgetState();
}

class _NumberSelectorWidgetState extends State<NumberSelectorWidget> {
  bool isMetric = true;
  int intPart = 0;
  int decimalPart = 0;

  late FixedExtentScrollController _intPartController;
  late FixedExtentScrollController _decimalPartController;

  static const double minHeightM = 1.4;
  static const double maxHeightM = 2.0;
  static const double minHeightFt = 4.59;
  static const double maxHeightFt = 6.56;

  static const double minWeightKg = 40.0;
  static const double maxWeightKg = 150.0;
  static const double minWeightLb = 88.18;
  static const double maxWeightLb = 330.69;

  static const double minHeartRateBPM = 50.0;
  static const double maxHeartRateBPM = 130.0;

  @override
  void initState() {
    super.initState();
    double initialValue = 0.0; // Inicialización por defecto

    if (widget.type == 'height') {
      initialValue = isMetric ? 1.6 : 5.25; // Valor inicial en metros o pies
    } else if (widget.type == 'weight') {
      initialValue = isMetric ? 70.0 : 154.32; // Valor inicial en kg o lb
    } else if (widget.type == 'heartRate') {
      initialValue = 70.0;
    }

    // Separar la parte entera y decimal del valor inicial
    intPart = initialValue.floor();
    decimalPart = ((initialValue - intPart) * 100).round();

    _intPartController = FixedExtentScrollController(initialItem: intPart);
    _decimalPartController =
        FixedExtentScrollController(initialItem: decimalPart);
  }

  void toggleUnits() {
    setState(() {
      double value = intPart + decimalPart / 100.0;
      double minValue = 0.0;
      double maxValue = 0.0;

      if (widget.type == 'height') {
        if (isMetric) {
          minValue = minHeightFt;
          maxValue = maxHeightFt;
          value *= 3.281; // Convertir de metros a pies
        } else {
          minValue = minHeightM;
          maxValue = maxHeightM;
          value /= 3.281; // Convertir de pies a metros
        }
      } else if (widget.type == 'weight') {
        if (isMetric) {
          minValue = minWeightLb;
          maxValue = maxWeightLb;
          value *= 2.205; // Convertir de kg a lb
        } else {
          minValue = minWeightKg;
          maxValue = maxWeightKg;
          value /= 2.205; // Convertir de lb a kg
        }
      } else if (widget.type == 'heartRate') {
        minValue = minHeartRateBPM;
        maxValue = maxHeartRateBPM;
      }

      // Limitar el valor al rango permitido
      if (value < minValue) value = minValue;
      if (value > maxValue) value = maxValue;

      // Separar la parte entera y decimal
      intPart = value.floor();
      decimalPart = ((value - intPart) * 100).round();
      isMetric = !isMetric;

      // Actualiza los valores en los controladores de NumberPicker
      _intPartController.jumpToItem(intPart);
      _decimalPartController.jumpToItem(decimalPart);

      widget.onValueChanged(value, getUnits());
    });
  }

  String getUnits() {
    if (widget.type == 'height') {
      return isMetric ? 'm' : 'ft';
    } else if (widget.type == 'weight') {
      return isMetric ? 'kg' : 'lb';
    } else if (widget.type == 'heartRate') {
      return 'BPM';
    }
    return '';
  }

  void _accept() {
    widget.onValueChanged(intPart + decimalPart / 100.0, getUnits());
    Navigator.of(context).pop();
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: widget.type != 'heartRate' ? 320 : 285,
        width: GlobalConfigProvider.maxWidth,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (widget.type != 'heartRate')
              GestureDetector(
                onTap: toggleUnits,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(), // Espacio flexible
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.type == 'height'
                              ? (isMetric ? 'Cambiar a FT' : 'Cambiar a M')
                              : (isMetric ? 'Cambiar a LB' : 'Cambiar a KG'),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            decoration:
                                TextDecoration.none, // Quitamos el subrayado
                          ),
                        ),
                        Container(
                          height: 3,
                          width: 100,
                          color: Colors.green,
                          constraints: const BoxConstraints(
                            maxWidth: double.infinity,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(), // Espacio flexible
                  ],
                ),
              ),
            Spacer(),
            Container(
              color: const Color.fromARGB(0, 0, 0, 0),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NumberPickerWidget(
                          controller: _intPartController,
                          initialValue: intPart,
                          onValueChanged: (value) {
                            setState(() {
                              intPart = value;
                            });
                          },
                        ),
                        if (widget.type != 'heartRate') ...[
                          SizedBox(
                            width: 10,
                          ),
                          const Text(
                            ".",
                            style: TextStyle(fontSize: 44),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          NumberPickerWidget(
                            controller: _decimalPartController,
                            initialValue: decimalPart,
                            isDecimal: true,
                            onValueChanged: (value) {
                              setState(() {
                                decimalPart = value;
                              });
                            },
                          ),
                        ],
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          getUnits(),
                          style: TextStyle(fontSize: 40),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: _cancel,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                      ),
                    ),
                    height: 50,
                    width: (GlobalConfigProvider.maxWidth! * 0.5),
                    child: Center(
                      child: Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _accept,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF3DDB8F),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                      ),
                    ),
                    height: 50,
                    width: (GlobalConfigProvider.maxWidth! * 0.5),
                    child: Center(
                      child: Text(
                        'Aceptar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



/*import 'package:fithub_v1/providers/global_config_provider.dart';
import 'package:fithub_v1/widgets/number_picker_widget.dart';
import 'package:flutter/material.dart';

class NumberSelectorWidget extends StatefulWidget {
  final String title;
  final String type; // 'height', 'weight', o 'heartRate'
  final Function(double, String) onValueChanged;

  NumberSelectorWidget({
    required this.title,
    required this.type,
    required this.onValueChanged,
  });

  @override
  _NumberSelectorWidgetState createState() => _NumberSelectorWidgetState();
}

class _NumberSelectorWidgetState extends State<NumberSelectorWidget> {
  bool isMetric = true;
  int intPart = 0;
  int decimalPart = 0;

  late FixedExtentScrollController _intPartController;
  late FixedExtentScrollController _decimalPartController;

  static const double minHeightM = 1.4;
  static const double maxHeightM = 2.0;
  static const double minWeightKg = 40.0;
  static const double maxWeightKg = 150.0;
  static const double minHeartRateBPM = 50.0;
  static const double maxHeartRateBPM = 130.0;

  @override
  void initState() {
    super.initState();
    if (widget.type == 'height') {
      intPart = 1;
      decimalPart = 60;
      double value = intPart + decimalPart / 100.0;
      if (value < minHeightM) value = minHeightM;
      if (value > maxHeightM) value = maxHeightM;
      intPart = value.floor();
      decimalPart = ((value - intPart) * 100).round();
    } else if (widget.type == 'weight') {
      intPart = 70;
      decimalPart = 0;
      double value = intPart + decimalPart / 100.0;
      if (value < minWeightKg) value = minWeightKg;
      if (value > maxWeightKg) value = maxWeightKg;
      intPart = value.floor();
      decimalPart = ((value - intPart) * 100).round();
    } else if (widget.type == 'heartRate') {
      intPart = 50;
      decimalPart = 0;
      double value = intPart + decimalPart / 100.0;
      if (value < minHeartRateBPM) value = minHeartRateBPM;
      if (value > maxHeartRateBPM) value = maxHeartRateBPM;
      intPart = value.floor();
      decimalPart = ((value - intPart) * 100).round();
    }
    _intPartController = FixedExtentScrollController(initialItem: intPart);
    _decimalPartController =
        FixedExtentScrollController(initialItem: decimalPart);
  }

  void toggleUnits() {
    setState(() {
      double value = intPart + decimalPart / 100.0;
      double minValue = 0.0;
      double maxValue = 0.0;

      if (widget.type == 'height') {
        if (isMetric) {
          minValue = minHeightM * 3.281;
          maxValue = maxHeightM * 3.281;
          value *= 3.281; // Convertir de metros a pies
        } else {
          minValue = minHeightM;
          maxValue = maxHeightM;
          value /= 3.281; // Convertir de pies a metros
        }
      } else if (widget.type == 'weight') {
        if (isMetric) {
          minValue = minWeightKg * 2.205;
          maxValue = maxWeightKg * 2.205;
          value *= 2.205; // Convertir de kg a lb
        } else {
          minValue = minWeightKg;
          maxValue = maxWeightKg;
          value /= 2.205; // Convertir de lb a kg
        }
      } else if (widget.type == 'heartRate') {
        minValue = minHeartRateBPM;
        maxValue = maxHeartRateBPM;
      }

      // Limitar el valor al rango permitido
      if (value < minValue) value = minValue;
      if (value > maxValue) value = maxValue;

      // Separar la parte entera y decimal
      intPart = value.floor();
      decimalPart = ((value - intPart) * 100).round();
      isMetric = !isMetric;

      // Actualiza los valores en los controladores de NumberPicker
      _intPartController.jumpToItem(intPart);
      _decimalPartController.jumpToItem(decimalPart);

      widget.onValueChanged(value, getUnits());
    });
  }

  String getUnits() {
    if (widget.type == 'height') {
      return isMetric ? 'm' : 'ft';
    } else if (widget.type == 'weight') {
      return isMetric ? 'kg' : 'lb';
    } else if (widget.type == 'heartRate') {
      return 'BPM';
    }
    return '';
  }

  void _accept() {
    widget.onValueChanged(intPart + decimalPart / 100.0, getUnits());
    Navigator.of(context).pop();
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: widget.type != 'heartRate' ? 320 : 285,
        width: GlobalConfigProvider.maxWidth,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (widget.type != 'heartRate')
              GestureDetector(
                onTap: toggleUnits,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(), // Espacio flexible
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.type == 'height'
                              ? (isMetric ? 'Cambiar a FT' : 'Cambiar a M')
                              : (isMetric ? 'Cambiar a LB' : 'Cambiar a KG'),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            decoration:
                                TextDecoration.none, // Quitamos el subrayado
                          ),
                        ),
                        Container(
                          height: 3,
                          width: 100,
                          color: Colors.green,
                          constraints: const BoxConstraints(
                            maxWidth: double.infinity,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(), // Espacio flexible
                  ],
                ),
              ),
            Spacer(),
            Container(
              color: const Color.fromARGB(0, 0, 0, 0),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NumberPickerWidget(
                          controller: _intPartController,
                          initialValue: intPart,
                          onValueChanged: (value) {
                            setState(() {
                              intPart = value;
                            });
                          },
                        ),
                        if (widget.type != 'heartRate') ...[
                          SizedBox(
                            width: 10,
                          ),
                          const Text(
                            ".",
                            style: TextStyle(fontSize: 44),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          NumberPickerWidget(
                            controller: _decimalPartController,
                            initialValue: decimalPart,
                            isDecimal: true,
                            onValueChanged: (value) {
                              setState(() {
                                decimalPart = value;
                              });
                            },
                          ),
                        ],
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          getUnits(),
                          style: TextStyle(fontSize: 40),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: _cancel,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                      ),
                    ),
                    height: 50,
                    width: (GlobalConfigProvider.maxWidth! * 0.5),
                    child: Center(
                      child: Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _accept,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF3DDB8F),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                      ),
                    ),
                    height: 50,
                    width: (GlobalConfigProvider.maxWidth! * 0.5),
                    child: Center(
                      child: Text(
                        'Aceptar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

*/



/*
import 'package:fithub_v1/providers/global_config_provider.dart';
import 'package:flutter/material.dart';

class NumberSelectorWidget extends StatefulWidget {
  final String title;
  final String type; // 'height', 'weight', o 'heartRate'
  final Function(double, String) onValueChanged;

  NumberSelectorWidget({
    required this.title,
    required this.type,
    required this.onValueChanged,
  });

  @override
  _NumberSelectorWidgetState createState() => _NumberSelectorWidgetState();
}

class _NumberSelectorWidgetState extends State<NumberSelectorWidget> {
  bool isMetric = true;
  int intPart = 0;
  int decimalPart = 0;

  late FixedExtentScrollController _intPartController;
  late FixedExtentScrollController _decimalPartController;

  @override
  void initState() {
    super.initState();
    if (widget.type == 'height') {
      intPart = 1;
      decimalPart = 60;
    } else if (widget.type == 'weight') {
      intPart = 70;
      decimalPart = 0;
    } else if (widget.type == 'heartRate') {
      intPart = 50;
      decimalPart = 0;
    }
    _intPartController = FixedExtentScrollController(initialItem: intPart);
    _decimalPartController =
        FixedExtentScrollController(initialItem: decimalPart);
  }

  void toggleUnits() {
    setState(() {
      double value = intPart + decimalPart / 100.0;
      if (widget.type == 'height') {
        if (isMetric) {
          value *= 3.281; // Convertir de metros a pies
        } else {
          value /= 3.281; // Convertir de pies a metros
        }
      } else if (widget.type == 'weight') {
        if (isMetric) {
          value *= 2.205; // Convertir de kg a lb
        } else {
          value /= 2.205; // Convertir de lb a kg
        }
      }
      // Separar la parte entera y decimal
      intPart = value.floor();
      decimalPart = ((value - intPart) * 100).round();
      isMetric = !isMetric;

      // Actualiza los valores en los controladores de NumberPicker
      _intPartController.jumpToItem(intPart);
      _decimalPartController.jumpToItem(decimalPart);

      widget.onValueChanged(value, getUnits());
    });
  }

  String getUnits() {
    if (widget.type == 'height') {
      return isMetric ? 'm' : 'ft';
    } else if (widget.type == 'weight') {
      return isMetric ? 'kg' : 'lb';
    } else if (widget.type == 'heartRate') {
      return 'BPM';
    }
    return '';
  }

  void _accept() {
    widget.onValueChanged(intPart + decimalPart / 100.0, getUnits());
    Navigator.of(context).pop();
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: widget.type != 'heartRate' ? 320 : 285,
        width: GlobalConfigProvider.maxWidth,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (widget.type != 'heartRate')
              GestureDetector(
                onTap: toggleUnits,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(), // Espacio flexible
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.type == 'height'
                              ? (isMetric ? 'Cambiar a FT' : 'Cambiar a M')
                              : (isMetric ? 'Cambiar a LB' : 'Cambiar a KG'),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            decoration:
                                TextDecoration.none, // Quitamos el subrayado
                          ),
                        ),
                        Container(
                          height: 3,
                          width: 100,
                          color: Colors.green,
                          constraints: const BoxConstraints(
                            maxWidth: double.infinity,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(), // Espacio flexible
                  ],
                ),
              ),
            Spacer(),
            Container(
              color: const Color.fromARGB(0, 0, 0, 0),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NumberPicker(
                          controller: _intPartController,
                          initialValue: intPart,
                          onValueChanged: (value) {
                            setState(() {
                              intPart = value;
                            });
                          },
                        ),
                        if (widget.type != 'heartRate') ...[
                          SizedBox(
                            width: 10,
                          ),
                          const Text(
                            ".",
                            style: TextStyle(fontSize: 44),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          NumberPicker(
                            controller: _decimalPartController,
                            initialValue: decimalPart,
                            isDecimal: true,
                            onValueChanged: (value) {
                              setState(() {
                                decimalPart = value;
                              });
                            },
                          ),
                        ],
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          getUnits(),
                          style: TextStyle(fontSize: 40),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: _cancel,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                      ),
                    ),
                    height: 50,
                    width: (GlobalConfigProvider.maxWidth! * 0.5),
                    child: Center(
                      child: Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _accept,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF3DDB8F),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                      ),
                    ),
                    height: 50,
                    width: (GlobalConfigProvider.maxWidth! * 0.5),
                    child: Center(
                      child: Text(
                        'Aceptar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NumberPicker extends StatefulWidget {
  final int initialValue;
  final bool isDecimal;
  final Function(int) onValueChanged;
  final FixedExtentScrollController controller;

  NumberPicker({
    required this.initialValue,
    required this.onValueChanged,
    required this.controller,
    this.isDecimal = false,
  });

  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 50,
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
          childCount: widget.isDecimal ? 100 : 200,
        ),
      ),
    );
  }
}


 */