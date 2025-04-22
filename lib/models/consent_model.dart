class ConsentModel {
  bool shareLocation;
  bool shareUsageAnalytics;
  bool shareCrashReports;

  ConsentModel({
    this.shareLocation = false,
    this.shareUsageAnalytics = false,
    this.shareCrashReports = false,
  });

  // Factory constructor to create a ConsentModel from JSON
  factory ConsentModel.fromJson(Map<String, dynamic> json) {
    return ConsentModel(
      shareLocation: json['shareLocation'] ?? false,
      shareUsageAnalytics: json['shareUsageAnalytics'] ?? false,
      shareCrashReports: json['shareCrashReports'] ?? false,
    );
  }

  // Method to convert ConsentModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'shareLocation': shareLocation,
      'shareUsageAnalytics': shareUsageAnalytics,
      'shareCrashReports': shareCrashReports,
    };
  }

  // Clone with method to create a new instance with updated values
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