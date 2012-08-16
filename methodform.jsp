<table>
  <tr>
    <form method=post action="savemethods.jsp">
      <td class="field">
      	<input type=text name= uname size=20 placeholder="method name"> 
      </td>
      <td class="buttons"> 
	<button type="submit" class="positive" name="save"> 
	  <img src="images/apply2.png" alt=""/> save
	</button>
	<a href="getname.jsp" class="regular">
	  <img src="images/textfield_key.png" alt=""/>  Reset
	</a>
      </td>
    </form>
    
    <td class="buttonv2">
      <form action="upload.jsp" method="post"
            enctype="multipart/form-data">
	<input type="file" name="file" size="50"/>
	<button type="submit" value="Upload File"> Submit</button>
      </form>
    </td>
  </tr>
</table>
