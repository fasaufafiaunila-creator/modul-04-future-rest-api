import 'package:flutter/material.dart';

// Model data sesi / ruangan praktikum
class LabSession {
  final String title;
  final String time;
  final String location;
  final String badgeText;
  final Color badgeColor;
  final Color badgeTextColor;
  final IconData noteIcon;
  final String noteText;
  final Color noteBgColor;
  final Color noteIconColor;

  const LabSession({
    required this.title,
    required this.time,
    required this.location,
    required this.badgeText,
    required this.badgeColor,
    required this.badgeTextColor,
    required this.noteIcon,
    required this.noteText,
    required this.noteBgColor,
    required this.noteIconColor,
  });

  static List<LabSession> getSampleData() {
    return const [
      LabSession(
        title: 'Mobile Programming',
        time: '08.00 - 10.00',
        location: 'Lab 1',
        badgeText: 'Berlangsung',
        badgeColor: Color(0xFF0284C7),
        badgeTextColor: Colors.white,
        noteIcon: Icons.people,
        noteText: 'Sedang digunakan oleh praktikan',
        noteBgColor: Color(0xFFE0F2FE),
        noteIconColor: Color(0xFF0284C7),
      ),
      LabSession(
        title: 'Rekayasa Perangkat Lunak',
        time: '10.00 - 12.00',
        location: 'Lab 2',
        badgeText: 'Akan datang',
        badgeColor: Color(0xFFFED7AA),
        badgeTextColor: Color(0xFF9A3412),
        noteIcon: Icons.access_time,
        noteText: 'Sesi akan dimulai sebentar lagi',
        noteBgColor: Color(0xFFFEF3C7),
        noteIconColor: Color(0xFFD97706),
      ),
      LabSession(
        title: 'Basis Data',
        time: '13.00 - 15.00',
        location: 'Lab 3',
        badgeText: 'Selesai',
        badgeColor: Color(0xFFE2E8F0),
        badgeTextColor: Color(0xFF64748B),
        noteIcon: Icons.check_circle,
        noteText: 'Sesi telah selesai',
        noteBgColor: Color(0xFFF1F5F9),
        noteIconColor: Color(0xFF64748B),
      ),
      LabSession(
        title: 'Lab 2',
        time: 'Ruang tersedia di luar jadwal sesi',
        location: '',
        badgeText: 'Tersedia',
        badgeColor: Color(0xFF15803D),
        badgeTextColor: Colors.white,
        noteIcon: Icons.meeting_room,
        noteText: 'Siap digunakan untuk praktikum lain',
        noteBgColor: Color(0xFFDCFCE7),
        noteIconColor: Color(0xFF15803D),
      ),
    ];
  }
}

class RuangPraktikumScreen extends StatelessWidget {
  const RuangPraktikumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = LabSession.getSampleData();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 960),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ruang Praktikum Hari Ini',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 14),

                      Row(
                        children: [
                          _buildHeaderPill(
                            icon: Icons.calendar_month_outlined,
                            label: '3 sesi',
                            bgColor: const Color(0xFFE0F2FE),
                            textColor: const Color(0xFF0284C7),
                          ),
                          const SizedBox(width: 10),
                          _buildHeaderPill(
                            icon: Icons.meeting_room_outlined,
                            label: '1 ruang tersedia',
                            bgColor: const Color(0xFFDCFCE7),
                            textColor: const Color(0xFF15803D),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Expanded(
                        child: isTablet
                            ? GridView.builder(
                                physics:
                                    const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      childAspectRatio: 1.55,
                                    ),
                                itemCount: sessions.length,
                                itemBuilder: (context, index) {
                                  return _buildSessionCard(
                                    sessions[index],
                                  );
                                },
                              )
                            : Column(
                                children: sessions.map((session) {
                                  return Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 14),
                                      child: _buildSessionCard(session),
                                    ),
                                  );
                                }).toList(),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Widget Header Status Pill
  Widget _buildHeaderPill({
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: textColor,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  // Widget Kartu Ruangan / Sesi
  Widget _buildSessionCard(LabSession session) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Baris 1: Judul dan Badge Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  session.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: session.badgeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  session.badgeText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: session.badgeTextColor,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Baris 2: Waktu
          Row(
            children: [
              Icon(
                session.location.isEmpty
                    ? Icons.meeting_room_outlined
                    : Icons.access_time,
                size: 15,
                color: const Color(0xFF64748B),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  session.time,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),

          // Baris 3: Lokasi Ruangan
          if (session.location.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 15,
                  color: Color(0xFF64748B),
                ),
                const SizedBox(width: 6),
                Text(
                  session.location,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 12),

          // Baris 4: Kotak Catatan Keterangan
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: session.noteBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  session.noteIcon,
                  size: 16,
                  color: session.noteIconColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    session.noteText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: session.noteIconColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}