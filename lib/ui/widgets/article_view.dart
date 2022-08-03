import 'package:flutter/material.dart';
import 'package:masrimanas_test/data/data.dart';

class ListArticlesView extends StatelessWidget {
  const ListArticlesView({
    super.key,
    required this.item,
  });
  final Article item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text('Artikel ${item.id}'),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Text(
              item.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
