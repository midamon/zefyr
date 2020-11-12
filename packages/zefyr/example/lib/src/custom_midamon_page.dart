import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class CustomMidamonPage extends StatefulWidget {
  @override
  _CustomMidamonPageState createState() => _CustomMidamonPageState();
}

class _CustomMidamonPageState extends State<CustomMidamonPage> {
  NotusDocument _document;
  ZefyrController _controller;
  FocusNode _focusNode;

  final colors = <Color>[Colors.black, Colors.green, Colors.purple];

  @override
  void initState() {
    super.initState();
    _document = NotusDocument();
    _controller = ZefyrController(_document);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Page')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                child: ZefyrField(
                  controller: _controller,
                  focusNode: _focusNode,
                  expands: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 8.0),
                    hintText: 'Detailed description, but not too detailed',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: colors.asMap().entries.map((color) {
                return ToggleStyleButton(
                  attribute: NotusAttribute.color,
                  icon: Icons.ac_unit,
                  controller: _controller,
                  childBuilder: stooryToggleButton,
                );
              }).toList(),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

Widget stooryToggleButton(
  BuildContext context,
  NotusAttribute attribute,
  IconData icon,
  bool isToggled,
  VoidCallback onPressed,
) {
  return CircleColor(
    color: Colors.green,
    innerCircleColor: Colors.green,
    borderColor: Colors.greenAccent,
    onPressed: onPressed,
  );
}

class CircleColor extends StatelessWidget {
  const CircleColor({
    Key key,
    this.color = Colors.white,
    this.innerCircleColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.borderWidth = 3.0,
    this.onPressed,
  }) : super(key: key);

  final Color color;
  final Color innerCircleColor;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0.0,
      highlightElevation: 0.0,
      focusElevation: 0.0,
      fillColor: color,
      splashColor: Colors.transparent,
      highlightColor: Colors.white,
      animationDuration: Duration(microseconds: 1),
      constraints: BoxConstraints(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.all(20),
      visualDensity: VisualDensity.compact,
      shape: CircleBorder(
        side: BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: Icon(
        Icons.circle,
        color: innerCircleColor,
        size: 30,
      ),
    );
  }
}
