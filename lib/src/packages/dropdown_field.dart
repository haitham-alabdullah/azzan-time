part of 'custom_dropdown.dart';

const _textFieldIcon = Icon(
  Icons.keyboard_arrow_down_rounded,
  color: Colors.black,
  size: 20,
);

class _DropDownField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final Function(String)? onChanged;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final String? errorText;
  final TextStyle? errorStyle;
  final BorderSide? borderSide;
  final BorderSide? errorBorderSide;
  final BorderRadius? borderRadius;
  final Widget? suffixIcon;
  final Color? fillColor;
  final String Function(String) valueBuilder;

  const _DropDownField({
    Key? key,
    required this.controller,
    required this.onTap,
    this.onChanged,
    this.suffixIcon,
    this.hintText,
    this.hintStyle,
    this.style,
    this.errorText,
    this.errorStyle,
    this.borderSide,
    this.errorBorderSide,
    this.borderRadius,
    this.fillColor,
    required this.valueBuilder,
  }) : super(key: key);

  @override
  State<_DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<_DropDownField> {
  String? prevText;
  bool listenChanges = true;

  @override
  void initState() {
    super.initState();
    if (widget.onChanged != null) {
      widget.controller.addListener(listenItemChanges);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(listenItemChanges);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _DropDownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onChanged != null) {
      widget.controller.addListener(listenItemChanges);
    } else {
      listenChanges = false;
    }
  }

  void listenItemChanges() {
    final text = widget.controller.text;
    if (prevText != text && text.isNotEmpty) {
      widget.onChanged!(text);
    }
    prevText = text;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: widget.fillColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Get.locale == const Locale('en')
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Text(
                  widget.valueBuilder(widget.controller.text),
                  style: widget.style,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: widget.suffixIcon ?? _textFieldIcon,
            ),
            const SizedBox(width: 1),
          ],
        ),
      ),
    );
  }
}
