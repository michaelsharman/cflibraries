<cfcomponent output="false">


	<cfscript>

		this.name = "lib_login";
		this.applicationTimeout = createTimeSpan(0,2,0,0);
		this.sessionManagement = true;
		this.sessionTimeout = createTimeSpan(0,0,20,0);
		this.setClientCookies = true;
		this.scriptProtect = false;
		this.mappings = structNew();
		this.customtagpaths = "";
	
	</cfscript>

	
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		
		<cfreturn true />
	</cffunction>


	<cffunction name="onApplicationEnd" returnType="void" output="false">
		
		<cfargument name="applicationScope" required="true" />
	</cffunction>


	<cffunction name="onMissingTemplate" returnType="boolean" output="false">
		<cfargument name="targetpage" required="true" type="string" />
		<cfreturn true />
	</cffunction>
	
	
	<cffunction name="onRequestStart" returnType="boolean" output="false">
		<cfargument name="thePage" type="string" required="true" />
		
		<cfscript>
			request.webroot = "/contact/";
		</cfscript>
		
		<cfreturn true />
	</cffunction>


	<cffunction name="onRequestEnd" returnType="void" output="false">
		
		<cfargument name="thePage" type="string" required="true" />
	</cffunction>


	<cffunction name="onError" returnType="void" output="false">
		<cfargument name="exception" required="true" />
		<cfargument name="eventname" type="string" required="true" />
		
		<cfdump var="#arguments#" /><cfabort />
	</cffunction>


	<cffunction name="onSessionStart" returnType="void" output="false">
	
	</cffunction>


	<cffunction name="onSessionEnd" returnType="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true" />
		<cfargument name="appScope" type="struct" required="false" />
	</cffunction>
	
	
</cfcomponent>