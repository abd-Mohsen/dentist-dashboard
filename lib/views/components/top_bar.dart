import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.openDrawer});
  final void Function() openDrawer;

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return AppBar(
      elevation: 0,
      backgroundColor: cs.surface,
      title: Row(
        children: [
          Visibility(child: Text("dashboard", style: tt.titleMedium!.copyWith(color: cs.onSurface))),
          Expanded(child: Container()),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings, color: cs.onSurface)),
          Badge(
            child: IconButton(
              onPressed: () {
                //
              },
              icon: Icon(Icons.notifications, color: cs.onSurface),
            ),
          )
        ],
      ),
      leading: ResponsiveWidget.isSmall(context)
          ? IconButton(
              onPressed: openDrawer,
              icon: Icon(
                Icons.menu,
                color: cs.onSurface,
              ))
          : Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Icon(
                    Icons.shopping_cart,
                    color: cs.onSurface,
                  ),
                )
              ],
            ),
    );
  }
}
