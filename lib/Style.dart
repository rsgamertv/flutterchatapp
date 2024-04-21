
import 'package:flutter/material.dart';

BoxDecoration filledboxdecoration(){
return BoxDecoration(
  borderRadius: BorderRadius.circular(5),
  color: Colors.blueAccent
);

}
BoxDecoration decoration(){
  return BoxDecoration(
    border: Border.all(
      width: 3,
      color: Colors.blueAccent,
    ),
    borderRadius: BorderRadius.circular(5),
  );
}

BoxDecoration white_decoration(){
  return BoxDecoration(
    border: Border.all(
        width: 3,
        color: Colors.white
    ),
    borderRadius: BorderRadius.circular(5),
  );
}
BoxDecoration avatar_decoration(){
  return BoxDecoration(
    border: Border.all(
        width: 2,
        color: Colors.white
    ),
    borderRadius: BorderRadius.circular(300),
  );
}

InputDecoration field_decoration(String hint){
  return InputDecoration(
    border: OutlineInputBorder(
    ),
    hintText: hint,
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blueAccent
        ),
      borderRadius: BorderRadius.circular(10)
    )
  );
}

InputDecoration field_outlined_decoration(String hint){
  return InputDecoration(
      border: UnderlineInputBorder(),
      hintText: hint,
  );
}
InputDecoration field_outlined_decoration_small_font(String hint){
  return InputDecoration(
      border: UnderlineInputBorder(),
      hintText: hint,
      hintStyle:  const TextStyle(
                    fontSize: 15,
            color: Colors.grey,
            fontWeight: FontWeight.w500
      )
  );
}

InputDecoration password_field_decoration(String hint, bool passwordVisible, Function(bool) callback){
  return InputDecoration(
    border: OutlineInputBorder(),
    hintText: hint,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blueAccent
      ),
      borderRadius: BorderRadius.circular(10)
    ),
    suffixIcon: IconButton(
      icon: Icon(
        passwordVisible ? Icons.visibility : Icons.visibility_off),
        onPressed: () { passwordVisible = !passwordVisible;  callback(passwordVisible); },
    )
  );
}
InputDecoration searchFieldDecoration(String hint){
    return InputDecoration(
      fillColor: Colors.transparent,
      focusColor: Colors.transparent,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      filled: true,
      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
    
      hintText: hint,
      suffixIcon: Icon(
        Icons.search,
        color: Colors.grey.withOpacity(0.8),
      )
    );
}