class HasilTfidf {
  String? keyword;
  int? count;
  double? tf;
  double? idf;
  double? tfIdf;

  HasilTfidf({this.keyword, this.count, this.tf, this.idf, this.tfIdf});

  @override
  String toString() {
    return 'HasilTfidf(keyword: $keyword, count: $count, tf: $tf, idf: $idf, tfIdf: $tfIdf)';
  }

  factory HasilTfidf.fromJson(Map<String, dynamic> json) => HasilTfidf(
        keyword: json['keyword'] as String?,
        count: json['count'] as int?,
        tf: (json['tf'] as num?)?.toDouble(),
        idf: (json['idf'] as num?)?.toDouble(),
        tfIdf: (json['tf_idf'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'keyword': keyword,
        'count': count,
        'tf': tf,
        'idf': idf,
        'tf_idf': tfIdf,
      };
}
