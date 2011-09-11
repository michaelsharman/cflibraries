<cfcomponent output="false" hint="Transient class to process contact form submissions">

	
	<cffunction name="init" access="public" output="false" returnType="Contact">
		<cfargument name="dsn" type="string" required="true">
		
		<cfscript>
			variables.instance = {
				name = ""
				, email = ""
				, comments = ""
				, dsn = arguments.dsn
				, validated = true
			};
			variables.instance.mail = {
				from = ""
				, to = "contact@mysite.com"
				, subject = "Contact message from website"
				, type = "html"
				, cc = ""
				, bcc = ""
			};
			variables.instance.result = {};
			variables.instance.errors = [];
			
			return this;
		</cfscript>
	</cffunction>


	<cffunction name="doContact" access="public" output="false" returnType="struct">
		<cfargument name="name" type="string" required="true">
		<cfargument name="email" type="string" required="true">
		<cfargument name="comments" type="string" required="true">
		
		<cfscript>
			variables.instance.name = trim(arguments.name);
			variables.instance.email = trim(arguments.email);
			variables.instance.comments = trim(arguments.comments);
			
			if (validate())
			{
				variables.instance.mail.from = variables.instance.email;
				save();
				sendConfirmation();
				setMessage(true, "Thank you", ["Your message has been received"]);
			}
			else
			{
				setMessage(false, "Contact failed", variables.instance.errors);		
			}
			
			return variables.instance.result;
		</cfscript>
	</cffunction>
	
	
	<cffunction name="validate" access="private" output="false" returnType="boolean">
	
		<cfscript>		
			if (NOT len(trim(variables.instance.name)))
			{
				arrayAppend(variables.instance.errors, "Please enter your name");
			}
			if (NOT len(trim(variables.instance.email)) OR NOT isValid("email", trim(variables.instance.email)))
			{
				arrayAppend(variables.instance.errors, "Please enter a valid email");
			}
			
			if (arrayLen(variables.instance.errors))
			{
				variables.instance.validated = false;
			}
		
			return variables.instance.validated;
		</cfscript>
	</cffunction>


	<cffunction name="save" access="private" output="false" returnType="void">
		
		<cfset var q = "">

		<cftry>
			<cfquery name="q" datasource="#variables.instance.dsn#">
				INSERT INTO	tbl_contacts
				(
					name
					, email
					, comments
					, dateTimeCreated
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.instance.name#">
					, <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.instance.email#">
					, <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.instance.comments#">
					, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
				)
			</cfquery>
			
			<cfcatch type="any">
				<cfdump var="#cfcatch#">
			</cfcatch>
		</cftry>
	</cffunction>


	<cffunction name="sendConfirmation" access="private" output="false" returnType="void">

		<cfmail attributeCollection="#variables.instance.mail#">
<cfoutput>
<p>Hi there,</p>
<p>Thanks for your message</p>
</cfoutput>
		</cfmail>
	</cffunction>
	
	
	<cffunction name="setMessage" access="private" output="false" returnType="void">
		<cfargument name="status" type="boolean" required="true">
		<cfargument name="message" type="string" required="true">
		<cfargument name="messages" type="array" required="true">

		<cfscript>
			variables.instance.result.status = arguments.status;
			variables.instance.result.message = arguments.message;
			variables.instance.result.messages = arguments.messages;
		</cfscript>
	</cffunction>
	

</cfcomponent>