<cfsetting enablecfoutputonly="true">
<!---
	Name			: message.cfm
	Author			: Michael Sharman
	Created			: September 11, 2011
	Last Updated		: September 11, 2011
	History			: Initial release (mps 11/09/2011)
	Purpose			: Displays a list of messages and a heading. Most useful for validation error messages but can be used for anything
	Usage			: Typically called via a custom tag import:
						<cfimport taglib="[path_to_tags_folder]" prefix="tags">
						<tags:message data="#data_struct#">
						
						The "data" attribute expected is a structure with 3 arguments
							1. Message [string] which is the label/heading of the message block
							2. Errors [array] is an ordered list of messages (each element must be a string)
							3. Status [bool] useful to set a css class defining the message type
							
						You may also pass an "id" or "class" value for the surrounding div:
							<tags:message data="#data_struct#" id="myId" class="myclass">
						This is handy if you want to use the tag for "error", "success" or "information" messages etc
						The default "true" class is "message-success", the "false" is "message-error"
 --->

<cfparam name="attributes.id" default="message-box">
<cfparam name="attributes.class" default="">

<cfif NOT structKeyExists(attributes, "data") OR NOT isValid("struct", attributes.data) OR structIsEmpty(attributes.data)>
	<cfexit>
</cfif>

<!--- Set the css class based on the status, unless it's been passed into the custom tag --->
<cfif NOT len(trim(attributes.class))>
	<cfif structKeyExists(attributes.data, "status") AND isValid("boolean", attributes.data.status) AND attributes.data.status>
		<cfset attributes.class = "message-success">
	<cfelse>
		<cfset attributes.class = "message-error">
	</cfif>
</cfif>

<cfoutput>
<div id="#attributes.id#" class="#attributes.class#">
	<cfif structKeyExists(attributes.data, "message") AND len(trim(attributes.data.message))>
		<h3>#attributes.data.message#</h3>
	</cfif>
	<cfif structKeyExists(attributes.data, "messages") AND isValid("array", attributes.data.messages) AND arrayLen(attributes.data.messages)>
		<ul>
			<cfloop array="#attributes.data.messages#" index="i">
				<cfif len(trim(i))>
					<li>#i#</li>
				</cfif>
			</cfloop>
		</ul>
	</cfif>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false">