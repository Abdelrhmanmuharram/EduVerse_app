import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MaterialItemCard extends StatelessWidget {
  final dynamic material;

  const MaterialItemCard({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.picture_as_pdf, color: Colors.red),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(material["name"]),
                Text(
                  material["info"],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),


          SvgPicture.asset("assets/icons/download_icon.svg"),
          const SizedBox(width: 10),
          SvgPicture.asset("assets/icons/delete_icon.svg"),
        ],
      ),
    );
  }
}