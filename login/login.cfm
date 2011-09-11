<cfsetting enablecfoutputonly="true">

<cfimport taglib="/login/tags/" prefix="tags">

<cfscript>
	param name="process" default={};
	param name="form._username" default="";
	
	if (structKeyExists(form, "btnLogin"))
	{
		Login = New Login("mydsn");
		process = Login.doLogin(trim(form._username), trim(form._password));
	}
</cfscript>

<tags:message data="#process#">

<cfoutput>
<form id="frmLogin" action="" method="post">
	<fieldset>
		<legend>Login</legend>
		<ol>
			<li>
				<label for="_username">Username:</label>
				<input type="text" name="_username" id="_username" value="#form._username#" maxlength="15" />
			</li>
			<li>
				<label for="_password">Password:</label>
				<input type="password" name="_password" id="_password" maxlength="25" />
			</li>
			<li><input type="submit" name="btnLogin" id="btnLogin" value="login" /></li>
		</ol>
	</fieldset>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="false">