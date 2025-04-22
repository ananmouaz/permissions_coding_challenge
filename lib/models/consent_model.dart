class ConsentModel {
  bool shareLocation;
  bool shareUsageAnalytics;
  bool shareCrashReports;

  ConsentModel({
    this.shareLocation = false,
    this.shareUsageAnalytics = false,
    this.shareCrashReports = false,
  });


  factory ConsentModel.fromJson(Map<String, dynamic> json) {
    return ConsentModel(
      shareLocation: json['shareLocation'] ?? false,
      shareUsageAnalytics: json['shareUsageAnalytics'] ?? false,
      shareCrashReports: json['shareCrashReports'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shareLocation': shareLocation,
      'shareUsageAnalytics': shareUsageAnalytics,
      'shareCrashReports': shareCrashReports,
    };
  }

  ConsentModel copyWith({
    bool? shareLocation,
    bool? shareUsageAnalytics,
    bool? shareCrashReports,
  }) {
    return ConsentModel(
      shareLocation: shareLocation ?? this.shareLocation,
      shareUsageAnalytics: shareUsageAnalytics ?? this.shareUsageAnalytics,
      shareCrashReports: shareCrashReports ?? this.shareCrashReports,
    );
  }
}