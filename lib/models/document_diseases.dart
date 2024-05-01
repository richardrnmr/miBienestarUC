class DocumentDiseases {
  final int rank;
  final String url;
  final String title;
  final String organizationName;
  final String fullSummary;
  final List<String> altTitles;
  final List<String> groupNames;
  final String snippet;

  DocumentDiseases({
    required this.rank,
    required this.url,
    required this.title,
    required this.organizationName,
    required this.fullSummary,
    required this.altTitles,
    required this.groupNames,
    required this.snippet,
  });
}
