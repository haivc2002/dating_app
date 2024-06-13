String returnHeightValue(int data) {
  if(data == 100) {
    return 'lower 100';
  } else if(data == 200) {
    return 'higher 200';
  } else {
    return '$data';
  }
}