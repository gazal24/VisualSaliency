function hide_ele(id) {
  document.getElementById(id).style.visibility = "hidden";
}

function validateForm_email(obj)
{
  var x=obj.value;
  var atpos=x.indexOf("@");
  var dotpos=x.lastIndexOf(".");
  if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length)
  {
    obj.style.border = "3px solid #B82222";
    return false;
  }
  else {
    obj.style.border = "3px solid #11CC11";
  }
}
