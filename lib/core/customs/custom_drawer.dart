import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF8B1818),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFF8B1818).withOpacity(0.9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/salon_logo.png'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Mall Beauty Salon',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'salon.beautymall.com',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.add_box, 'Add Products'),
            _buildDrawerItem(Icons.shopping_bag, 'Shop'),
            _buildDrawerItem(Icons.people, 'Staff Management'),
            _buildDrawerItem(Icons.assessment, 'Reports'),
            _buildDrawerItem(Icons.card_membership, 'Subscription'),
            _buildDrawerItem(Icons.help, 'Help & Support'),
            _buildDrawerItem(Icons.logout, 'Sign Out'),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {},
    );
  }
}
