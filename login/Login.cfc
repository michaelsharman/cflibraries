<cfcomponent output="false" hint="Transient class to process logon attempts">

	
	<cffunction name="init" access="public" output="false" returnType="Login">
		<cfargument name="dsn" type="string" required="true">
		
		<cfscript>
			variables.instance = {
				username = ""
				, password = ""
				, dsn = arguments.dsn
				, loggedIn = false
				, validated = true
			};
			variables.instance.result = {};
			variables.instance.errors = [];
			
			return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="authenticate" access="private" output="false" returnType="boolean">
		
		<cfset var q = "">

		<cftry>
	
			<cfquery name="q" datasource="#variables.instance.dsn#">
				SELECT	id
				FROM	tbl_login
				WHERE	username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.instance.username#">
				AND		password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.instance.password#">
			</cfquery>
			
			<cfif q.recordCount>
				<cfset variables.instance.loggedIn = true>
			</cfif>
			
			<cfcatch type="any">
				<cfdump var="#cfcatch#">
				<!--- FOR DEVELOPMENT ONLY!!! --->
				<cfset variables.instance.loggedIn = true>
			</cfcatch>
		</cftry>
		
		<cfreturn variables.instance.loggedIn>
	</cffunction>


	<cffunction name="doLogin" access="public" output="false" returnType="struct">
		<cfargument name="user" type="string" required="true">
		<cfargument name="pass" type="string" required="true">
		
		<cfscript>
			variables.instance.username = trim(arguments.user);
			variables.instance.password = trim(arguments.pass);
			
			if (validate())
			{
				if (authenticate())
				{
					variables.instance.result.status = true;
				}
				else
				{
					setMessage(false, "Login failed", variables.instance.errors);
				}
			}
			else
			{
				setMessage(false, "Login failed", variables.instance.errors);
			}
			
			return variables.instance.result;
		</cfscript>
	</cffunction>
	
	
	<cffunction name="validate" access="private" output="false" returnType="boolean">
	
		<cfscript>		
			if (NOT len(trim(variables.instance.username)))
			{
				arrayAppend(variables.instance.errors, "Please enter a username");
			}
			if (NOT len(trim(variables.instance.password)))
			{
				arrayAppend(variables.instance.errors, "Please enter a password");
			}
			
			if (arrayLen(variables.instance.errors))
			{
				variables.instance.validated = false;
			}
		
			return variables.instance.validated;
		</cfscript>
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