import 'dart:ui' as BorderType;

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class UploadMaterialSheet extends StatelessWidget {
  const UploadMaterialSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Upload Material",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A1C1E))),
              IconButton(onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 20),

          // Material Name
          const Text("MATERIAL NAME",
              style: TextStyle(fontSize: 11, color: Color(0xFF74777F), fontWeight: FontWeight.bold, letterSpacing: 1.1)),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: "e.g. Midterm Study Guide",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              filled: true,
              fillColor: const Color(0xFFF8F9FD),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 20),
          const Text("SELECT FILE",
              style: TextStyle(fontSize: 11, color: Color(0xFF74777F), fontWeight: FontWeight.bold, letterSpacing: 1.1)),
          const SizedBox(height: 8),
          DottedBorder(
            options: RoundedRectDottedBorderOptions(
              color: const Color(0xFFD1D9E8),
              strokeWidth: 1,
              dashPattern: const [6, 3],
              radius: const Radius.circular(16),
            ),

            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.cloud_upload, size: 28, color: Color(0xFF2D60FF)),
                  ),
                  const SizedBox(height: 12),
                  const Text("Tap to choose a file",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1C1E), fontSize: 14)),
                  const SizedBox(height: 4),
                  const Text("PDF, DOCX, PPT or ZIP up to 25MB",
                      style: TextStyle(fontSize: 11, color: Color(0xFF74777F))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // *** (Rounded) ***
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F4F9),
                    elevation: 0,
                    foregroundColor: const Color(0xFF44474E),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D60FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("Upload Material", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}