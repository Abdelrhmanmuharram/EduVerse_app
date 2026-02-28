import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Attendance",
          style: TextStyle(color: Color(0xFF1A1C1E), fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue.withOpacity(0.2)),
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 18,
                child: Icon(Icons.person_outline,color: Color(0xFF2D60FF), size: 20),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Export as PDF
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.picture_as_pdf_outlined, size: 18),
                label: const Text("Export as PDF", style: TextStyle(fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF2D60FF),
                  side: const BorderSide(color: Color(0xFF2D60FF), width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: const StadiumBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),

            //search
            TextField(
              decoration: InputDecoration(
                hintText: "Search student name or ID...",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // courses latest sectio
            Row(
              children: [
                _buildFilterButton("All Courses", Icons.filter_alt_outlined, true),
                const SizedBox(width: 8),
                _buildFilterButton("Latest", Icons.keyboard_arrow_down, false),
                const SizedBox(width: 8),
                _buildFilterButton("Section", Icons.keyboard_arrow_down, false),
              ],
            ),
            const SizedBox(height: 20),

            // large white card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                children: [
                  // card head
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("RECENT RECORDS",
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1)),
                        const Text("245 entries",
                            style: TextStyle(fontSize: 11, color: Color(0xFF2D60FF), fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                  // titles
                  _buildTableHeaders(),
                  const Divider(height: 1),


                  _buildStudentRow("CS101", "Alex Rivera", "ID: 2024-0012", "Oct 24, 09:00", "Data Structure"),
                  _buildStudentRow("MA201", "Sarah Chen", "ID: 2024-0458", "Oct 24, 10:30", "Calculus II"),
                  _buildStudentRow("PH105", "Jordan Smith", "ID: 2024-1102", "Oct 24, 11:45", "Thermodynamic"),
                  _buildStudentRow("CS101", "Elena Petrova", "ID: 2024-0891", "Oct 23, 14:15", "Data Structure"),
                  _buildStudentRow("EN101", "Marcus Johnson", "ID: 2024-0321", "Oct 23, 16:00", "Composition"),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPageNavButton(Icons.arrow_back_ios),
                        const SizedBox(width: 16),
                        const Text("Page 1 of 12", style: TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(width: 16),
                        _buildPageNavButton(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //  (Bottom Nav)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2D60FF),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in), label: "Attendance"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), label: "Schedule"),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: "Settings"),
        ],
      ),
    );
  }


  Widget _buildTableHeaders() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text("CODE", style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text("NAME", style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text("DATE", style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text("LECTURE", style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }


  Widget _buildStudentRow(String code, String name, String id, String date, String lecture) {
    return Column(
      children: [
        const Divider(height: 1, color: Color(0xFFF1F4F9)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Row(
            children: [
              Expanded(flex: 2, child: Text(code, style: const TextStyle(color: Color(0xFF2D60FF), fontWeight: FontWeight.bold, fontSize: 12))),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1A1C1E))),
                    Text(id, style: const TextStyle(fontSize: 9, color: Colors.grey)),
                  ],
                ),
              ),
              Expanded(flex: 3, child: Text(date, style: const TextStyle(fontSize: 11, color: Color(0xFF44474E)))),
              Expanded(flex: 3, child: Text(lecture, style: const TextStyle(fontSize: 11, color: Color(0xFF44474E)))),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildFilterButton(String label, IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2D60FF) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? const Color(0xFF2D60FF) : const Color(0xFFE1E4E8)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: isSelected ? Colors.white : const Color(0xFF44474E)),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF44474E), fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  //
  Widget _buildPageNavButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFF8F9FD),
        border: Border.all(color: const Color(0xFFE1E4E8)),
      ),
      child: Icon(icon, size: 12, color: Colors.grey),
    );
  }
}