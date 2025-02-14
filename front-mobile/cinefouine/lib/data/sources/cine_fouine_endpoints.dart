class CineFouineEndpoints {
  CineFouineEndpoints._();

  static const String getRecommendation = '/Recommendation/get-recommendations';
  static const String getAllEvent = '/Event/GetAllEvents';
  static const String createEvent = '/Event/AddEvent';
  static const String register = '/Auth/register';  
  static const String getGenres = '/Genre'; 
  static const String getUserPreference = '/UserPreference/GetPrefereneceByUserId'; 
  static const String postPreferenceToUser = '/UserPreference/PostPreferenceToUser';
  static const String updatePreferenceToUser = '/UserPreference/UpdateUserPreference';
  static const String getQuizz = '/quizz/getQuizz';

}