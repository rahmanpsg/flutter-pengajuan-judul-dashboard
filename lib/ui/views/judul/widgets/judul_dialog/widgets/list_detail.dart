import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/enums/list_detail_type.dart';
import 'package:pengajuan_judul_dashboard/app/themes/app_colors.dart';
import 'package:pengajuan_judul_dashboard/app/themes/app_text.dart';
import 'package:pengajuan_judul_dashboard/ui/widgets/custom_chip.dart';
import 'package:pengajuan_judul_dashboard/ui/widgets/custom_circle_nickname.dart';

class ListDetail extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? description;
  final Color? color;
  final ListDetailType type;

  const ListDetail({
    Key? key,
    required this.title,
    required this.subtitle,
    this.description,
    this.color = mainColor,
    this.type = ListDetailType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: regularTextStyle.copyWith(
            fontSize: 16,
            color: fontTitleGreyColor,
          ),
        ),
        const SizedBox(height: 8),
        ListTile(
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 0,
          dense: true,
          leading: type.isText
              ? null
              : type.isChip
                  ? IntrinsicWidth(
                      child: CustomChip(text: subtitle, color: color!))
                  : CustomCircleNickname(name: subtitle),
          title: type.isChip
              ? null
              : Text(
                  subtitle,
                  style: regularTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
          subtitle: description == null
              ? null
              : Text(
                  description!,
                  style: regularTextStyle.copyWith(
                    color: fontDescriptionGreyColor,
                    fontSize: 16,
                  ),
                ),
        ),
      ],
    );
  }
}
