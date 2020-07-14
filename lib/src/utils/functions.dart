class Functions {
  // for mapping data retrieved form json array
  getData(Map<String, dynamic> data) {
    return data['data'] ?? [];
  }

  int getIntData(Map<String, dynamic> data) {
    return (data['data'] as int) ?? 0;
  }

  bool getBoolData(Map<String, dynamic> data) {
    return (data['data'] as bool) ?? false;
  }

  getObjectData(Map<String, dynamic> data) {
    return data['data'] ?? new Map<String, dynamic>();
  }
}
