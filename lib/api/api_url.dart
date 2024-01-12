class ApiUrl {
  static const String loginUrl = 'https://hdoki.com/move-to-ean-adm//login.php';
  static const String contentUrl = 'https://financialmodelingprep.com/api/v3/stock/list';
  static const String contentApiKey = "1cRqtHjIz9D1qCIGRidDC0QYqrbv9Ekt";

  factory ApiUrl() => _singleton;

  ApiUrl._internal();

  static final ApiUrl _singleton = ApiUrl._internal();
}
