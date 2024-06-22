class PersonalizedTrainingInfo {
  final bool hasReceivedTraining;
  String experienceDescription;

  PersonalizedTrainingInfo({
    required this.hasReceivedTraining,
    required this.experienceDescription,
  });

  Map<String, dynamic> toJson() => {
        'hasReceivedTraining': hasReceivedTraining,
        'experienceDescription': experienceDescription,
      };

  static PersonalizedTrainingInfo fromJson(Map<String, dynamic> json) {
    return PersonalizedTrainingInfo(
      hasReceivedTraining: json['hasReceivedTraining'],
      experienceDescription: json['experienceDescription'],
    );
  }
}

class AppTrainingInfo {
  final bool hasReceivedTrainingFromApp;
  String experienceDescription;

  AppTrainingInfo({
    required this.hasReceivedTrainingFromApp,
    required this.experienceDescription,
  });

  Map<String, dynamic> toJson() => {
        'hasReceivedTrainingFromApp': hasReceivedTrainingFromApp,
        'experienceDescription': experienceDescription,
      };

  static AppTrainingInfo fromJson(Map<String, dynamic> json) {
    return AppTrainingInfo(
      hasReceivedTrainingFromApp: json['hasReceivedTrainingFromApp'],
      experienceDescription: json['experienceDescription'],
    );
  }
}

class TrainingInfo {
  final String activityDuration;
  final String trainingDuration;
  final String trainingFrequency;
  final String trainingIntensity;
  String trainingLevel;
  PersonalizedTrainingInfo? personalizedTrainingInfo;
  AppTrainingInfo? appTrainingInfo;

  TrainingInfo({
    required this.activityDuration,
    required this.trainingDuration,
    required this.trainingFrequency,
    required this.trainingIntensity,
    this.trainingLevel = '',
    this.personalizedTrainingInfo,
    this.appTrainingInfo,
  });

  Map<String, dynamic> toJson() => {
        'activityDuration': activityDuration,
        'trainingDuration': trainingDuration,
        'trainingFrequency': trainingFrequency,
        'trainingIntensity': trainingIntensity,
        'trainingLevel': trainingLevel,
        'personalizedTrainingInfo': personalizedTrainingInfo?.toJson(),
        'appTrainingInfo': appTrainingInfo?.toJson(),
      };

  static TrainingInfo fromJson(Map<String, dynamic> json) {
    return TrainingInfo(
      activityDuration: json['activityDuration'],
      trainingDuration: json['trainingDuration'],
      trainingFrequency: json['trainingFrequency'],
      trainingIntensity: json['trainingIntensity'],
      trainingLevel: json['trainingLevel'],
      personalizedTrainingInfo: json['personalizedTrainingInfo'] != null
          ? PersonalizedTrainingInfo.fromJson(json['personalizedTrainingInfo'])
          : null,
      appTrainingInfo: json['appTrainingInfo'] != null
          ? AppTrainingInfo.fromJson(json['appTrainingInfo'])
          : null,
    );
  }
}

/*
class TrainingInfo {
  final String activityDuration;
  final String trainingDuration;
  final String trainingFrequency;
  final String trainingIntensity;
  String trainingLevel;
  PersonalizedTrainingInfo? personalizedTrainingInfo;

  TrainingInfo({
    required this.activityDuration,
    required this.trainingDuration,
    required this.trainingFrequency,
    required this.trainingIntensity,
    this.trainingLevel = '',
    this.personalizedTrainingInfo,
  });

  Map<String, dynamic> toJson() => {
        'activityDuration': activityDuration,
        'trainingDuration': trainingDuration,
        'trainingFrequency': trainingFrequency,
        'trainingIntensity': trainingIntensity,
        'trainingLevel': trainingLevel,
        'personalizedTrainingInfo': personalizedTrainingInfo?.toJson(),
      };

  static TrainingInfo fromJson(Map<String, dynamic> json) {
    return TrainingInfo(
      activityDuration: json['activityDuration'],
      trainingDuration: json['trainingDuration'],
      trainingFrequency: json['trainingFrequency'],
      trainingIntensity: json['trainingIntensity'],
      trainingLevel: json['trainingLevel'],
      personalizedTrainingInfo: json['personalizedTrainingInfo'] != null
          ? PersonalizedTrainingInfo.fromJson(json['personalizedTrainingInfo'])
          : null,
    );
  }
}



*/

/*class TrainingInfo {
  final String activityDuration;
  final String trainingDuration;
  final String trainingFrequency;
  final String trainingIntensity;
  String trainingLevel;

  TrainingInfo({
    required this.activityDuration,
    required this.trainingDuration,
    required this.trainingFrequency,
    required this.trainingIntensity,
    this.trainingLevel = '',
  });

  Map<String, dynamic> toJson() => {
        'activityDuration': activityDuration,
        'trainingDuration': trainingDuration,
        'trainingFrequency': trainingFrequency,
        'trainingIntensity': trainingIntensity,
        'trainingLevel': trainingLevel,
      };

  static TrainingInfo fromJson(Map<String, dynamic> json) {
    return TrainingInfo(
      activityDuration: json['activityDuration'],
      trainingDuration: json['trainingDuration'],
      trainingFrequency: json['trainingFrequency'],
      trainingIntensity: json['trainingIntensity'],
      trainingLevel: json['trainingLevel'],
    );
  }
}
*/

int convertDuration(String duration) {
  switch (duration) {
    case 'activity_duration_1to3':
      return 3;
    case 'activity_duration_3to6':
      return 6;
    case 'activity_duration_6to9':
      return 9;
    case 'activity_duration_9to12':
      return 12;
    case 'activity_duration_12to18':
      return 18;
    case 'activity_duration_18to24':
      return 24;
    case 'activity_duration_24plus':
      return 25; // Más de 2 años
    default:
      return 0;
  }
}

int convertFrequency(String frequency) {
  switch (frequency) {
    case 'training_frequency_1perweek':
      return 1;
    case 'training_frequency_2perweek':
      return 2;
    case 'training_frequency_3perweek':
      return 3;
    case 'training_frequency_4perweek':
      return 4;
    case 'training_frequency_5perweek':
      return 5;
    case 'training_frequency_6perweek':
      return 6;
    case 'training_frequency_7perweek':
      return 7;
    default:
      return 0;
  }
}

int convertDurationMinutes(String duration) {
  switch (duration) {
    case 'training_duration_less30':
      return 30;
    case 'training_duration_30to45':
      return 45;
    case 'training_duration_45to60':
      return 60;
    case 'training_duration_60to90':
      return 90;
    case 'training_duration_90plus':
      return 91; // Más de 90 minutos
    default:
      return 0;
  }
}

int convertIntensity(String intensity) {
  switch (intensity) {
    case 'training_intensity_low':
      return 1;
    case 'training_intensity_medium':
      return 2;
    case 'training_intensity_high':
      return 3;
    default:
      return 0;
  }
}



/*

class TrainingInfo {
  final String activityDuration;
  final String trainingDuration;
  final String trainingFrequency;
  final String trainingIntensity;
  String trainingLevel;

  TrainingInfo({
    required this.activityDuration,
    required this.trainingDuration,
    required this.trainingFrequency,
    required this.trainingIntensity,
    this.trainingLevel = '',
  });

  Map<String, dynamic> toJson() => {
        'activityDuration': activityDuration,
        'trainingDuration': trainingDuration,
        'trainingFrequency': trainingFrequency,
        'trainingIntensity': trainingIntensity,
        'trainingLevel': trainingLevel,
      };

  static TrainingInfo fromJson(Map<String, dynamic> json) {
    return TrainingInfo(
      activityDuration: json['activityDuration'],
      trainingDuration: json['trainingDuration'],
      trainingFrequency: json['trainingFrequency'],
      trainingIntensity: json['trainingIntensity'],
      trainingLevel: json['trainingLevel'],
    );
  }
}
*/