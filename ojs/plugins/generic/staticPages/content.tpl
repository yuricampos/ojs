{**
 * plugins/generic/staticPages/content.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display Static Page content
 *
 *}
{assign var="pageTitleTranslated" value=$title}
{include file="common/header.tpl"}

{$content}

{include file="common/footer.tpl"}
