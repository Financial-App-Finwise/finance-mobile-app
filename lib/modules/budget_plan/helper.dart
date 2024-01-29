dynamic findMaxValue(Map<String, dynamic> map) {
  if (map.isEmpty) {
    return null; 
  }

  dynamic maxValue =
      map.values.first;

  map.forEach((key, value) {
    if (value > maxValue) {
      maxValue = value;
    }
  });

  return maxValue;
}
