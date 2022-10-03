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
        Row(
          children: [
            if (type == ListDetailType.chip)
              CustomChip(text: subtitle, color: color!),
            if (type == ListDetailType.circle) ...[
              CustomCircleNickname(name: subtitle),
              const SizedBox(width: 8),
            ],
            if (type == ListDetailType.text || type == ListDetailType.circle)
              Column(
                children: [
                  Text(
                    subtitle,
                    style: regularTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  if (description != null)
                    Text(
                      description!,
                      style: regularTextStyle.copyWith(
                        color: fontDescriptionGreyColor,
                        fontSize: 16,
                      ),
                    ),
                ],
              )
          ],
        )
      ],
    );
  }
}
