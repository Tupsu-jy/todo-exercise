import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String id;
  final String title;
  final int index;
  final Function() onDelete;
  final Function() onEdit;
  final Widget? leading; // Optional, for todo checkbox
  final Function()? onTap; // Optional, for notepad navigation

  const ListItem({
    super.key,
    required this.id,
    required this.title,
    required this.index,
    required this.onDelete,
    required this.onEdit,
    this.leading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) => onDelete(),
      child: ListTile(
        key: Key('tile-$id'),
        leading: leading,
        title: Text(title),
        onTap: onTap,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
            ReorderableDragStartListener(
              index: index,
              child: const Icon(Icons.drag_handle),
            ),
          ],
        ),
      ),
    );
  }
}
