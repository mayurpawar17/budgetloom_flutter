import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/bloc/auth_bloc.dart';
import '../../../auth/bloc/auth_event.dart'; // For the Switch style

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // // _buildProfileHeader(),
              // const SizedBox(height: 25),
              // // _buildStatsCards(),
              // const SizedBox(height: 30),
              // _buildSectionHeader("ACCOUNT SETTINGS"),
              // _buildSettingsGroup([
              //   _settingsTile(Icons.person_outline, "Personal Info", trailing: const Icon(Icons.chevron_right, color: Colors.grey)),
              //   _settingsTile(Icons.account_balance_outlined, "Linked Accounts", trailing: const Icon(Icons.chevron_right, color: Colors.grey)),
              //   _settingsTile(Icons.credit_card_outlined, "Subscriptions", trailing: const Icon(Icons.chevron_right, color: Colors.grey)),
              // ]),
              _buildSectionHeader("APP PREFERENCES"),
              _buildSettingsGroup([
                _settingsTile(
                  Icons.notifications_none,
                  "Notifications",
                  trailing: _badge("Enabled", Colors.green),
                ),
                _settingsTile(
                  Icons.dark_mode_outlined,
                  "Dark Mode",
                  trailing: CupertinoSwitch(value: false, onChanged: (v) {}),
                ),
                // _settingsTile(Icons.payments_outlined, "Currency", trailing: const Text("USD (\$)", style: TextStyle(color: Colors.grey))),
              ]),
              _buildSectionHeader("SECURITY"),
              _buildSettingsGroup([
                _settingsTile(
                  Icons.fingerprint,
                  "Face ID / Biometrics",
                  trailing: CupertinoSwitch(
                    value: true,
                    activeTrackColor: const Color(0xFF1A1B70),
                    onChanged: (v) {},
                  ),
                ),
                // _settingsTile(Icons.lock_reset, "Change PIN", trailing: const Icon(Icons.chevron_right, color: Colors.grey)),
              ]),
              const SizedBox(height: 30),
              TextButton.icon(
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutRequested());
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Version 2.4.0 (Build 892)",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/300?u=julian',
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green[700],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "PREMIUM MEMBER",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          "Julian Voss",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1B70),
          ),
        ),
        const Text(
          "julian.voss@sanctuary.io",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        _statCard("POINTS", "3.2k", Icons.stars, Colors.indigo[50]!),
        const SizedBox(width: 15),
        _statCard("TIER", "Gold", Icons.workspace_premium, Colors.green[50]!),
      ],
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Icon(icon, size: 18, color: Colors.black54),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1B70),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 10, left: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2).withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: children),
    );
  }

  Widget _settingsTile(
    IconData icon,
    String title, {
    required Widget trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1A1B70)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: trailing,
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
