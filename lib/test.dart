import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() => runApp(const MaterialApp(home: MyApp2()));

class MyApp2 extends StatefulWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  bool lightTheme = true;
  Color currentColor = Colors.amber;
  List<Color> currentColors = [Colors.yellow, Colors.green];
  List<Color> colorHistory = [];

  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) => setState(() => currentColors = colors);

  @override
  Widget build(BuildContext context) {
    final foregroundColor = useWhiteForeground(currentColor) ? Colors.white : Colors.black;
    return AnimatedTheme(
      data: lightTheme ? ThemeData.light() : ThemeData.dark(),
      child: Builder(builder: (context) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => setState(() => lightTheme = !lightTheme),
              icon: Icon(lightTheme ? Icons.dark_mode_rounded : Icons.light_mode_rounded),
              label: Text(lightTheme ? 'Night' : '  Day '),
              backgroundColor: currentColor,
              foregroundColor: foregroundColor,
              elevation: 15,
            ),
            appBar: AppBar(
              title: const Text('Flutter Color Picker Example'),
              backgroundColor: currentColor,
              foregroundColor: foregroundColor,
              bottom: TabBar(
                labelColor: foregroundColor,
                tabs: const <Widget>[
                  Tab(text: 'HSV/HSL/RGB'),
                  Tab(text: 'Material'),
                  Tab(text: 'Blocky'),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                HSVColorPickerExample(
                  pickerColor: currentColor,
                  onColorChanged: changeColor,
                  colorHistory: colorHistory,
                  onHistoryChanged: (List<Color> colors) => colorHistory = colors,
                ),
                MaterialColorPickerExample(pickerColor: currentColor, onColorChanged: changeColor),
                BlockColorPickerExample(
                  pickerColor: currentColor,
                  onColorChanged: changeColor,
                  pickerColors: currentColors,
                  onColorsChanged: changeColors,
                  colorHistory: colorHistory,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}


const List<Color> colors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
];

class BlockColorPickerExample extends StatefulWidget {
  const BlockColorPickerExample({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    required this.pickerColors,
    required this.onColorsChanged,
    required this.colorHistory,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color> pickerColors;
  final ValueChanged<List<Color>> onColorsChanged;
  final List<Color> colorHistory;

  @override
  State<BlockColorPickerExample> createState() => _BlockColorPickerExampleState();
}

class _BlockColorPickerExampleState extends State<BlockColorPickerExample> {
  int _portraitCrossAxisCount = 4;
  int _landscapeCrossAxisCount = 5;
  double _borderRadius = 30;
  double _blurRadius = 5;
  double _iconSize = 24;

  Widget pickerLayoutBuilder(BuildContext context, List<Color> colors, PickerItem child) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return SizedBox(
      width: 300,
      height: orientation == Orientation.portrait ? 360 : 240,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait ? _portraitCrossAxisCount : _landscapeCrossAxisCount,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: [for (Color color in colors) child(color)],
      ),
    );
  }

  Widget pickerItemBuilder(Color color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        color: color,
        boxShadow: [BoxShadow(color: color.withOpacity(0.8), offset: const Offset(1, 2), blurRadius: _blurRadius)],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: isCurrentColor ? 1 : 0,
            child: Icon(
              Icons.done,
              size: _iconSize,
              color: useWhiteForeground(color) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: const EdgeInsets.all(0),
                    contentPadding: const EdgeInsets.all(25),
                    content: SingleChildScrollView(
                      child: Text(
                        '''
Widget pickerLayoutBuilder(BuildContext context, List<Color> colors, PickerItem child) {
  Orientation orientation = MediaQuery.of(context).orientation;
  return SizedBox(
    width: 300,
    height: orientation == Orientation.portrait ? 360 : 240,
    child: GridView.count(
      crossAxisCount: orientation == Orientation.portrait ? $_portraitCrossAxisCount : $_landscapeCrossAxisCount,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: [for (Color color in colors) child(color)],
    ),
  );
}
                            ''',
                      ),
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.code, color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
            style: ElevatedButton.styleFrom(
              primary: widget.pickerColor,
              shadowColor: widget.pickerColor.withOpacity(1),
              elevation: 10,
            ),
          ),
        ),
        ListTile(
          title: const Text('Portrait Cross Axis Count'),
          subtitle: Text(_portraitCrossAxisCount.toString()),
          trailing: SizedBox(
            width: 200,
            child: Slider(
              value: _portraitCrossAxisCount.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: _portraitCrossAxisCount.toString(),
              onChanged: (double value) => setState(() => _portraitCrossAxisCount = value.round()),
            ),
          ),
        ),
        ListTile(
          title: const Text('Landscape Cross Axis Count'),
          subtitle: Text(_landscapeCrossAxisCount.toString()),
          trailing: SizedBox(
            width: 200,
            child: Slider(
              value: _landscapeCrossAxisCount.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: _landscapeCrossAxisCount.toString(),
              onChanged: (double value) => setState(() => _landscapeCrossAxisCount = value.round()),
            ),
          ),
        ),
        const Divider(),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: const EdgeInsets.all(0),
                    contentPadding: const EdgeInsets.all(25),
                    content: SingleChildScrollView(
                      child: Text(
                        '''
Widget pickerItemBuilder(Color color, bool isCurrentColor, void Function() changeColor) {
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular($_borderRadius),
      color: color,
      boxShadow: [BoxShadow(color: color.withOpacity(0.8), offset: const Offset(1, 2), blurRadius: $_blurRadius)],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: changeColor,
        borderRadius: BorderRadius.circular(_borderRadius),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: isCurrentColor ? 1 : 0,
          child: Icon(
            Icons.done,
            size: $_iconSize,
            color: useWhiteForeground(color) ? Colors.white : Colors.black,
          ),
        ),
      ),
    ),
  );
}
                            ''',
                      ),
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.code, color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
            style: ElevatedButton.styleFrom(
              primary: widget.pickerColor,
              shadowColor: widget.pickerColor.withOpacity(1),
              elevation: 10,
            ),
          ),
        ),
        ListTile(
          title: const Text('Border Radius'),
          subtitle: Text(_borderRadius.toString()),
          trailing: SizedBox(
            width: 200,
            child: Slider(
              value: _borderRadius,
              min: 0,
              max: 30,
              divisions: 30,
              label: _borderRadius.toString(),
              onChanged: (double value) => setState(() => _borderRadius = value.round().toDouble()),
            ),
          ),
        ),
        ListTile(
          title: const Text('Blur Radius'),
          subtitle: Text(_blurRadius.toString()),
          trailing: SizedBox(
            width: 200,
            child: Slider(
              value: _blurRadius,
              min: 0,
              max: 5,
              divisions: 5,
              label: _blurRadius.toString(),
              onChanged: (double value) => setState(() => _blurRadius = value.round().toDouble()),
            ),
          ),
        ),
        ListTile(
          title: const Text('Icon Size'),
          subtitle: Text(_iconSize.toString()),
          trailing: SizedBox(
            width: 200,
            child: Slider(
              value: _iconSize,
              min: 1,
              max: 50,
              divisions: 49,
              label: _iconSize.toString(),
              onChanged: (double value) => setState(() => _iconSize = value.round().toDouble()),
            ),
          ),
        ),
        const Divider(),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Select a color'),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          availableColors: widget.colorHistory.isNotEmpty ? widget.colorHistory : colors,
                          layoutBuilder: pickerLayoutBuilder,
                          itemBuilder: pickerItemBuilder,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Blocky Color Picker',
                style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      titlePadding: EdgeInsets.all(0),
                      contentPadding: EdgeInsets.all(25),
                      content: SingleChildScrollView(
                        child: Text(
                          '''
BlockPicker(
  pickerColor: color,
  onColorChanged: changeColor,
  availableColors: colors,
  layoutBuilder: pickerLayoutBuilder,
  itemBuilder: pickerItemBuilder,
)
                          ''',
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.code, color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Select colors'),
                      content: SingleChildScrollView(
                        child: MultipleChoiceBlockPicker(
                          pickerColors: widget.pickerColors,
                          onColorsChanged: widget.onColorsChanged,
                          availableColors: widget.colorHistory.isNotEmpty ? widget.colorHistory : colors,
                          layoutBuilder: pickerLayoutBuilder,
                          itemBuilder: pickerItemBuilder,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Multiple selection Blocky Color Picker',
                style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      titlePadding: EdgeInsets.all(0),
                      contentPadding: EdgeInsets.all(25),
                      content: SingleChildScrollView(
                        child: Text(
                          '''
MultipleChoiceBlockPicker(
  pickerColors: colors,
  onColorsChanged: changeColors,
  availableColors: colors,
  layoutBuilder: pickerLayoutBuilder,
  itemBuilder: pickerItemBuilder,
)
                          ''',
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.code, color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
void copyToClipboard(String input) {
  String textToCopy = input.replaceFirst('#', '').toUpperCase();
  if (textToCopy.startsWith('FF') && textToCopy.length == 8) {
    textToCopy = textToCopy.replaceFirst('FF', '');
  }
  Clipboard.setData(ClipboardData(text: '#$textToCopy'));
}

class HSVColorPickerExample extends StatefulWidget {
  const HSVColorPickerExample({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.colorHistory,
    this.onHistoryChanged,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color>? colorHistory;
  final ValueChanged<List<Color>>? onHistoryChanged;

  @override
  State<HSVColorPickerExample> createState() => _HSVColorPickerExampleState();
}

class _HSVColorPickerExampleState extends State<HSVColorPickerExample> {
  // Picker 1
  PaletteType _paletteType = PaletteType.hsl;
  bool _enableAlpha = true;
  bool _displayThumbColor = true;
  final List<ColorLabelType> _labelTypes = [ColorLabelType.hsl, ColorLabelType.hsv];
  bool _displayHexInputBar = false;

  // Picker 2
  bool _displayThumbColor2 = true;
  bool _enableAlpha2 = false;

  // Picker 3
  ColorModel _colorModel = ColorModel.rgb;
  bool _enableAlpha3 = false;
  bool _displayThumbColor3 = true;
  bool _showParams = true;
  bool _showIndicator = true;

  // Picker 4
  final textController =
      TextEditingController(text: '#2F19DB'); // The initial value can be provided directly to the controller.
  bool _enableAlpha4 = true;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          colorPickerWidth: 300,
                          pickerAreaHeightPercent: 0.7,
                          enableAlpha: _enableAlpha,
                          labelTypes: _labelTypes,
                          displayThumbColor: _displayThumbColor,
                          paletteType: _paletteType,
                          pickerAreaBorderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(2),
                            topRight: Radius.circular(2),
                          ),
                          hexInputBar: _displayHexInputBar,
                          colorHistory: widget.colorHistory,
                          onHistoryChanged: widget.onHistoryChanged,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Color Picker with Slider',
                style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Text(
                          '''
ColorPicker(
  pickerColor: color,
  onColorChanged: changeColor,
  colorPickerWidth: 300,
  pickerAreaHeightPercent: 0.7,
  enableAlpha: $_enableAlpha,
  labelTypes: $_labelTypes,
  displayThumbColor: $_displayThumbColor,
  paletteType: $_paletteType,
  pickerAreaBorderRadius: const BorderRadius.only(
    topLeft: Radius.circular(2),
    topRight: Radius.circular(2),
  ),
  hexInputBar: $_displayHexInputBar,
  colorHistory: colorHistory,
  onHistoryChanged: changeColorHistory,
)
                          ''',
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.code, color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
          ],
        ),
        SwitchListTile(
          title: const Text('Enable Alpha Slider'),
          subtitle: const Text('Display alpha slider & label text'),
          value: _enableAlpha,
          onChanged: (bool value) => setState(() => _enableAlpha = !_enableAlpha),
        ),
        SwitchListTile(
          title: const Text('Display Thumb Color in slider'),
          value: _displayThumbColor,
          onChanged: (bool value) => setState(() => _displayThumbColor = !_displayThumbColor),
        ),
        ListTile(
          title: const Text('Palette Type'),
          trailing: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _paletteType,
              onChanged: (PaletteType? type) {
                if (type != null) setState(() => _paletteType = type);
              },
              items: [
                for (PaletteType type in PaletteType.values)
                  DropdownMenuItem(
                    value: type,
                    child: SizedBox(
                      width: 150,
                      child: Text(type.toString().split('.').last, textAlign: TextAlign.end),
                    ),
                  )
              ],
            ),
          ),
        ),
        ExpansionTile(
          title: Text(_labelTypes.isNotEmpty ? 'Display Label' : 'Disable Label'),
          subtitle: Text(
            _labelTypes.isNotEmpty ? _labelTypes.map((e) => e.toString().split('.').last.toUpperCase()).toString() : '',
          ),
          children: [
            SwitchListTile(
              title: const Text('    Display HEX Label Text'),
              value: _labelTypes.contains(ColorLabelType.hex),
              onChanged: (bool value) => setState(
                () => value ? _labelTypes.add(ColorLabelType.hex) : _labelTypes.remove(ColorLabelType.hex),
              ),
              dense: true,
            ),
            SwitchListTile(
              title: const Text('    Display RGB Label Text'),
              value: _labelTypes.contains(ColorLabelType.rgb),
              onChanged: (bool value) => setState(
                () => value ? _labelTypes.add(ColorLabelType.rgb) : _labelTypes.remove(ColorLabelType.rgb),
              ),
              dense: true,
            ),
            SwitchListTile(
              title: const Text('    Display HSV Label Text'),
              value: _labelTypes.contains(ColorLabelType.hsv),
              onChanged: (bool value) => setState(
                () => value ? _labelTypes.add(ColorLabelType.hsv) : _labelTypes.remove(ColorLabelType.hsv),
              ),
              dense: true,
            ),
            SwitchListTile(
              title: const Text('    Display HSL Label Text'),
              value: _labelTypes.contains(ColorLabelType.hsl),
              onChanged: (bool value) => setState(
                () => value ? _labelTypes.add(ColorLabelType.hsl) : _labelTypes.remove(ColorLabelType.hsl),
              ),
              dense: true,
            ),
          ],
        ),
        SwitchListTile(
          title: const Text('Display Hex Input Bar'),
          value: _displayHexInputBar,
          onChanged: (bool value) => setState(() => _displayHexInputBar = !_displayHexInputBar),
        ),
        const Divider(),
        const SizedBox(height: 5),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: MediaQuery.of(context).orientation == Orientation.portrait
                            ? const BorderRadius.vertical(
                                top: Radius.circular(500),
                                bottom: Radius.circular(100),
                              )
                            : const BorderRadius.horizontal(right: Radius.circular(500)),
                      ),
                      content: SingleChildScrollView(
                        child: HueRingPicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          enableAlpha: _enableAlpha2,
                          displayThumbColor: _displayThumbColor2,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Hue Ring Picker with Hex Input',
                style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Text(
                          '''
HueRingPicker(
  pickerColor: color,
  onColorChanged: changeColor,
  enableAlpha: $_enableAlpha2,
  displayThumbColor: $_displayThumbColor2,
)
                          ''',
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.code, color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
          ],
        ),
        SwitchListTile(
          title: const Text('Enable Alpha Slider'),
          value: _enableAlpha2,
          onChanged: (bool value) => setState(() => _enableAlpha2 = !_enableAlpha2),
        ),
        SwitchListTile(
          title: const Text('Display Thumb Color in Slider'),
          value: _displayThumbColor2,
          onChanged: (bool value) => setState(() => _displayThumbColor2 = !_displayThumbColor2),
        ),
        const Divider(),
        const SizedBox(height: 5),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                      content: SingleChildScrollView(
                        child: SlidePicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          colorModel: _colorModel,
                          enableAlpha: _enableAlpha3,
                          displayThumbColor: _displayThumbColor3,
                          showParams: _showParams,
                          showIndicator: _showIndicator,
                          indicatorBorderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Slider-only Color Picker',
                style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Text(
                          '''
SlidePicker(
  pickerColor: color,
  onColorChanged: changeColor,
  colorModel: $_colorModel,
  enableAlpha: $_enableAlpha3,
  displayThumbColor: $_displayThumbColor3,
  showParams: $_showParams,
  showIndicator: $_showIndicator,
  indicatorBorderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
)
                          ''',
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.code, color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
          ],
        ),
        ListTile(
          title: const Text('Color Model'),
          trailing: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _colorModel,
              onChanged: (ColorModel? type) {
                if (type != null) setState(() => _colorModel = type);
              },
              items: [
                for (ColorModel type in ColorModel.values)
                  DropdownMenuItem(
                    value: type,
                    child: SizedBox(
                      width: 50,
                      child: Text(type.toString().split('.').last, textAlign: TextAlign.end),
                    ),
                  )
              ],
            ),
          ),
        ),
        SwitchListTile(
          title: const Text('Enable Alpha Slider'),
          value: _enableAlpha3,
          onChanged: (bool value) => setState(() => _enableAlpha3 = !_enableAlpha3),
        ),
        SwitchListTile(
          title: const Text('Display Thumb Color in Slider'),
          value: _displayThumbColor3,
          onChanged: (bool value) => setState(() => _displayThumbColor3 = !_displayThumbColor3),
        ),
        SwitchListTile(
          title: const Text('Show Parameters next to Slider'),
          value: _showParams,
          onChanged: (bool value) => setState(() => _showParams = !_showParams),
        ),
        SwitchListTile(
          title: const Text('Show Color Indicator'),
          value: _showIndicator,
          onChanged: (bool value) => setState(() => _showIndicator = !_showIndicator),
        ),
        const Divider(),
        const SizedBox(height: 15),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      content: Column(
                        children: [
                          ColorPicker(
                            pickerColor: widget.pickerColor,
                            onColorChanged: widget.onColorChanged,
                            colorPickerWidth: 300,
                            pickerAreaHeightPercent: 0.7,
                            enableAlpha: _enableAlpha4, // hexInputController will respect it too.
                            displayThumbColor: true,
                            paletteType: PaletteType.hsvWithHue,
                            labelTypes: const [],
                            pickerAreaBorderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(2),
                              topRight: Radius.circular(2),
                            ),
                            hexInputController: textController, // <- here
                            portraitOnly: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            /* It can be any text field, for example:
                            * TextField
                            * TextFormField
                            * CupertinoTextField
                            * EditableText
                            * any text field from 3-rd party package
                            * your own text field
                            so basically anything that supports/uses
                            a TextEditingController for an editable text.
                            */
                            child: CupertinoTextField(
                              controller: textController,
                              // Everything below is purely optional.
                              prefix: const Padding(padding: EdgeInsets.only(left: 8), child: Icon(Icons.tag)),
                              suffix: IconButton(
                                icon: const Icon(Icons.content_paste_rounded),
                                onPressed: () => copyToClipboard(textController.text),
                              ),
                              autofocus: true,
                              maxLength: 9,
                              inputFormatters: [
                                // Any custom input formatter can be passed
                                // here or use any Form validator you want.
                                UpperCaseTextFormatter(),
                                FilteringTextInputFormatter.allow(RegExp(kValidHexPattern)),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text(
                '  HSV Color Picker\n(Your own text field)',
                style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Text(
                          '''
Column(
  children: [
    ColorPicker(
      pickerColor: color,
      onColorChanged: changeColor,
      colorPickerWidth: 300,
      pickerAreaHeightPercent: 0.7,
      enableAlpha: $_enableAlpha4,
      displayThumbColor: true,
      paletteType: PaletteType.hsvWithHue,
      labelTypes: const [],
      pickerAreaBorderRadius: const BorderRadius.only(
        topLeft: Radius.circular(2),
        topRight: Radius.circular(2),
      ),
      hexInputController: textController,
      portraitOnly: true,
    ),
    Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: CupertinoTextField(
        controller: textController,
        prefix: const Padding(padding: EdgeInsets.only(left: 8), child: Icon(Icons.tag)),
        suffix: IconButton(
          icon: const Icon(Icons.content_paste_rounded),
          onPressed: () => copyToClipboard(textController.text),
        ),
        autofocus: true,
        maxLength: 9,
        inputFormatters: [
          UpperCaseTextFormatter(),
          FilteringTextInputFormatter.allow(RegExp(kValidHexPattern)),
        ],
      ),
    )
  ],
)
                          ''',
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.code, color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
          ],
        ),
        SwitchListTile(
          title: const Text('Enable Alpha Slider'),
          value: _enableAlpha4,
          onChanged: (bool value) => setState(() => _enableAlpha4 = !_enableAlpha4),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
class MaterialColorPickerExample extends StatefulWidget {
  const MaterialColorPickerExample({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;

  @override
  State<MaterialColorPickerExample> createState() => _MaterialColorPickerExampleState();
}

class _MaterialColorPickerExampleState extends State<MaterialColorPickerExample> {
  bool _enableLabel = true;
  bool _portraitOnly = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      content: SingleChildScrollView(
                        child: MaterialPicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          enableLabel: _enableLabel,
                          portraitOnly: _portraitOnly,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Kiss Me with Your Finger',
                style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(25),
                      content: SingleChildScrollView(
                        child: Text(
                          '''
MaterialPicker(
  pickerColor: color,
  onColorChanged: changeColor,
  enableLabel: $_enableLabel,
  portraitOnly: $_portraitOnly,
)
                          ''',
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.code, color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
          ],
        ),
        SwitchListTile(
          title: const Text('Enable Label in Portrait Mode'),
          value: _enableLabel,
          onChanged: (bool value) => setState(() => _enableLabel = !_enableLabel),
        ),
        SwitchListTile(
          title: const Text('Apply Portrait layout to Landscape Mode'),
          value: _portraitOnly,
          onChanged: (bool value) => setState(() => _portraitOnly = !_portraitOnly),
        ),
      ],
    );
  }
}