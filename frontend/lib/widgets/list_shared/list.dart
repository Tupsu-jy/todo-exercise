import 'package:flutter/material.dart';
import 'list_item.dart';

class ReorderableListWidget<T> extends StatelessWidget {
  final List<T> items;
  final String Function(T) getTitle;
  final String Function(T) getId;
  final Function(int, int) onReorder;
  final Function(T) onDelete;
  final Function(T) onEdit;
  final Widget? Function(T)? buildLeading; // Optional, for todo checkbox
  final Function(T)? onTap; // Optional, for notepad navigation
  final Function() onAdd;

  const ReorderableListWidget({
    required this.items,
    required this.getTitle,
    required this.getId,
    required this.onReorder,
    required this.onDelete,
    required this.onEdit,
    required this.onAdd,
    this.buildLeading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: ReorderableListView.builder(
            buildDefaultDragHandles: false,
            itemCount: items.length,
            onReorder: onReorder,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListItem(
                key: Key(getId(item)),
                id: getId(item),
                title: getTitle(item),
                index: index,
                onDelete: () => onDelete(item),
                onEdit: () => onEdit(item),
                leading: buildLeading?.call(item),
                onTap: onTap != null ? () => onTap!(item) : null,
              );
            },
          ),
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            onPressed: onAdd,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
