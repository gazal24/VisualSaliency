function hide_ele(id) {
  document.getElementById(id).style.visibility = "hidden";
}

function validateForm_email(obj)
{
  var x=obj.value;
  if(x=="")
  {
    obj.parentNode.className="control-group controls";
    document.getElementById("errormsg_email").innerHTML="";
    return false;
  }

  var atpos=x.indexOf("@");
  var dotpos=x.lastIndexOf(".");
  if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length)
  {
    obj.parentNode.className="control-group controls error";
    document.getElementById("errormsg_email").innerHTML="Invalid email id";
    return false;
  }
  else {
    obj.parentNode.className="control-group controls";
    document.getElementById("errormsg_email").innerHTML="";
    return true;
  }
}

function validateForm_upload(form_obj)
{
  var inputs = form_obj.elements;
  for(var i =0; i<inputs.length; i++) {
    if(inputs[i].tagName=="INPUT" && inputs[i].type=="file" && inputs[i].value=="") {
      alert("Select image for : " + inputs[i-1].value);
      return false;
    }
  }
  return true;
}


function validateForm_register(form_obj)
{
  var inputs = form_obj.elements;
  isValid = true;
  for(var i =0; i<inputs.length; i++) {
    var n = inputs[i].name;
    if(n=="email") {
      if(!validateForm_email(inputs[i]))
	isValid = false;
    }
    if((n=="uname" || n=="name" || n=="email" || n=="passwd" || n=="repasswd") && inputs[i].value=="") {
      inputs[i].parentNode.className="control-group controls error";
      // span tag for error messages should have id as 'errormsg_+field-name' for code below to work.
      document.getElementById("errormsg_" + n).innerHTML="*Required Field";
      isValid = false;
    }
  }
  return isValid;
}


function change_content(tab) {
  var xmldoc = new XMLHttpRequest();
  if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp=new XMLHttpRequest();
  }
  else
  {// code for IE6, IE5
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
  xmldoc.open("GET", tab+".html?random="+Math.random(), true);
  xmldoc.send();
  xmldoc.onreadystatechange=function() {
    if (xmldoc.readyState==4 && xmldoc.status==200) {
      resptxt = xmldoc.responseText;
      document.getElementById("Tab_content").innerHTML = resptxt;
    }
  }
}
