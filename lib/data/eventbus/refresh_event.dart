enum RefreshType { ON_GOING_DEAL, SLIDER, ALL, GET_ALL_DEAD_BY_USER_ID }

class RefreshEvent{
final  RefreshType refreshType;

  RefreshEvent({required this.refreshType});
}