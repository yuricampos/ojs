{**
 * templates/editor/issues/issueData.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form for creation and modification of an issue
 *}
{strip}
{assign var="pageTitleTranslated" value=$issue->getIssueIdentification()}
{assign var="pageCrumbTitleTranslated" value=$issue->getIssueIdentification(false,true)}
{include file="common/header.tpl"}
{/strip}

{if !$isLayoutEditor}{* Layout Editors can also access this page. *}
	<div id="editor_top_menu">
		<ul class="nav nav-pills">
			<li><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
			<li{if $unpublished} class="active"{/if}><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
			<li{if !$unpublished} class="active"{/if}><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
		</ul>
	</div>
{/if}
<br />

<form action="#" style="text-align:right;">
{translate key="issue.issue"}: <select name="issue" class="selectMenu" onchange="if(this.options[this.selectedIndex].value > 0) location.href='{url|escape:"javascript" op="issueToc" path="ISSUE_ID" escape=false}'.replace('ISSUE_ID', this.options[this.selectedIndex].value)" size="1">{html_options options=$issueOptions|truncate:40:"..." selected=$issueId}</select>
</form>

<br/>

<div id="editor_top_menu">
	<ul class="nav nav-pills">
		<li><a href="{url op="issueToc" path=$issueId}">{translate key="issue.toc"}</a></li>
		<li class="active"><a href="{url op="issueData" path=$issueId}">{translate key="editor.issues.issueData"}</a></li>
		<li><a href="{url op="issueGalleys" path=$issueId}">{translate key="editor.issues.galleys"}</a></li>
		{if $unpublished}<li><a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">{translate key="editor.issues.previewIssue"}</a></li>{/if}
	</ul>
</div>

<div class="issue_create_form" style="font-size:12px;">
<form id="issue" method="post" action="{url op="editIssue" path=$issueId}" enctype="multipart/form-data">
<input type="hidden" name="fileName[{$formLocale|escape}]" value="{$fileName[$formLocale]|escape}" />
<input type="hidden" name="originalFileName[{$formLocale|escape}]" value="{$originalFileName[$formLocale]|escape}" />
{if $styleFileName}
<input type="hidden" name="styleFileName" value="{$styleFileName|escape}" />
<input type="hidden" name="originalStyleFileName" value="{$originalStyleFileName|escape}" />
{/if}
{include file="common/formErrors.tpl"}
<div id="issue_identification">
	<div class="arrow_down_box">
		<h3>{translate key="editor.issues.identification"}</h3>
	</div>

{if count($formLocales) > 1}
<div class="control-group">
	<label class="control-label">{fieldLabel name="formLocale" key="form.formLanguage"}</label>
	<div class="controls">
		{url|assign:"issueUrl" op="issueData" path=$issueId escape=false}
		{form_language_chooser form="issue" url=$issueUrl}
		<span class="help-block">{translate key="form.formLanguage.description"}</span>
	</div>
</div>
{/if}
	<div class="control-group">
		<label class="control-label">{fieldLabel name="volume" key="issue.volume"}</label>
		<div class="controls"><input type="text" name="volume" id="volume" value="{$volume|escape}" size="5" maxlength="5" class="textField" /></div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="number" key="issue.number"}</label>
		<div class="controls"><input type="text" name="number" id="number" value="{$number|escape}" size="5" maxlength="10" class="textField" /></div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="year" key="issue.year"}</label>
		<div class="controls"><input type="text" name="year" id="year" value="{$year|escape}" size="5" maxlength="4" class="textField" /></div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="labelFormat" key="editor.issues.issueIdentification"}</label>		
		<label class="checkbox" for="showVolume"><input type="checkbox" name="showVolume" id="showVolume" value="1"{if $showVolume} checked="checked"{/if} />{translate key="issue.volume"}</label>
		<label class="checkbox" for="showNumber"><input type="checkbox" name="showNumber" id="showNumber" value="1"{if $showNumber} checked="checked"{/if} />{translate key="issue.number"}</label>
		<label class="checkbox" for="showYear"><input type="checkbox" name="showYear" id="showYear" value="1"{if $showYear} checked="checked"{/if} />{translate key="issue.year"}</label>
		<label class="checkbox" for="showTitle"><input type="checkbox" name="showTitle" id="showTitle" value="1"{if $showTitle} checked="checked"{/if} />{translate key="issue.title"}</label>
	</div>
	{if $enablePublicIssueId}
	<div class="control-group">
		<label class="control-label">{fieldLabel name="publicIssueId" key="editor.issues.publicIssueIdentifier"}</label>
		<div class="controls"><input type="text" name="publicIssueId" id="publicIssueId" value="{$publicIssueId|escape}" size="20" maxlength="255" class="textField" /></div>
	</div>
	{/if}
	<div class="control-group">
		<label class="control-label">{fieldLabel name="title" key="issue.title"}</label>
		<div class="controls"><input type="text" name="title[{$formLocale|escape}]" id="title" value="{$title[$formLocale]|escape}" size="40" maxlength="120" class="textField" /></div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="description" key="editor.issues.description"}</label>
		<div class="controls"><textarea name="description[{$formLocale|escape}]" id="description" cols="40" rows="5" class="textArea">{$description[$formLocale]|escape}</textarea></div>
	</div>
	<div class="control-group">
		<label class="control-label">{translate key="common.status"}</label>
		<div class="controls">
			{if $issue->getPublished()}
				<p style="text-tranform:uppercase">{translate key="editor.issues.published"}<br/><br/>
				{* Find good values for starting and ending year options *}
				{assign var=currentYear value=$smarty.now|date_format:"%Y"}
				{if $datePublished}
					{assign var=publishedYear value=$datePublished|date_format:"%Y"}
					{math|assign:"minYear" equation="min(x,y)-10" x=$publishedYear y=$currentYear}
					{math|assign:"maxYear" equation="max(x,y)+2" x=$publishedYear y=$currentYear}
				{else}
					{* No issue publication date info *}
					{math|assign:"minYear" equation="x-10" x=$currentYear}
					{math|assign:"maxYear" equation="x+2" x=$currentYear}
				{/if}
				{html_select_date prefix="datePublished" time=$datePublished|default:"---" all_extra="class=\"selectMenu\"" start_year=$minYear end_year=$maxYear year_empty="-" month_empty="-" day_empty="-"}
			{else}
				{translate key="editor.issues.unpublished"}
			{/if}

			{if $issue->getDateNotified()}
				<br/>
				{translate key="editor.usersNotified"}&nbsp;&nbsp;
				{$issue->getDateNotified()|date_format:$dateFormatShort}
			{/if}
		</div>
	</div>

</div>

{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION}
<div class="separator"></div>
<div id="issue_access">
	<div class="arrow_down_box">
		<h3>{translate key="editor.issues.access"}</h3>
	</div>
<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="accessStatus" key="editor.issues.accessStatus"}</td>
		<td width="80%" class="value"><select name="accessStatus" id="accessStatus" class="selectMenu">{html_options options=$accessOptions selected=$accessStatus}</select></td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="openAccessDate" key="editor.issues.accessDate"}</td>
		<td class="value">
			<input type="checkbox" id="enableOpenAccessDate" name="enableOpenAccessDate" {if $openAccessDate}checked="checked" {/if}onchange="document.getElementById('issue').openAccessDateMonth.disabled=this.checked?false:true;document.getElementById('issue').openAccessDateDay.disabled=this.checked?false:true;document.getElementById('issue').openAccessDateYear.disabled=this.checked?false:true;" />&nbsp;{fieldLabel name="enableOpenAccessDate" key="editor.issues.enableOpenAccessDate"}<br/>
			{if $openAccessDate}
				{html_select_date prefix=openAccessDate time=$openAccessDate end_year="+20" all_extra="class=\"selectMenu\""}
			{else}
				{html_select_date prefix=openAccessDate time=$openAccessDate end_year="+20" all_extra="class=\"selectMenu\" disabled=\"disabled\""}
			{/if}
		</td>
	</tr>
</table>
</div>
{/if}

{foreach from=$pubIdPlugins item=pubIdPlugin}
	{assign var=pubIdMetadataFile value=$pubIdPlugin->getPubIdMetadataFile()}
	{include file="$pubIdMetadataFile" pubObject=$issue}
{/foreach}

{call_hook name="Templates::Editor::Issues::IssueData::AdditionalMetadata"}

<div id="issue_cover">
	<div class="arrow_down_box">
		<h3>{translate key="editor.issues.cover"}</h3>
	</div>
	<div class="control-group">
		<label class="control-label" for="showCoverPage">{translate key="editor.issues.showCoverPage"}</label>
		<div class="controls"><input type="checkbox" name="showCoverPage[{$formLocale|escape}]" id="showCoverPage" value="1" {if $showCoverPage[$formLocale]} checked="checked"{/if} /> </div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="coverPage" key="editor.issues.coverPage"}</label>
		<span class="btn btn-file btn-small"><input type="file" name="coverPage" id="coverPage" class="uploadField" />{translate key="plugins.block.navigation.journalContent"}</span><br />{translate key="form.saveToUpload"}<br />{translate key="editor.issues.coverPageInstructions"}<br />{translate key="editor.issues.uploaded"}:&nbsp;{if $fileName[$formLocale] }<a href="javascript:openWindow('{$publicFilesDir}/{$fileName[$formLocale]|escape:"url"}');" class="file">{$originalFileName[$formLocale]}</a>&nbsp;<a href="{url op="removeIssueCoverPage" path=$issueId|to_array:$formLocale}" onclick="return confirm('{translate|escape:"jsparam" key="editor.issues.removeCoverPage"}')">{translate key="editor.issues.remove"}</a>{else}&mdash;{/if}
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="coverPageAltText" key="common.altText"}</label>
		<div class="controls"><input type="text" name="coverPageAltText[{$formLocale|escape}]" value="{$coverPageAltText[$formLocale]|escape}" size="40" maxlength="255" class="textField" />
		<span class="help-block">{translate key="common.altTextInstructions"}</span></div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="styleFile" key="editor.issues.styleFile"}</label>
		<span class="btn btn-file btn-small"><input type="file" name="styleFile" id="styleFile" class="uploadField" />{translate key="plugins.block.navigation.journalContent"}</span><br />{translate key="form.saveToUpload"}<br />{translate key="editor.issues.uploaded"}:&nbsp;{if $styleFileName}<a href="javascript:openWindow('{$publicFilesDir}/{$styleFileName|escape}');" class="file">{$originalStyleFileName|escape}</a>&nbsp;<a href="{url op="removeStyleFile" path=$issueId}" onclick="return confirm('{translate|escape:"jsparam" key="editor.issues.removeStyleFile"}')">{translate key="editor.issues.remove"}</a>{else}&mdash;{/if}
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="coverPageDescription" key="editor.issues.coverPageCaption"}</label>
		<div class="controls"><textarea name="coverPageDescription[{$formLocale|escape}]" id="coverPageDescription" cols="40" rows="5" class="textArea">{$coverPageDescription[$formLocale]|escape}</textarea></div>
		</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="hideCoverPageArchives" key="editor.issues.coverPageDisplay"}</label>
		<label class="checkbox" for="hideCoverPageArchives"><input type="checkbox" name="hideCoverPageArchives[{$formLocale|escape}]" id="hideCoverPageArchives" value="1" {if $hideCoverPageArchives[$formLocale]} checked="checked"{/if} />{translate key="editor.issues.hideCoverPageArchives"}</label>
		<label class="checkbox"  for="hideCoverPageCover"><input type="checkbox" name="hideCoverPageCover[{$formLocale|escape}]" id="hideCoverPageCover" value="1" {if $hideCoverPageCover[$formLocale]} checked="checked"{/if} /> {translate key="editor.issues.hideCoverPageCover"}</label>
	</div>

</div>

<div class="save">
	<div class="arrow_down_box">
		<h3>{translate key="common.save"}</h3>
	</div>
	<p><input type="button" value="{translate key="common.cancel"}" onclick="document.location.href='{url op="issueData" path=$issueId escape=false}'" class="btn btn-danger btn-small" /> <input type="submit" value="{translate key="common.save"}" class="btn btn-small" /></p>
	<p><span class="formRequired">{translate key="common.requiredField"}</span></p>
</div>
</form>
</div>
{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
