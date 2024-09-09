import 'package:challenge/core/theme/app_theme.dart';
import 'package:challenge/core/utils/images.dart';
import 'package:flutter/material.dart';

class ArticleListContainer extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl;

  const ArticleListContainer({
    super.key,
    required this.title,
    required this.description,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageUrl!.isEmpty
                  ? Image.asset(Images.emptyArticleImage)
                  : Image.network(imageUrl!, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.articleTitleStyle,
                  ),
                  Text(
                    description,
                    style: AppTheme.articleDescriptionStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
