{**
 * plugins/generic/disqus/settingsForm.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Disqus plugin settings
 *
 *}
<script>
	$(function() {ldelim}
		// Attach the form handler.
		$('#disqusSettingsForm').pkpHandler('$.pkp.controllers.form.AjaxFormHandler');
	{rdelim});
</script>

<form class="pkp_form" id="disqusSettingsForm" method="post" action="{url router=$smarty.const.ROUTE_COMPONENT op="manage" category="generic" plugin=$pluginName verb="settings" save=true}">
	{csrf}
	{include file="controllers/notification/inPlaceNotification.tpl" notificationId="disqusSettingsFormNotification"}

	<div id="description">{translate key="plugins.generic.disqus.manager.settings.description"}</div>

	{fbvFormArea id="disqusSettingsFormArea"}
		{fbvElement id="disqusForumName" type="text" name="disqusForumName" value=$disqusForumName label="plugins.generic.disqus.manager.settings.disqusForumName"}
	{/fbvFormArea}

	<div id="descriptionPrivacy">{translate key="plugins.generic.disqus.manager.settings.descriptionPrivacy"}</div>
	{fbvFormSection id="disqusSettingsFormAreaPrivacy" list=true}
		{fbvElement id="disqusGDPR" name="disqusGDPR" type="checkbox" value="1" checked=$disqusGDPR label="plugins.generic.disqus.manager.settings.disqusForumPrivacy" translate=true class="checkbox_and_radiobutton"}
	{/fbvFormSection}

	{fbvFormButtons}

	<p><span class="formRequired">{translate key="common.requiredField"}</span></p>
</form>
