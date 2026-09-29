import 'package:flutter/material.dart';

import '../models/announcement.dart';
import '../services/announcement_api.dart';
import '../widgets/announcement_card.dart';
import 'announcement_detail_screen.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({super.key, this.api});

  /// Dapat disuntikkan dari luar (widget test atau demo offline).
  final AnnouncementApi? api;

  @override
  State<AnnouncementListScreen> createState() =>
      _AnnouncementListScreenState();
}

class _AnnouncementListScreenState
    extends State<AnnouncementListScreen> {
  static const List<String> _kategori = <String>[
    'Semua',
    'Akademik',
    'Beasiswa',
    'Kegiatan',
    'Prestasi',
  ];

  late final AnnouncementApi _api =
      widget.api ?? AnnouncementApi();

  late Future<List<Announcement>> _futurePengumuman;

  String _kategoriTerpilih = 'Semua';

  @override
  void initState() {
    super.initState();
    _futurePengumuman = _api.ambilPengumuman();
  }

  @override
  void dispose() {
    _api.tutup();
    super.dispose();
  }

  Future<void> _muatUlang() async {
    final Future<List<Announcement>> futureBaru =
        _api.ambilPengumuman();

    setState(() {
      _futurePengumuman = futureBaru;
    });

    try {
      await futureBaru;
    } catch (_) {
      // Error ditangani oleh FutureBuilder.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal Pengumuman TRPL'),
        actions: <Widget>[
          IconButton(
            onPressed: _muatUlang,
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat ulang',
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 56,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: _kategori.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final String kategori = _kategori[index];

                return ChoiceChip(
                  label: Text(kategori),
                  selected: _kategoriTerpilih == kategori,
                  onSelected: (_) {
                    setState(() {
                      _kategoriTerpilih = kategori;
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _muatUlang,
              child: FutureBuilder<List<Announcement>>(
                future: _futurePengumuman,
                builder: (context, snapshot) {
                  // Keadaan 1: LOADING
                  if (snapshot.connectionState !=
                      ConnectionState.done) {
                    return _buildMemuat();
                  }

                  // Keadaan 2: ERROR
                  if (snapshot.hasError) {
                    return _buildGagal(snapshot.error!);
                  }

                  // Keadaan 3 & 4: KOSONG / BERHASIL
                  final List<Announcement> semua =
                      snapshot.data ??
                          const <Announcement>[];

                  final List<Announcement> tampil =
                      _kategoriTerpilih == 'Semua'
                          ? semua
                          : semua
                              .where(
                                (Announcement item) =>
                                    item.category
                                        .toLowerCase() ==
                                    _kategoriTerpilih
                                        .toLowerCase(),
                              )
                              .toList(growable: false);

                  if (tampil.isEmpty) {
                    return _buildKosong();
                  }

                  return _buildDaftar(tampil);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemuat() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Memuat pengumuman...'),
        ],
      ),
    );
  }

  Widget _buildGagal(Object error) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        SizedBox(
          height: 400,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.cloud_off,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Gagal memuat pengumuman',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _muatUlang,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKosong() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: const <Widget>[
        SizedBox(
          height: 400,
          child: Center(
            child: Text(
              'Tidak ada pengumuman pada kategori ini.',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDaftar(List<Announcement> data) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final Announcement announcement = data[index];

        return AnnouncementCard(
          announcement: announcement,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => AnnouncementDetailScreen(
                  announcement: announcement,
                ),
              ),
            );
          },
        );
      },
    );
  }
}