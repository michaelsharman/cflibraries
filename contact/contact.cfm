<cfsetting enablecfoutputonly="true">

<cfimport taglib="/contact/tags/" prefix="tags">

<cfscript>
	param name="process" default="#{}#";
	param name="form._name" default="";
	param name="form._email" default="";
	param name="form._comments" default="";
	
	if (structKeyExists(form, "btnContact"))
	{
		Contact = New Contact("mydsn");
		process = Contact.doContact(trim(form._name), trim(form._email), trim(form._comments));
	}
</cfscript>

<tags:message data="#process#">

<cfoutput>
<form id="frmContact" action="" method="post">
	<fieldset>
		<legend>Contact</legend>
		<ol>
			<li>
				<label for="_name">Name:</label>
				<input type="text" name="_name" id="_name" value="#form._name#" maxlength="50" />
			</li>
			<li>
				<label for="_email">Email:</label>
				<input type="text" name="_email" id="_email" value="#form._email#" maxlength="150" />
			</li>
			<li>
				<label for="_comments">Comment:</label>
				<textarea name="_comments" id="_comments" class="text textarea">#form._comments#</textarea>
			</li>
			<li><input type="submit" name="btnContact" id="btnContact" value="contact" /></li>
		</ol>
	</fieldset>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="false">