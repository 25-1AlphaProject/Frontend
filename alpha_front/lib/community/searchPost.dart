import 'package:alpha_front/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:alpha_front/widgets/post_widget.dart';
import 'package:alpha_front/community/write.dart';

class SearchPost extends StatefulWidget {
  const SearchPost({super.key});

  @override
  State<SearchPost> createState() => _SearchPostState();
}

class _SearchPostState extends State<SearchPost> {
  List<Map<String, dynamic>> posts = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMore = true;
  bool isSearching = false;

  String searchText = '';
  String sort = 'recent';
  int page = 0;
  int size = 10;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _loadSortedPosts('recent');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _fetchMorePosts();
    }
  }

  Future<void> searchPost(String keyword) async {
    if (keyword.trim().isEmpty) return;

    setState(() {
      searchText = keyword;
      isSearching = true;
      isLoading = true;
      posts = [];
      page = 0;
      hasMore = false;
    });

    final result = await ApiService.getPostList(keyword);

    setState(() {
      posts = result ?? [];
      isLoading = false;
    });
  }

  Future<void> _fetchMorePosts() async {
    if (isLoadingMore || !hasMore || isSearching) return;

    setState(() {
      isLoadingMore = true;
    });

    final nextPage = page + 1;
    final result = await ApiService.sortSearchPost(sort, nextPage, size);

    if (result != null && result.isNotEmpty) {
      setState(() {
        posts.addAll(result);
        page = nextPage;
      });
    } else {
      setState(() {
        hasMore = false;
      });
    }

    setState(() {
      isLoadingMore = false;
    });
  }

  Future<void> _loadSortedPosts(String selectedSort) async {
    setState(() {
      sort = selectedSort;
      page = 0;
      posts = [];
      hasMore = true;
      isLoading = true;
      isSearching = false;
    });

    final result = await ApiService.sortSearchPost(sort, page, size);
    setState(() {
      posts = result ?? [];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              onSubmitted: searchPost,
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.search,
                  color: Color(0xff3CB196),
                ),
                hintText: "검색",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: const Color(0xff3CB196)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: const Color(0xff3CB196).withAlpha(150),
                )),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff3CB196),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _loadSortedPosts('recent'), //sort
                  child: const Text(
                    "최신순",
                    style: TextStyle(color: Color(0xff3CB196)),
                  ),
                ),
                TextButton(
                  onPressed: () => _loadSortedPosts('popular'), // popular
                  child: const Text(
                    "인기순",
                    style: TextStyle(color: Color(0xff3CB196)),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PostCreatePage()),
                    );
                  },
                  icon: const Icon(
                    Icons.create_rounded,
                    color: Color(0xff3CB196),
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 50),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff3CB196),
                      ),
                    )
                  : posts.isEmpty
                      ? const Center(
                          child: Text(
                            "검색결과가 없습니다.",
                            style: TextStyle(
                              fontFamily: 'Pretendard-regular',
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: posts.length + (hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < posts.length) {
                              final post = posts[index];
                              final title = post["title"]?.toString() ?? '';
                              final detail = post['content']?.toString() ?? '';
                              final scrap = post["scrapCount"] ?? 0;
                              final like = post['likeCount'] ?? 0;
                              final comment = post['commentCount'] ?? 0;
                              final image =
                                  post['thumbnailUrl']?.toString() ?? '';
                              final date = post['createdAt']?.toString() ?? '';
                              final dateFormat = date.length >= 10
                                  ? date.substring(0, 10)
                                  : '';

                              return InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const 작성된 게시글()));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    PostIngredient(
                                      postTitle: title,
                                      postDetail: detail,
                                      postScrap: scrap,
                                      postLike: like,
                                      postComment: comment,
                                      postDate: dateFormat,
                                      postURLs: image,
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              );
                            } else {
                              // 로딩 인디케이터 (다음 페이지 로딩 중일 때)
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xff3CB196),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
