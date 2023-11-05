import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final double width;
  final Color color;
  final VoidCallback onPressed;

  const ButtonWidget({
    Key? key,
    required this.title,
    required this.width,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        child: Text(title.toUpperCase()),
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  final String text;

  const InfoText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.circle, size: 12.0, color: Colors.blue),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

//Make a switch that toggles back and forth when pressed (on/off)
class SwitchWidget extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchWidget({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool _currentValue = false;

  @override
  void initState() {
    super.initState();
    _currentValue =
        widget.value; // Initialize switch state based on passed value
  }

  // Clean up the resources when you leave
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
          value: _currentValue,
          onChanged: (bool newValue) {
            setState(() {
              _currentValue = newValue; // Update the switch state
            });
            widget
                .onChanged(newValue); // Notify the parent widget of the change
          },
        ),
      ],
    );
  }
}
