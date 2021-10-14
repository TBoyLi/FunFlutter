import 'package:fun_flutter/app/model/article.dart';
import 'package:fun_flutter/app/model/banner.dart';
import 'package:fun_flutter/app/model/coin_record.dart';
import 'package:fun_flutter/app/model/navigation_site.dart';
import 'package:fun_flutter/app/model/search.dart';
import 'package:fun_flutter/app/model/site.dart';
import 'package:fun_flutter/app/model/tree.dart';
import 'package:fun_flutter/app/model/user.dart';
import 'package:fun_flutter/app/net/http/http_manager.dart';

class WanApi {
  // 轮播
  static Future fetchBanners() async {
    var response = await HttpManager.instance.get('banner/json');
    return response.data
        .map<Banner?>((item) => Banner.fromJson(item))
        .toList();
  }

  // 置顶文章
  static Future fetchTopArticles() async {
    var response = await HttpManager.instance.get('article/top/json');
    return response.data
        .map<Article?>((item) => Article.fromJson(item))
        .toList();
  }

  // 文章
  static Future fetchArticles(int pageNum, {int? cid}) async {
    // await Future.delayed(const Duration(seconds: 1)); //增加动效
    var response = await HttpManager.instance.get('article/list/$pageNum/json',
        params: (cid != null ? {'cid': cid} : null));
    return response.data['datas']
        .map<Article?>((item) => Article.fromJson(item))
        .toList();
  }

  // 问答
  static Future fetchQuestions(int pageNum) async {
    var response = await HttpManager.instance.get('wenda/list/$pageNum/json');
    return response.data['datas']
        .map<Article?>((item) => Article.fromJson(item))
        .toList();
  }

  //广场
  static Future fetchSquares(int pageNum) async {
    var response =
        await HttpManager.instance.get('user_article/list/$pageNum/json');
    return response.data['datas']
        .map<Article?>((item) => Article.fromJson(item))
        .toList();
  }

  // 体系分类
  static Future fetchTreeCategories() async {
    var response = await HttpManager.instance.get('tree/json');
    return response.data.map<Tree>((item) => Tree.fromJson(item)).toList();
  }

  // 项目分类
  static Future fetchProjectCategories() async {
    var response = await HttpManager.instance.get('project/tree/json');
    return response.data.map<Tree>((item) => Tree.fromJson(item)).toList();
  }

  // 导航
  static Future fetchNavigationSite() async {
    var response = await HttpManager.instance.get('navi/json');
    return response.data
        .map<NavigationSite>((item) => NavigationSite.fromJson(item))
        .toList();
  }

  // 公众号分类
  static Future fetchWechatAccounts() async {
    var response = await HttpManager.instance.get('wxarticle/chapters/json');
    return response.data.map<Tree>((item) => Tree.fromJson(item)).toList();
  }

  // 公众号文章
  static Future fetchWechatAccountArticles(int pageNum, int id) async {
    var response =
        await HttpManager.instance.get('wxarticle/list/$id/$pageNum/json');
    return response.data['datas']
        .map<Article?>((item) => Article.fromJson(item))
        .toList();
  }

  // 搜索热门记录
  static Future fetchSearchHotKey() async {
    var response = await HttpManager.instance.get('hotkey/json');
    return response.data
        .map<SearchHotKey>((item) => SearchHotKey.fromJson(item))
        .toList();
  }

  // 搜索结果
  static Future fetchSearchResult({key = "", int pageNum = 0}) async {
    var response =
        await HttpManager.instance.post('article/query/$pageNum/json', params: {
      'k': key,
    });
    return response.data?['datas']
        .map<Article?>((item) => Article.fromJson(item))
        .toList();
  }

  /// 登录
  /// [HttpManager.instance._init] 添加了拦截器 设置了自动cookie.
  static Future login(String username, String password) async {
    var response = await HttpManager.instance.post('user/login', params: {
      'username': username,
      'password': password,
    });
    return User.fromJson(response.data);
  }

  /// 注册
  static Future register(
      String username, String password, String rePassword) async {
    var response = await HttpManager.instance.post('user/register', params: {
      'username': username,
      'password': password,
      'repassword': rePassword,
    });
    return User.fromJson(response.data);
  }

  /// 登出
  static logout() async {
    /// 自动移除cookie
    await HttpManager.instance.get('user/logout/json');
  }

  static testLoginState() async {
    await HttpManager.instance.get('lg/todo/listnotdo/0/json/1');
  }

  // 收藏文章列表
  static Future fetchCollectList(int pageNum) async {
    var response =
        await HttpManager.instance.get('lg/collect/list/$pageNum/json');
    return response.data['datas']
        .map<Article?>((item) => Article.fromJson(item))
        .toList();
  }

  //收藏网站列表
  static Future fetchCollectSiteList() async {
    var response =
        await HttpManager.instance.get('lg/collect/usertools/json');
    return response.data
        .map<Site?>((item) => Site.fromJson(item))
        .toList();
  }

  // 收藏文章
  static collect(id) async {
    await HttpManager.instance.post('lg/collect/$id/json');
  }

  // 取消收藏文章
  static unCollect(id) async {
    await HttpManager.instance.post('lg/uncollect_originId/$id/json');
  }

  // 取消收藏2
  static unMyCollect({id, originId}) async {
    await HttpManager.instance
        .post('lg/uncollect/$id/json', params: {'originId': originId ?? -1});
  }

  // 个人积分
  static Future fetchCoin() async {
    var response = await HttpManager.instance.get('lg/coin/getcount/json');
    return response.data;
  }

  // 我的积分记录
  static Future fetchCoinRecordList(int pageNum) async {
    var response = await HttpManager.instance.get('lg/coin/list/$pageNum/json');
    return response.data['datas']
        .map<CoinRecord>((item) => CoinRecord.fromJson(item))
        .toList();
  }

  // 积分排行榜
  /// {
  ///        "coinCount": 448,
  ///        "username": "S**24n"
  ///      },
  static Future fetchRankingList(int pageNum) async {
    var response = await HttpManager.instance.get('coin/rank/$pageNum/json');
    return response.data['datas'];
  }
}
