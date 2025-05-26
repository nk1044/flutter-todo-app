import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final int index;
  final String title;
  final bool ischecked;
  final VoidCallback onTap;
  final ValueChanged<bool?>? onCheckboxChanged;
  final void Function(int)? onDelete;

  const ListCard({
    super.key,
    required this.index,
    required this.title,
    required this.ischecked,
    required this.onTap,
    required this.onCheckboxChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.amber[100], // surface color for cards
      elevation: 4,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          value: ischecked,
          onChanged: onCheckboxChanged,
          activeColor: theme.colorScheme.primary, // nicer accent color
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          splashRadius: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            decoration: ischecked ? TextDecoration.lineThrough : null,
            color: ischecked
                ? theme.disabledColor
                : theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: theme.colorScheme.error),
          onPressed: () => onDelete?.call(index),
          tooltip: 'Delete item',
          splashRadius: 24,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        horizontalTitleGap: 12,
      ),
    );
  }
}
