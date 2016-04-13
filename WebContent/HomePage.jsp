<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList,java.util.Iterator,com.itubuzz.valueobjects.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="style.css" type="text/css" />
<title>ITUBUZZ</title>
<%
	if(null!=request.getAttribute("errorMessage"))
    {
        out.println(request.getAttribute("errorMessage"));
    }
%>
<script src="./js/jquery-1.12.2.min.js"></script>
    <script src="./js/jquery.tools.min.js"></script>
    <script src="./js/TextboxList.js"></script>
	<link rel="stylesheet" type="text/css" href="./css/overlay-apple.css">
	<link rel="stylesheet" type="text/css" href="./css/TextboxList.css">
	<!-- required stylesheet for TextboxList -->
	<link rel="stylesheet" href="./css/TextboxList.css" type="text/css" media="screen" charset=ISO-8859-1>
	<!-- required for TextboxList -->
	<script src="./js/GrowingInput.js" type="text/javascript" charset="utf-8"></script>
	<script src="./js/TextboxList.js" type="text/javascript" charset="utf-8"></script>	
	
<style type="text/css" media="screen">
		.textboxlist { width: 400px; bgcolor: #a8a69f; }
	</style>
	
<script type="text/javascript">

$(function(){
	// With custom adding keys 
	var t2 = $('#form_tags_input_2').textboxlist({bitsOptions:{editable:{addKeys: [188]}}});
});

$(document).ready(function() {
	  $("a[rel]").overlay({effect: 'apple'});
      });

onload=function(){
	var e = document.getElementById("refreshed");
	if (e.value == "no")
		e.value="yes";
	else {
		e.value="no";
		location.reload();
	}
}
function nextChildid(parentid) {

	var childs = document.getElementById(parentid).childNodes;
	var childid = 0;
	var lastChildid = 0;
	var num = 0;
	
    for (i = 0; i < childs.length; i++) {
         if ( childs[i].nodeName == "DIV" ){
        	 lastChildid = childs[i].id;
        	 num = num + 1;
         }
    }
	
        
    if ( num == 0 ) {
   		var num = 1;	
   		childid = parentid.toString().concat(num.toString());
    } else {
    	childid = parseInt(lastChildid) + 1;
    }	
    
    return childid;
}

function displayReply(parentid) {
	var userid = document.getElementById("log_user_id").value;
	var replyname = document.getElementById("log_user_name").value;
	var parent = document.getElementById(parentid);
	var num = 0;
	
	var rootparent = document.getElementById(parentid);
	
   	while (rootparent.parentNode.getAttribute('id') != null) {
    		rootparent = rootparent.parentNode;
    		num = num + 1;		
   	}
   	
   	var leftspace = null;
   	
	if ( num == 0)
		leftspace = "margin-left: 0px;";
	 else 
		leftspace = "margin-left: 50px;";


   	var rootparentid = rootparent.getAttribute('id');

    var childid = nextChildid(parentid);
    
    var form = document.createElement("form");
	form.setAttribute('action', 'ReplyDataServlet');
    form.setAttribute('method', 'post');
    form.setAttribute('autocomplete','off');
    
	var childiv = document.createElement("div");
	childiv.setAttribute('id', childid);
	childiv.setAttribute('style', leftspace);
	
	var node1 = document.createElement("textarea");
	node1.setAttribute('name', 'reply_text');
	node1.setAttribute('id', 'reply_text');
	node1.setAttribute('autocomplete','off');
	node1.setAttribute('placeholder','Comment...');
	node1.setAttribute('style','width:60%;height:50px');
	
	var node2 = document.createElement("br");
	
	var node3 = document.createElement("button");
	node3.setAttribute('id', 'nextreplybutton');
	node3.innerHTML = "Submit";

	var node4 = document.createElement("input");
	node4.setAttribute('type', 'hidden');
	node4.setAttribute('name', 'immparent_id');
	node4.setAttribute('id', 'immparent_id');
	node4.setAttribute('value', parentid);

	var node5 = document.createElement("input");
	node5.setAttribute('type', 'hidden');
	node5.setAttribute('name', 'log_post_id');
	node5.setAttribute('id', 'log_post_id');
	node5.setAttribute('value', rootparentid);
	
	var node6 = document.createElement("input");
	node6.setAttribute('type', 'hidden');
	node6.setAttribute('name', 'reply_id');
	node6.setAttribute('id', 'reply_id');
	node6.setAttribute('value', childid);
	
	var node7 = document.createElement("input");
	node7.setAttribute('type', 'hidden');
	node7.setAttribute('name', 'log_user_id');
	node7.setAttribute('id', 'log_user_id');
	node7.setAttribute('value', userid);
	
	var node8 = document.createElement("input");
	node8.setAttribute('type', 'hidden');
	node8.setAttribute('name', 'reply_user_name');
	node8.setAttribute('id', 'reply_user_name');
	node8.setAttribute('value', replyname);
	
	childiv.appendChild(node1);
	childiv.appendChild(node2);
	childiv.appendChild(node3);
	childiv.appendChild(node4);
	childiv.appendChild(node5);
	childiv.appendChild(node6);
	childiv.appendChild(node7);
	childiv.appendChild(node8);
	
	form.appendChild(childiv);	
	parent.appendChild(form);
		
	node3.onclick = function () {
		var parentid = node3.parentNode.getAttribute('id');
		displayReply(parentid);
	};
}


function displayReplyTree(rootparentid, childid, reply_text, immparentid, userid, replyname) {
		
	var leftspace = null;
	if ( rootparentid == immparentid)
		leftspace = "margin-left: 0px;";
	 else 
		leftspace = "margin-left: 50px;";
	
	var parent = document.getElementById(immparentid);
	var childiv = document.createElement("div");
	childiv.setAttribute('id', childid);
	childiv.setAttribute('style', leftspace);
		
	var node1 = document.createElement("p");
	node1.setAttribute('id','displayName');
	node1.setAttribute('style','color:#007f00;');
	node1.innerHTML = replyname;
	
	var node2 = document.createElement("span");
	node2.setAttribute('id', 'displayreply');
	node2.innerHTML = reply_text;
	
	var node3 = document.createElement("br");
	
	var node4 = document.createElement("a");
	node4.setAttribute('id', 'nextreplybutton');
	node4.setAttribute('href','#');
	node4.innerHTML = "Comment";
	
	childiv.appendChild(node1);
	childiv.appendChild(node2);
	childiv.appendChild(node3);
	childiv.appendChild(node4);
	
	parent.appendChild(childiv);
			
	node4.onclick = function () {
		var parentid = node4.parentNode.getAttribute('id');
		displayReply(parentid);
	};
	
}
</script>  
</head>

<body >
<input type="hidden" id="refreshed" value="no">
<!-- header starts here -->

			
<div>
    <div>
      <div>
     <div>      
     <form id="search_form" action="SearchServlet" method="post"> 
<table align="left">

		<tr>
		<td>ITUBUZZ</td>
		
		<td><input type="text" id="searchtext"></td>
		<td><input type="button" id="searchbutton" value="Search"><br/></td>
		
		</tr>
		
</table>
</form>
<table align="right">
<tr>
			<td ><a href="FetchProfileServlet" id="profile"><%=session.getAttribute("name")%></a> | 
			<a href="LogOut.jsp" id="logout">Logout</a></td>
		 </tr>
</table>
	      </div>
     </div>
	</div>
</div>
<br>
<br>
<br>
<hr />

<table width="100%">
  <tr valign="top">
    <td width="20%" >
    <div>
       	<a href=""> What's trending</a><br>
		<a href="">News Feed</a><br>
		<a href="">Related Links</a><br>
		<a href="GetforumServlet" id="getforumdata">Knowledge Forum <input type="hidden" id="log_user_name" name="log_user_name" value="<%=session.getAttribute("name")%>"></a>
		
		<form action="createGroup" method="post">
	<a href="#" rel="#createGroupContainer">Create Group</a>
	<div class="apple_overlay" id="createGroupContainer">
		Create Group<br><br>
		<div>
			<table >
			<tr>
				<td align="right">Group Name: </td>
				<td><input type="text" name="group_name" value=""/><td>
			</tr>
			<tr>
				<td align="right">Members :    </td>
				<td>		<div class="form_tags"><input type="text" name="members" value="" id="form_tags_input_2" autocomplete="off" style="display: none;">
		</div></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="submit" name="btnCreateGroup" value="Create Group"/></td>
			</tr>
			</table>
		</div>
	</div>
	</form> 
		<br>
	</div>
    </td>

<td width="60%"> 
    <form name="post_form" id="post_form" action="PostDataServlet" method="post">
    <div>
		<textarea name="post_text" id="post_text" style="width:575px;align:center;height:150px;" ></textarea>
		<br>
		<br>
		<input type="submit" id="postbutton" value="Post">
		<input type="hidden" name="log_user_id" id="log_user_id" value="<%=session.getAttribute("user_id")%>">
		<input type="hidden" name="log_user_name" id="log_user_name" value="<%=session.getAttribute("log_user_name")%>">
		</div>
		</form>
	
	


<h3>Recent Activity</h3>
        <table align="center" width="100%" cellpadding="5">
         <tr>
    
<%
   	@SuppressWarnings("unchecked")
	ArrayList<PostVO> posts=(ArrayList<PostVO>)session.getAttribute("all_posts");
    Iterator<PostVO> p_list= posts.iterator();
    
    while(p_list.hasNext()) {
		PostVO p=(PostVO)p_list.next();
%>
</tr>
<tr >
 <td ><p style="color:blue;">Posted By : <%=p.post_user_name %></p></td>
 </tr>
 <tr >
 <td width="60%">
 <div id="<%= p.post_id %>" class="post" style="text-align:justify;width:575px;">
  			<p id="displaypost" align="center" style="text-align:justify;width:575px;"><%=p.post_text%></p>
  			<hr>
     		<a href="#" id="replybutton" onclick="displayReply(<%=p.post_id %>)" >Comment</a>
            <a href="#" id="likebutton">Like</a>
            <hr>
    		<input type="hidden" name="post_id" value="<%=p.post_id%>">
         <input type="hidden" name="log_user_id" value="<%=p.log_user_id %>">
         <input type ="hidden" name="reply_user_name" value="<%=p.post_user_name%>">
 </div>   	
    	<br/>
<%
    }

   	@SuppressWarnings("unchecked")
	ArrayList<ReplyVO> replies=(ArrayList<ReplyVO>)session.getAttribute("all_replies");
    Iterator<ReplyVO> r_list= replies.iterator();
    
	
    if (r_list.hasNext()) {
    	while (r_list.hasNext()) {
    		ReplyVO r=(ReplyVO)r_list.next();
    		Iterator<PostVO> pr_list= posts.iterator();
    		
			while(pr_list.hasNext()) {
				PostVO p=(PostVO)pr_list.next();	

	    		if ( p.post_id == r.post_id ) {
    			
%>
   	 				<script> displayReplyTree(<%= r.post_id %>, <%= r.reply_id%>, "<%= r.reply_text%>", <%= r.immparent_id %>,<%= r.log_user_id%>,"<%=r.log_reply_name%>"); </script>
        			<br />
<%
       			} 
			}
    	}
    }
%>
</td>
<td>

</td>
</tr>
</table>
</tr>
</table>
   
</body>
</html>