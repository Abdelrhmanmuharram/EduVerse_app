import 'package:flutter/material.dart';

import 'attendance_screen.dart';
import 'upload_material_bottom_sheet.dart';

class SubjectManagementScreen extends StatelessWidget {
  const SubjectManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: const Icon(Icons.arrow_back_ios, color: Color(0xFF2D60FF), size: 20),
        title: const Text(
          'Subject: Advanced Calculus',
          style: TextStyle(
            color: Color(0xFF1A1C1E),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF74777F)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMaterialsCard(context),

            const SizedBox(height: 16),

            _buildAttendanceCard(context),

            const SizedBox(height: 16),

            _buildStatsRow(),
          ],
        ),
      ),

      bottomNavigationBar: _buildBottomButton(),
    );
  }
  Widget _buildMaterialsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Row(
                children: [
                  Icon(Icons.folder_open, color: Color(0xFF2D60FF)),
                  SizedBox(width: 8),
                  Text("Materials", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
              TextButton(onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  builder: (context) => UploadMaterialSheet(),
                );
              }, child: const Text("+ Upload", style: TextStyle(color: Color(0xFF2D60FF)))),
            ],
          ),
          const Divider(),
          _buildFileItem("Syllabus_2024.pdf", "1.2 MB • Oct 12", Icons.picture_as_pdf, Colors.red[100]!, Colors.red),
          _buildFileItem("Lecture_Notes_W1.pptx", "4.5 MB • Oct 14", Icons.slideshow, Colors.orange[100]!, Colors.orange),
          _buildFileItem("Assignment_guide.docx", "0.8 MB • Oct 15", Icons.description, Colors.blue[100]!, Colors.blue),
        ],
      ),
    );
  }

  // (Attendance History)
  Widget _buildAttendanceCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: ListTile(

        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.people_outline, color: Color(0xFF2D60FF)),
        ),
        title: const Text("View Attendance History", style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("Last entry: Today, 10:30 AM"),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AttendanceScreen()),
          );
        },
      ),
    );
  }

  //   Stats
  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _buildStatCard("TOTAL STUDENTS", "42", Colors.black)),
        const SizedBox(width: 16),
        Expanded(child: _buildStatCard("AVG. ATTENDANCE", "89%", Colors.green)),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: valueColor)),
        ],
      ),
    );
  }

  //  Button
  Widget _buildBottomButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D60FF),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
        label: const Text("Take Attendance", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildFileItem(String name, String info, IconData icon, Color bgIcon, Color iconColor) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: bgIcon, borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text(info, style: const TextStyle(fontSize: 12)),
      trailing: SizedBox(
        width: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.download_for_offline_outlined, color: Colors.grey, size: 20),
            const SizedBox(width: 8),
            const Icon(Icons.delete_outline, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}