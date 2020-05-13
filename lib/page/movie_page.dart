import 'package:douban_movie_flutter/model/movie_subject.dart';
import 'package:douban_movie_flutter/provider/movie_list_provider.dart';
import 'package:douban_movie_flutter/widget/common_empty_widget.dart';
import 'package:douban_movie_flutter/widget/common_error_widget.dart';
import 'package:douban_movie_flutter/widget/movie_item_widget.dart';
import 'package:douban_movie_flutter/widget/movie_skeleton_item_widget.dart';
import 'package:douban_movie_flutter/widget/skeleton.dart';
import 'package:douban_movie_flutter/widget/view_state_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MoviePage extends StatefulWidget {
  final bool isShowing;

  MoviePage({this.isShowing});

  @override
  State<StatefulWidget> createState() {
    return MovieState(isShowing);
  }
}

class MovieState extends State<MoviePage> with AutomaticKeepAliveClientMixin {
  final bool isShowing;

  MovieState(this.isShowing);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget<MovieListProvider>(
        provider: MovieListProvider(context, isShowing: isShowing),
        onProviderReady: (provider) async {
          await provider.initData();
        },
        builder: (context, MovieListProvider provider, child) {
          if (provider.isBusy) {
            return SkeletonList(
              builder: (context, index) => MovieSkeletonItemWidget(
                showIndexNumber: false,
              ),
            );
          } else if (provider.isEmpty) {
            return CommonEmptyWidget(onPressed: provider.initData);
          } else if (provider.isError) {
            return CommonErrorWidget(
                error: provider.viewStateError, onPressed: provider.initData);
          }
          return SmartRefresher(
            controller: provider.refreshController,
            header: WaterDropHeader(),
            footer: ClassicFooter(),
            onRefresh: provider.refresh,
            onLoading: provider.loadMore,
            enablePullUp: true,
            child: ListView.builder(
                itemCount: provider.list.length,
                itemBuilder: (context, index) {
                  MovieSubject item = provider.list[index];
                  return MovieItemWidget(
                      isShowing: isShowing,
                      showIndexNumber: false,
                      index: index,
                      movieSubject: item);
                }),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
