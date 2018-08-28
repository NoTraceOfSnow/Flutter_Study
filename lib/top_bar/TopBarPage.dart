import 'package:flutter/material.dart';
import 'package:flutter_app/top_bar/StateStyle.dart';
import 'package:flutter_app/top_bar/ToolUtils.dart';

typedef VoidCallback OnTopViewClickListener(int index);

class TopBarPage extends StatefulWidget {
  TopBarPage(
      {Key key,
      this.title = "",
      this.stateBar = StateStyle.STATUS_BAR,
      this.child,
      this.topDiver,
      this.topBgColor,
      this.topText,
      this.topCustomStateBar,
      this.leftBtnGone = false,
      this.rightBtnGone = false,
      this.centerTextGone = false,
      this.leftBtnImgAssets = 'images/icon_black_arrow.png',
      this.rightBtnImgAssets = 'images/icon_black_share.png',
      this.clickListener,
      this.needKeep = false,
      this.mTopBgBoxDecoration})
      : super(key: key);

  //标题栏
  final String title;

  //顶部状态栏
  final StateStyle stateBar;

  //内容页面
  final Widget child;

  //顶部线条颜色
  final Color topDiver;

  //顶部状态栏颜色
  final Color topBgColor;

  //顶部自定义文字(自定义)
  final Text topText;

  //顶部自定义状态栏
  final Widget topCustomStateBar;

  //导航栏左边按钮是否可见
  final bool leftBtnGone;

  //导航栏右边按钮是否可见
  final bool rightBtnGone;

  //导航栏中间文字是否可见
  final bool centerTextGone;

  //左边图片路径
  final String leftBtnImgAssets;

  //右边图片路径
  final String rightBtnImgAssets;

  //顶部背景装饰
  final BoxDecoration mTopBgBoxDecoration;

  //顶部点击事件
  final OnTopViewClickListener clickListener;

  //是否需要保存状态
  final bool needKeep;

  @override
  createState() => new TopBarPageState();
}

class TopBarPageState extends State<TopBarPage>
    with AutomaticKeepAliveClientMixin {
  String getTitle() {
    if (widget.title.length > 8) {
      return widget.title.substring(0, 8);
    } else {
      return widget.title;
    }
  }

  //顶部状态栏样式
  BoxDecoration getTopBgBoxDecoration() {
    if (widget.mTopBgBoxDecoration != null) {
      return widget.mTopBgBoxDecoration;
    }
    if (widget.topBgColor != null) {
      return BoxDecoration(
        color: widget.topBgColor,
      );
    }
    if (widget.stateBar == StateStyle.STATUS_BAR_TRANSPARENT) {
      return BoxDecoration(
          gradient: new LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [Colors.black54, Colors.transparent]));
    } else if (widget.stateBar == StateStyle.NO_STATUS_BAR) {
      return BoxDecoration(color: Colors.white);
    } else {
      return BoxDecoration(color: Colors.white);
    }
  }

  BoxDecoration getBgBoxChangeDecoration() {
    return BoxDecoration(
        gradient: new LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [Colors.black54, Colors.transparent]));
  }

  //获取顶部分割线颜色
  Color getTopDiverColor() {
    if (widget.topBgColor != null) {
      return widget.topBgColor;
    }
    if (widget.stateBar == StateStyle.STATUS_BAR_TRANSPARENT) {
      return Colors.transparent;
    } else if (widget.stateBar == StateStyle.NO_STATUS_BAR) {
      return Colors.transparent;
    } else {
      return Colors.grey;
    }
  }

  //获取内容页面
  Widget getContainerWidget() {
    if (widget.child == null) {
      return Text('空view');
    } else {
      return widget.child;
    }
  }

  //状态栏样式,默认样式为STATUS_BAR
  Widget getParentWeight() {
    if (widget.stateBar == StateStyle.STATUS_BAR_TRANSPARENT) {
      return getTransStateBar();
    } else if (widget.stateBar == StateStyle.NO_STATUS_BAR) {
      return getNoStateBar();
    } else {
      return getDefaultStateBar();
    }
  }

  //获取顶部文本view
  Text getTopTextView() {
    if (widget.topText != null) {
      return widget.topText;
    }
    return Text(
      getTitle(),
      softWrap: false,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 17.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getParentWeight();
  }

  bool getBgChangeVisible() {
    return widget.stateBar == StateStyle.STATUS_BAR_TRANSPARENT;
  }

  //顶部导航栏View
  Widget getTopView() {
    if (widget.topCustomStateBar != null) {
      return widget.topCustomStateBar;
    }
    return new Container(
      height: (50.0 + ToolUtils.getSysStatsHeight(context)),
      width: ToolUtils.getScreenWidth(context),
      decoration: getTopBgBoxDecoration(),
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: getBgChangeVisible(),
            child: Container(
              height: (50.0 + ToolUtils.getSysStatsHeight(context)),
              width: ToolUtils.getScreenWidth(context),
              decoration: getBgBoxChangeDecoration(),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                height: ToolUtils.getSysStatsHeight(context),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Offstage(
                      offstage: widget.leftBtnGone,
                      child: GestureDetector(
                        onTap: () {
                          widget.clickListener(0);
                        },
                        child: Image(
                          image: new AssetImage(widget.leftBtnImgAssets),
                          height: 28.0,
                          width: 28.0,
                        ),
                      ),
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        widget.clickListener(1);
                      },
                      child: Offstage(
                          offstage: widget.centerTextGone,
                          child: getTopTextView()),
                    )),
                    Offstage(
                      offstage: widget.rightBtnGone,
                      child: GestureDetector(
                        onTap: () {
                          widget.clickListener(2);
                        },
                        child: Image(
                          image: new AssetImage(widget.rightBtnImgAssets),
                          height: 28.0,
                          width: 28.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 0.25,
                decoration: BoxDecoration(color: getTopDiverColor()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getTransStateBar() {
    return Stack(
      children: <Widget>[
        getContainerWidget(),
        getTopView(),
      ],
    );
  }

  Widget getNoStateBar() {
    return Stack(
      children: <Widget>[
        getContainerWidget(),
        Offstage(
          offstage: true,
          child: getTopView(),
        ),
      ],
    );
  }

  Widget getDefaultStateBar() {
    return Column(
      children: <Widget>[getTopView(), Expanded(child: getContainerWidget())],
    );
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => widget.needKeep;
}
