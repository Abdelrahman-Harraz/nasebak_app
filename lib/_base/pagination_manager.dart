mixin PaginationManager<M> {
  final List<M> _models = [];
  bool _isLoadingNow = false;
  bool _hasNextPage = false;
  bool _hasPreviousPage = true;

  List<M> get getUpdatedData => _models;

  bool get currentLoadingState => _isLoadingNow;

  bool get shouldLoadMore {
    return (!_isLoadingNow && _hasNextPage);
  }

  void startPaginationLoading() {
    _isLoadingNow = true;
  }

  void stopPaginationLoading() {
    _isLoadingNow = false;
  }

  void resetPagination() {
    _models.clear();
  }

  void alignPaginationWithApi(bool hasPrevious, bool hasNext, List<M> models) {
    _setData(hasPrevious, hasNext, models);
    _fireCallbacks();
  }

  void _setData(bool hasPrevious, bool hasNext, List<M> models) {
    _hasPreviousPage = hasPrevious;
    _hasNextPage = hasNext;
    if (!_hasPreviousPage) _models.clear();
    _models.addAll(models);
  }

  void _fireCallbacks() {
    if (!_hasPreviousPage && !_hasNextPage) {
      onlyOnePageCallback();
    } else {
      if (!_hasPreviousPage) firstPageCallback();
      if (!_hasNextPage) lastPageCallback();
    }

    receivedData(_models);
  }

  // option to have callbacks

  void receivedData(List<M> models) {}

  void firstPageCallback() {}

  void lastPageCallback() {}

  void onlyOnePageCallback() {}
}
