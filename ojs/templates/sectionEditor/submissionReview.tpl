{**
 * templates/sectionEditor/submissionReview.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Submission review.
 *
 *}
{strip}
{translate|assign:"pageTitleTranslated" key="submission.page.review" id=$submission->getId()}{assign var="pageCrumbTitle" value="submission.review"}
{include file="common/header.tpl"}
{/strip}

<div id="editor_top_menu">
	<ul class="nav nav-pills">
		<li><a href="{url op="submission" path=$submission->getId()}">{translate key="submission.summary"}</a></li>
		<li class="active"><a href="{url op="submissionReview" path=$submission->getId()}">{translate key="submission.review"}</a></li>
		{if $canEdit}<li><a href="{url op="submissionEditing" path=$submission->getId()}">{translate key="submission.editing"}</a></li>{/if}
		<li><a href="{url op="submissionHistory" path=$submission->getId()}">{translate key="submission.history"}</a></li>
		<li><a href="{url op="submissionCitations" path=$submission->getId()}">{translate key="submission.citations"}</a></li>
	</ul>
</div>
{include file="sectionEditor/submission/peerReview.tpl"}

<div class="separator"></div>

{include file="sectionEditor/submission/editorDecision.tpl"}

{include file="common/footer.tpl"}

{* MODIFICADO OJS V.2.4.2 / 04-2013*}