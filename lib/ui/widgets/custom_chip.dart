import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/app/themes/app_text.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final Color color;
  final Color? textColor;
  final double maxWidth;

  const CustomChip({
    super.key,
    required this.text,
    required this.color,
    this.textColor,
    this.maxWidth = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(
              color: color,
              width: 1,
            ),
            // color: color,
          ),
          padding: const EdgeInsets.all(8),
          child: Text(
            text,
            style: regularTextStyle.copyWith(color: textColor ?? color),
          ),
        ),
      ),
    );
  }
}
