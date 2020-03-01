class SearchList{
  final String id;
  final String searchKey;

  SearchList(this.id, this.searchKey);
  static List<SearchList> getList() {
    return <SearchList>[
      SearchList('EMP_NM', 'Employee Name'),
      SearchList('EMP_NO', 'Employee ID'),
      SearchList('JOB_CD', 'Job Cd'),
      SearchList('STR_CD', 'Str Cd'),
      SearchList('CORP_FG', 'Corp Fg'),
    ];
  }
}