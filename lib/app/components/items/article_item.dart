import 'package:flutter/cupertino.dart';
import 'package:fun_flutter/app/components/state_pages.dart';
import 'package:fun_flutter/app/modules/controllers/favorite_controller.dart';
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
    this.hideFavourite = false,
  }) : super(key: key);

  final bool top;
  final Article? article;

  /// 隐藏收藏按钮
  final bool hideFavourite;

  final Function(Article article)? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => Get.toNamed(
            Routes.ARTICLE_DETAIL,
            arguments: {
              'article': article,
            },
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            margin: const EdgeInsets.symmetric(horizontal: 15),
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
                    child: ArticleTitleWidget(title: article?.title ?? ''),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ArticleTitleWidget(title: article?.title ?? ''),
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
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: hideFavourite
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(right: 15, bottom: 10),
                  child: FavoriteWidget(
                      key: ValueKey(article?.id ?? 0), article: article!),
                ),
        )
      ],
    );
  }
}

class ArticleTitleWidget extends StatelessWidget {
  final String title;

  const ArticleTitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: title,
    );
  }
}

class FavoriteWidget extends GetView<FavoriteController> {
  const FavoriteWidget({Key? key, required this.article}) : super(key: key);

  final Article? article;

  @override
  Widget build(BuildContext context) {
    final FavoriteController controller =
        Get.put(FavoriteController(), tag: '${article?.id ?? 0}');
    final themeColor = Theme.of(context).primaryColor;
    return GetBuilder<FavoriteController>(
      tag: '${article?.id ?? 0}',
      id: article?.id ?? 0,
      init: controller,
      initState: (_) => controller.refreshCollect(
          article?.collect ?? false, article?.id ?? 0),
      builder: (_) => ScaleAnimatedSwitcher(
        child: controller.loadState == LoadState.kLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CupertinoActivityIndicator(radius: 5),
              )
            : GestureDetector(
                child: Icon(
                  controller.isCollect ? Icons.favorite : Icons.favorite_border,
                  color: themeColor.withOpacity(0.8),
                  size: 22,
                ),
                onTap: () {
                  bool collect = controller.isCollect;
                  controller.collect(collect ? true : false, article?.id ?? 0);
                },
              ),
      ),
    );
  }
}

class ScaleAnimatedSwitcher extends StatelessWidget {
  final Widget child;

  const ScaleAnimatedSwitcher({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: child,
    );
  }
}
