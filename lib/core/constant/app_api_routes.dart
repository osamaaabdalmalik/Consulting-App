
class AppApiRoute {

  static const String server = "consulting-backend.microtechdev.com";

  // Auth
  static const String registerUser = "/user/register";
  static const String registerExpert = "/expert/register";
  static const String loginUser = "/user/login";
  static const String loginExpert = "/expert/login";
  static const String logoutUser = "/user/logout";
  static const String logoutExpert = "/expert/logout";

  // User
    // Home
    static const String getCategories = "/user/get-categories";
    static const String getFavorites = "/user/get-favorites";
    static const String getUserBookings = "/user/get-bookings";
    static const String getUserInfo = "/user/get-user-info";

    // Experts of Category
    static const String getCategoryExperts = "/user/get-category-experts";

    // Expert details
    static const String getExpert = "/user/get-expert";
    static const String getAvailable = "/user/get-available-date";
    static const String addBooking = "/user/add-booking";
    static const String addExpertFavorite = "/user/add-export-favorite";
    static const String addRating = "/user/add-rating";


  // Expert
    // Home
    static const String getCategoriesAndDays = "/expert/get-categories-and-days";
    static const String addInfo = "/expert/add-expert-info";
    static const String getExpertInfo = "/expert/get-expert-info";
    static const String getExpertBookings = "/expert/get-expert-bookings";
    static const String getFollows = "/expert/get-expert-follows";
    static const String uploadImage = "/expert/upload-image";

}
