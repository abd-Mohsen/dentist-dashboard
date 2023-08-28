import 'package:flutter/material.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: cs.primary,
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                ListTile(
                  mouseCursor: MouseCursor.defer,
                  leading: Icon(Icons.home_filled, color: cs.onPrimary),
                  title: Text("Home", style: tt.titleMedium!.copyWith(color: cs.onPrimary)),
                  tileColor: Colors.transparent,
                ),
                ListTile(
                  mouseCursor: MouseCursor.defer,
                  leading: Icon(Icons.phone_android, color: cs.onPrimary),
                  title: Text("control app", style: tt.titleMedium!.copyWith(color: cs.onPrimary)),
                  tileColor: Colors.transparent,
                ),
                ListTile(
                  mouseCursor: MouseCursor.defer,
                  leading: Icon(Icons.analytics, color: cs.onPrimary),
                  title: Text("analytics", style: tt.titleMedium!.copyWith(color: cs.onPrimary)),
                  tileColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(color: cs.background),
        ),
      ],
    );
  }
}
