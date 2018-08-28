import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/index/IndexPageBannerBean.dart';
import 'package:flutter_app/index/IndexPageBean.dart';
import 'package:flutter_app/utils/BannerView.dart';

class IndexPage extends StatefulWidget {
  ScrollController controller;

  @override
  createState() => new IndexPageState();

  IndexPage({Key key, this.controller}) : super(key: key);
}

class IndexPageState extends State<IndexPage>
    with AutomaticKeepAliveClientMixin {
  List<BannerChildBean> mResult = [];
  List<IndexPageChildrenBean> mPageData = [];
  int currentPage = 0;

  String bannerTitle = "ssss";

  @override
  bool get wantKeepAlive => true;

  getBanner() async {
    var url = 'http://www.wanandroid.com/banner/json';
    var httpClient = new HttpClient();

    List<BannerChildBean> result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        result = new IndexPageBannerBean.fromJson(JSON.decode(json)).data;
      } else {
        result = null;
      }
      request.close();
    } catch (exception) {
      result = null;
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {
      mResult = result;
      bannerTitle = result[0].title;
    });
  }

  getHomePageData() async {
    var url = 'http://www.wanandroid.com/article/list/$currentPage/json';
    var httpClient = new HttpClient();

    IndexPageBean pageBean;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        var data = JSON.decode(json)['data'];
        print('$data');
        pageBean = new IndexPageBean.fromJson(data);
      } else {
        pageBean = null;
      }
      request.close();
    } catch (exception) {
      print(exception);
      pageBean = null;
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {
      mPageData.addAll(pageBean.datas);
      currentPage = pageBean.curPage;
      print('${mPageData.length}');
    });
  }

  @override
  void initState() {
    super.initState();
    getBanner();
    getHomePageData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              BannerView(
                data: mResult == null ? [] : mResult,
                onPageChanged: onPageChanged,
                buildShowView: (index, itemData) {
                  return new FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: ExactAssetImage("images/image.png"),
                      image: NetworkImage(mResult[index].imagePath));
                },
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                decoration: BoxDecoration(color: Colors.black38),
                child: Text(
                  bannerTitle,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          ListView.builder(
            shrinkWrap: true, //解决无法显示问题
            physics:new NeverScrollableScrollPhysics(), //解决滑动冲突
            itemBuilder: (buildContext, index) {
              return Container(
                height: 100.0,
                margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(const Radius.circular(5.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            mPageData[index].author,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Text(
                          mPageData[index].niceDate,
                          style: TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          mPageData[index].title,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            mPageData[index].chapterName,
                            style: TextStyle(
                                fontSize: 10.0, color: Colors.pinkAccent),
                          ),
                        ),
                        new Image.asset(
                          "images/icon_collution.png",
                          height: 24.0,
                          width: 24.0,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            itemCount: mPageData.length,
          ),
        ],
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      if (mResult != null && mResult.length > index) {
        this.bannerTitle = mResult[index].title;
      }
    });
  }
}
