$(document).ready(function(){
	
	if ($('#frmContact').length){$('#frmContact').submit(function(evt){doContact(evt)});}
	
});


/**
 * Controller function to handle logon attempts
 * If valid, submits form, else prints message
 */
 function doContact(evt)
{
	evt.preventDefault();

	var doContact = validateContact($('#_name').val(), $('#_email').val(), $('#_comments').val());
	
	if (doContact.status)
	{
		$('#frmContact').submit();
	}
	else
	{
		showMessage(doContact, "frmContact");
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
function validateContact(_name, _email, _comments)
{
	var output = {
			status: true
			, message: ""
			, messages: []
	}
	
	var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	
	if (!$.trim(_name).length)
	{
		output.messages.push("Please enter your name");
	}

	if (!$.trim(_email).length || !emailReg.test(_email))
	{
		output.messages.push("Please enter a valid email");
	}
	
	if (!$.trim(_comments).length)
	{
		output.messages.push("Please enter your comment");
	}
	
	if (output.messages.length)
	{
		output.status = false;
		output.message = "Contact form failed";
	}
	
	return output;
}