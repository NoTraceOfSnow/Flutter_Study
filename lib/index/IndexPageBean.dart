import 'dart:convert' show json;

class IndexPageBean {
  int curPage;
  int offset;
  int pageCount;
  int size;
  int total;
  bool over;
  List<IndexPageChildrenBean> datas;

  IndexPageBean.fromParams(
      {this.curPage,
      this.offset,
      this.pageCount,
      this.size,
      this.total,
      this.over,
      this.datas});

  factory IndexPageBean(jsonStr) => jsonStr is String
      ? IndexPageBean.fromJson(json.decode(jsonStr))
      : IndexPageBean.fromJson(jsonStr);

  IndexPageBean.fromJson(jsonRes) {
    curPage = jsonRes['curPage'];
    offset = jsonRes['offset'];
    pageCount = jsonRes['pageCount'];
    size = jsonRes['size'];
    total = jsonRes['total'];
    over = jsonRes['over'];
    datas = [];

    for (var datasItem in jsonRes['datas']) {
      datas.add(new IndexPageChildrenBean.fromJson(datasItem));
    }
  }

  @override
  String toString() {
    return '{"curPage": $curPage,"offset": $offset,"pageCount": $pageCount,"size": $size,"total": $total,"over": $over,"datas": $datas}';
  }
}

class IndexPageChildrenBean {
  int chapterId;
  int courseId;
  int id;
  int publishTime;
  int superChapterId;
  int type;
  int userId;
  int visible;
  int zan;
  bool collect;
  bool fresh;
  String apkLink;
  String author;
  String chapterName;
  String desc;
  String envelopePic;
  String link;
  String niceDate;
  String origin;
  String projectLink;
  String superChapterName;
  String title;
  List<dynamic> tags;

  IndexPageChildrenBean.fromParams(
      {this.chapterId,
      this.courseId,
      this.id,
      this.publishTime,
      this.superChapterId,
      this.type,
      this.userId,
      this.visible,
      this.zan,
      this.collect,
      this.fresh,
      this.apkLink,
      this.author,
      this.chapterName,
      this.desc,
      this.envelopePic,
      this.link,
      this.niceDate,
      this.origin,
      this.projectLink,
      this.superChapterName,
      this.title,
      this.tags});

  IndexPageChildrenBean.fromJson(jsonRes) {
    chapterId = jsonRes['chapterId'];
    courseId = jsonRes['courseId'];
    id = jsonRes['id'];
    publishTime = jsonRes['publishTime'];
    superChapterId = jsonRes['superChapterId'];
    type = jsonRes['type'];
    userId = jsonRes['userId'];
    visible = jsonRes['visible'];
    zan = jsonRes['zan'];
    collect = jsonRes['collect'];
    fresh = jsonRes['fresh'];
    apkLink = jsonRes['apkLink'];
    author = jsonRes['author'];
    chapterName = jsonRes['chapterName'];
    desc = jsonRes['desc'];
    envelopePic = jsonRes['envelopePic'];
    link = jsonRes['link'];
    niceDate = jsonRes['niceDate'];
    origin = jsonRes['origin'];
    projectLink = jsonRes['projectLink'];
    superChapterName = jsonRes['superChapterName'];
    title = jsonRes['title'];
    tags = jsonRes['tags'];
  }

  @override
  String toString() {
    return '{"chapterId": $chapterId,"courseId": $courseId,"id": $id,"publishTime": $publishTime,"superChapterId": $superChapterId,"type": $type,"userId": $userId,"visible": $visible,"zan": $zan,"collect": $collect,"fresh": $fresh,"apkLink": ${apkLink !=
        null ? '${json.encode(apkLink)}' : 'null'},"author": ${author != null
        ? '${json.encode(author)}'
        : 'null'},"chapterName": ${chapterName != null ? '${json.encode(
        chapterName)}' : 'null'},"desc": ${desc != null
        ? '${json.encode(desc)}'
        : 'null'},"envelopePic": ${envelopePic != null ? '${json.encode(
        envelopePic)}' : 'null'},"link": ${link != null
        ? '${json.encode(link)}'
        : 'null'},"niceDate": ${niceDate != null
        ? '${json.encode(niceDate)}'
        : 'null'},"origin": ${origin != null
        ? '${json.encode(origin)}'
        : 'null'},"projectLink": ${projectLink != null ? '${json.encode(
        projectLink)}' : 'null'},"superChapterName": ${superChapterName != null
        ? '${json.encode(superChapterName)}'
        : 'null'},"title": ${title != null
        ? '${json.encode(title)}'
        : 'null'},"tags": $tags}';
  }
}
