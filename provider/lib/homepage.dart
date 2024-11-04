import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:providerr/gender.dart';
import 'package:providerr/nameage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  GenderTeller? _genderData;
  NameAge? _ageData;
  bool _isLoading = false;

  Future<void> fetchAgeData(String name) async {
    if (name.isEmpty) {
      setState(() {
        _ageData = null;
      });
      return;
    }

    final response = await http.get(
      Uri.parse("https://api.agify.io?name=${name.trim().toLowerCase()}"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _ageData = NameAge.fromJson(data);
      });
    } else {
      setState(() {
        _ageData = null;
      });
    }
  }

  Future<void> fetchGenderData(String name) async {
    if (name.isEmpty) {
      setState(() {
        _genderData = null;
      });
      return;
    }

    final response = await http.get(
      Uri.parse("https://api.genderize.io?name=${name.trim().toLowerCase()}"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _genderData = GenderTeller.fromJson(data);
      });
    } else {
      setState(() {
        _genderData = null;
      });
    }
  }

  Future<void> fetchData() async {
    final name = _searchController.text;
    setState(() {
      _isLoading = true;
    });

    await Future.wait([
      fetchGenderData(name),
      fetchAgeData(name),
    ]);

    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildInfoCard({
    required String title,
    required Widget child,
    required Color backgroundColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Name Insights',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF6A5ACD),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Enter a name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                    prefixIcon:
                        const Icon(Icons.person, color: Color(0xFF6A5ACD)),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Color(0xFF6A5ACD),
                      ),
                      onPressed: fetchData,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF6A5ACD),
                      ),
                    )
                  : Column(
                      children: [
                        if (_genderData != null)
                          _buildInfoCard(
                            title: 'Gender Insights',
                            backgroundColor: const Color(0xFF6A5ACD),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetailRow(
                                  'Name',
                                  _genderData!.name ?? 'N/A',
                                ),
                                _buildDetailRow(
                                  'Gender',
                                  _genderData!.gender ?? 'Unknown',
                                ),
                                _buildDetailRow(
                                  'Probability',
                                  '${(double.parse(_genderData!.probability.toString()) * 100).toStringAsFixed(1)}%',
                                ),
                                _buildDetailRow(
                                  'Sample Size',
                                  _genderData!.count.toString(),
                                ),
                              ],
                            ),
                          ),
                        if (_ageData != null)
                          _buildInfoCard(
                            title: 'Age Insights',
                            backgroundColor: const Color(0xFF4169E1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetailRow(
                                  'Name',
                                  _ageData!.name ?? 'N/A',
                                ),
                                _buildDetailRow(
                                  'Estimated Age',
                                  _ageData!.age.toString(),
                                ),
                                _buildDetailRow(
                                  'Sample Size',
                                  _ageData!.count.toString(),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
