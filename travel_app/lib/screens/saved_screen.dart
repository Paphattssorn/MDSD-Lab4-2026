import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../widgets/destination_card.dart';
import '../globals.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    final savedDestinations = sampleDestinations.where((dest) {
      return globalSavedIds.contains(dest.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('บันทึกไว้')),
      body: savedDestinations.isEmpty
              ? _buildEmptyState() 
              : _buildGrid(savedDestinations), 
        );
      }

      Widget _buildEmptyState() {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, size: 64, color: Colors.pink.shade200),
              const SizedBox(height: 16),
              const Text('ยังไม่มีรายการที่บันทึก',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        );
      }

      // หน้าจอตอนมีข้อมูล
      Widget _buildGrid(List<Destination> destinations) {
        return LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount;
            if (constraints.maxWidth < 600) {
              crossAxisCount = 2; // Compact: Phone
            } else if (constraints.maxWidth < 840) {
              crossAxisCount = 3; // Medium: Tablet Portrait
            } else if (constraints.maxWidth < 1200) {
              crossAxisCount = 4; // Expanded: Tablet Landscape / Desktop
            } else {
              crossAxisCount = 5; // Default fallback
            }

            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.72,
              ),
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                final destination = destinations[index];
                
                return DestinationCard(
                  destination: destination,
                  onTap: () {
                    context.pushNamed(
                      'destination-detail',
                      pathParameters: {'id': destination.id},
                      extra: destination,
                    );
                  },
                );
              },
            );
          },
        );
      }
}