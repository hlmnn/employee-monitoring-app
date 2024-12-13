import 'package:employee_monitoring_app/component/em_circular_loading.dart';
import 'package:flutter/material.dart';

import 'icon_position.dart';
import 'type_button.dart';

class EmButton extends StatelessWidget {
  const EmButton.elevated({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isExpand = true,
    this.style,
    this.textStyle,
    this.icon,
    this.iconPosition = IconPosition.start,
    this.isLoading = false,
  }) : _type = TypeButton.elevated,
        super(key: key);
  const EmButton.outlined({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isExpand = true,
    this.style,
    this.textStyle,
    this.icon,
    this.iconPosition = IconPosition.start,
    this.isLoading = false,
  }) : _type = TypeButton.elevated,
        super(key: key);
  const EmButton.text({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isExpand = true,
    this.style,
    this.textStyle,
    this.icon,
    this.iconPosition = IconPosition.start,
    this.isLoading = false,
  }) : _type = TypeButton.elevated,
        super(key: key);

  final TypeButton _type;
  final GestureTapCallback onPressed;
  final String text;
  final Widget? icon;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final IconPosition iconPosition;
  final bool isExpand;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: isExpand ? double.infinity : null,
        height: 50,
        child: Builder(
          builder: (context) {
            switch (_type) {
              case TypeButton.elevated:
                if (icon != null) {
                  return Directionality(
                    textDirection: iconPosition == IconPosition.start
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: isLoading ? null : onPressed,
                      style: style,
                      label: isLoading
                          ? const SizedBox()
                          : Text(text, style: textStyle),
                      icon: isLoading
                          ? EmCircularLoading(
                          size: 24, color: Colors.amber.shade800)
                          : icon!,
                    ),
                  );
                }
                return ElevatedButton(
                  onPressed: isLoading ? null : onPressed,
                  style: style,
                  child: isLoading
                      ? EmCircularLoading(
                      size: 24, color: Colors.amber.shade800)
                      : Text(text, style: textStyle),
                );
              case TypeButton.outlined:
                return OutlinedButton(
                  onPressed: onPressed,
                  style: style,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(text, style: textStyle),
                      const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black87,),
                    ],
                  )
                );
              default:
                return TextButton(
                  onPressed: isLoading ? null : onPressed,
                  style: style,
                  child: isLoading
                      ? EmCircularLoading(
                      size: 24, color: Colors.amber.shade800)
                      : Text(text, style: textStyle),
                );
            }
          },
        )
    );
  }
}
