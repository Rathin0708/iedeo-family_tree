class ApiConfig {
  // Mock API Configuration
  static const String _mockBaseUrl = 'https://67d9262600348dd3e2a9d318.mockapi.io/api/v1';
  
  // Production API Configuration (to be updated later)
  static const String _prodBaseUrl = 'https://your-production-api.com/api/v1';
  
  // Environment flag - set to false when moving to production
  static const bool _useMockApi = true;
  
  // Current base URL based on environment
  static String get baseUrl => _useMockApi ? _mockBaseUrl : _prodBaseUrl;
  
  // API Endpoints
  static String get userDataEndpoint => '$baseUrl/Userdata';
  static String get loginEndpoint => '$baseUrl/auth/login';
  static String get signupEndpoint => '$baseUrl/auth/signup';
  
  // API Headers
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    // Add API key header when moving to production
    // 'Authorization': 'Bearer ${ApiKeys.apiKey}',
  };
  
  // Request timeout
  static const Duration requestTimeout = Duration(seconds: 30);
  
  // Environment check methods
  static bool get isMockEnvironment => _useMockApi;
  static bool get isProductionEnvironment => !_useMockApi;
}

// Separate class for API keys (to be added later)
class ApiKeys {
  // TODO: Add production API key here when ready
  // static const String apiKey = 'your-production-api-key';
  
  // For now, mock API doesn't require authentication
  static const String? mockApiKey = null;
}
