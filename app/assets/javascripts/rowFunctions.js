
function addRowBasic()
{
	if(document.getElementById("basic").className == "hide")
	{
		document.getElementById("basic").className =  document.getElementById("basic").className.replace
      	( "hide");
      	document.getElementById("removeBasic").className =  document.getElementById("removeBasic").className.replace
      	( "hide");

		}
	else if (document.getElementById("basic2").className == "hide")
	{
		document.getElementById("basic2").className = document.getElementById("basic2").className.replace
      ( "hide" );
	}
	else
	{
		alert("you may only have 5 prompts");
	}
}

	function removeRowBasic()
	{
		if(document.getElementById("basic2").className == "undefined")
		{
			document.getElementById("basic2").className =  "hide";

		}	
		else if (document.getElementById("basic").className == "undefined")
		{
			document.getElementById("basic").className = "hide";
			document.getElementById("removeBasic").className = "hide";
		}
		else
		{
			
			alert("you must have at least 3 prompts");
		}
	}

function addRowTheme()
{
	if(document.getElementById("theme").className == "hide")
	{
		document.getElementById("theme").className =  document.getElementById("theme").className.replace
      	( "hide");
      	document.getElementById("removeTheme").className =  document.getElementById("removeTheme").className.replace
      	( "hide");

		}
	else if (document.getElementById("theme2").className == "hide")
	{
		document.getElementById("theme2").className = document.getElementById("theme2").className.replace
      ( "hide" );
	}
	else
	{
		alert("you may only have 5 prompts");
	}
}

	function removeRowTheme()
	{
		if(document.getElementById("theme2").className == "undefined")
		{
			document.getElementById("theme2").className =  "hide";

		}	
		else if (document.getElementById("theme").className == "undefined")
		{
			document.getElementById("theme").className = "hide";
			document.getElementById("removeTheme").className = "hide";
		}
		else
		{
			
			alert("you must have at least 3 prompts");
		}
	}
function addRowWorld()
{
	if(document.getElementById("world").className == "hide")
	{
		document.getElementById("world").className =  document.getElementById("world").className.replace
      	( "hide");
      	document.getElementById("removeWorld").className =  document.getElementById("removeWorld").className.replace
      	( "hide");

		}
	else if (document.getElementById("world2").className == "hide")
	{
		document.getElementById("world2").className = document.getElementById("world2").className.replace
      ( "hide" );
	}
	else
	{
		alert("you may only have 5 prompts");
	}
}

	function removeRowWorld()
	{
		if(document.getElementById("world2").className == "undefined")
		{
			document.getElementById("world2").className =  "hide";
			document.getElementById("world2").value = "";

		}	
		else if (document.getElementById("world").className == "undefined")
		{
			document.getElementById("world").className = "hide";
			document.getElementById("removeWorld").className = "hide";
			document.getElementById("world").value = "";

		}
		else
		{
			
			alert("you must have at least 3 prompts");
		}
	}