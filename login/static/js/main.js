$(document).ready(function(){
	
	if ($('#frmLogin').length){$('#frmLogin').submit(function(evt){doLogin(evt)});}
	
});


/**
 * Controller function to handle logon attempts
 * If valid, submits form, else prints message
 */
 function doLogin(evt)
{
	evt.preventDefault();

	var doLogin = validateLogin($('#_username').val(), $('#_password').val());
	
	if (doLogin.status)
	{
		$('#frmLogin').submit();
	}
	else
	{
		showMessage(doLogin, "frmLogin");
	}
}


 /**
  * Loads a message to the screen
  * msg [object] has 3 keys:
  * 	status [bool]
  * 	message [string]
  * 	messages [array]
  */
function showMessage(msg, id, classname)
{
	var output = "", msgClass

	msgClass = (classname != undefined)?classname:"";
	if (!msgClass.length)
	{
		msgClass = (msg.status)?"mesage-success":"message-error";
	}

	for (var i = 0; i < msg.messages.length; i++)
	{
		output+= "<li>" + msg.messages[i] + "</li>";
	}
	
	if (output.length)
	{
		output = '<div id="message-box" class="' + msgClass + '"><h3>' + msg.message + '</h3><ul>' + output + "</ul></div>";

		// first checking if there was already a message showing, if there was then remove it so we don't get duplicate stacked messages		
		if ($('#message-box'))
		{
			$('#message-box').remove();
		}
		
		$('#' + id).prepend(output);
	}
}


/**
 * Validates a logon attempt, returns an object of messages if false
 */
function validateLogin(user, pass)
{
	var output = {
			status: true
			, message: ""
			, messages: []
	}
	
	if (!$.trim(user).length)
	{
		output.messages.push("Please enter your username");
	}

	if (!$.trim(pass).length)
	{
		output.messages.push("Please enter your password");
	}
	
	if (output.messages.length)
	{
		output.status = false;
		output.message = "Login failed";
	}
	
	return output;
}