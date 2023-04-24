boolean isInteger(String s) {
  boolean result = false;
  try {
    Integer.parseInt(s);
    result = true;
  }
  catch(NumberFormatException e) {
  }
  return result;
}

boolean isFloat(String s) {
  boolean result = false;
  try {
    Float.parseFloat(s);
    result = true;
  }
  catch(NumberFormatException e) {
  }
  return result;
}

boolean contains(String[] list, String searchedString) {
  boolean exists = false; 
  for (String strItem : list){
    if ( strItem.equals(searchedString) ) {
      exists = true;
      break; 
    }
  }
  return exists; 
}
