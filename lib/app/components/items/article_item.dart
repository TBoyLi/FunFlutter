import 'package:fun_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fun_flutter/app/model/article.dart';
import 'package:quiver/strings.dart';

import '../article_tag.dart';
import '../wrapper_image.dart';

class ArticleItemWidget extends StatelessWidget {
  const ArticleItemWidget({
    Key? key,
    required this.article,
    this.top = false,
    this.onTap,
  }) : super(key: key);

  final bool top;
  final Article? article;

  final Function(Article article)? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        Routes.ARTICLE_DETAIL,
        arguments: {
          'article': article,
        },
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, width: 0.5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                ClipOval(
                  child: WrapperImage(
                    imageType: ImageType.random,
                    url: article?.author ?? '',
                    height: 20,
                    width: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    isNotBlank(article?.author)
                        ? article?.author ?? ''
                        : article?.shareUser ?? '',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                const Expanded(
                  child: SizedBox.shrink(),
                ),
                Text(
                  article?.niceDate ?? '',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            if ((article?.envelopePic ?? '').isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: ArticleTitleWidget(article?.title ?? ''),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ArticleTitleWidget(article?.title ?? ''),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          article?.desc ?? '',
                          style: Theme.of(context).textTheme.caption,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  WrapperImage(
                    url: article?.envelopePic ?? '',
                    height: 60,
                    width: 60,
                  ),
                ],
              ),
            Row(
              children: <Widget>[
                if (top) ArticleTag('article_tag_top'.tr),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    (article?.superChapterName != null
                            ? (article?.superChapterName ?? '') + ' · '
                            : '') +
                        (article?.chapterName ?? ''),
                    style: Theme.of(context).textTheme.overline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleTitleWidget extends StatelessWidget {
  final String title;

  const ArticleTitleWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: title,
    );
  }
}
