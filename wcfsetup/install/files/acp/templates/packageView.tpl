{include file='header'}

<script type="text/javascript">
	//<![CDATA[
	$(function() {
		WCF.TabMenu.init()
		
		new WCF.ACP.Package.Uninstallation($('.jsPackageRow .jsUninstallButton'));
	});
	//]]>
</script>

<header class="wcf-container wcf-mainHeading">
	<img src="{@$__wcf->getPath()}icon/packageApplication1.svg" alt="" class="wcf-containerIcon" /><!-- ToDo: Add possibility to show a custom app icon if given! -->
	<hgroup class="wcf-containerContent">
		<h1>{$package->getName()}</h1>
		<h2>{$package->packageDescription|language}</h2>
	</hgroup>
</header>

<div class="wcf-tabMenuContainer">
	<nav class="wcf-tabMenu">
		<ul>
			<li><a href="#information">{lang}wcf.acp.package.information.title{/lang}</a></li>
			{if $package->getRequiredPackages()|count || $package->getDependentPackages()|count}
				<li><a href="#dependencies">{lang}wcf.acp.package.dependencies.title{/lang}</a></li>
			{/if}
		</ul>
	</nav>

	<div id="information" class="wcf-box wcf-boxPadding wcf-tabMenuContent hidden">
		<hgroup class="wcf-subHeading">
			<h1>{lang}wcf.acp.package.information.title{/lang}</h1>
		</hgroup>

		<fieldset>
			<legend>{lang}wcf.acp.package.information.properties{/lang}</legend>
	
			<dl>
				<dt>{lang}wcf.acp.package.identifier{/lang}</dt>
				<dd>{$package->package}</dd>
			</dl>
			<dl>
				<dt>{lang}wcf.acp.package.version{/lang}</dt>
				<dd>{$package->packageVersion}</dd>
			</dl>
			{if $package->instanceNo > 1}
				<dl>
					<dt>{lang}wcf.acp.package.instanceNo{/lang}</dt>
					<dd>{#$package->instanceNo}</dd>
				</dl>
			{elseif $package->package == 'com.woltlab.wcf' && WCF_N != 1}
				<dl>
					<dt>{lang}wcf.acp.package.instanceNo{/lang}</dt>
					<dd>{#WCF_N}</dd>
				</dl>
			{/if}
			<dl>
				<dt>{lang}wcf.acp.package.packageDate{/lang}</dt>
				<dd>{@$package->packageDate|date}</dd>
			</dl>
			<dl>
				<dt>{lang}wcf.acp.package.installDate{/lang}</dt>
				<dd>{@$package->installDate|time}</dd>
			</dl>
			<dl>
				<dt>{lang}wcf.acp.package.updateDate{/lang}</dt>
				<dd>{@$package->updateDate|time}</dd>
			</dl>
			{if $package->packageURL != ''}
				<dl>
					<dt>{lang}wcf.acp.package.url{/lang}</dt>
					<dd><a href="{@$__wcf->getPath()}acp/dereferrer.php?url={$package->packageURL|rawurlencode}" class="wcf-externalURL">{$package->packageURL}</a></dd>
				</dl>
			{/if}
			{if $package->parentPackageID}
				<dl>
					<dt>{lang}wcf.acp.package.parentPackage{/lang}</dt>
					<dd><a href="{link controller='PackageView' id=$package->parentPackageID}{/link}">{$package->getParentPackage()->getName()}</a></dd>
				</dl>
			{/if}
			<dl>
				<dt>{lang}wcf.acp.package.author{/lang}</dt>
				<dd>{if $package->authorURL}<a href="{@$__wcf->getPath()}acp/dereferrer.php?url={$package->authorURL|rawurlencode}" class="wcf-externalURL">{$package->author}</a>{else}{$package->author}{/if}</dd>
			</dl>
	
			{event name='propertyFields'}
		</fieldset>

		{if $package->packageDescription|language}
			<hgroup class="wcf-subHeading">
				<h1>{lang}wcf.acp.package.description{/lang}</h1>
			</hgroup>

			<p>{$package->packageDescription|language}</p>
		{/if}
	</div>

	{if $package->getRequiredPackages()|count || $package->getDependentPackages()|count}
		<div id="dependencies" class="wcf-box wcf-boxPadding wcf-tabMenuContainer wcf-tabMenuContent">
			<nav class="wcf-menu">
				<ul>
					{if $package->getRequiredPackages()|count}
						<li><a href="#dependencies-required">{lang}wcf.acp.package.dependencies.required{/lang}</a></li>
					{/if}
					{if $package->getDependentPackages()|count}
						<li><a href="#dependencies-dependent">{lang}wcf.acp.package.dependencies.dependent{/lang}</a></li>
					{/if}
				</ul>
			</nav>

			{hascontent}
				<div id="dependencies-required" class="wcf-hidden">
					<hgroup class="wcf-subHeading">
						<h1>{lang}wcf.acp.package.dependencies.required{/lang}</h1>
						<h2>{lang}wcf.acp.package.dependencies.required.description{/lang}</h2>
					</hgroup>
		
					<table class="wcf-table wcf-box wcf-boxTitle wcf-marginTop wcf-shadow1">
						<thead>
							<tr>
								<th colspan="2" class="columnID">{lang}wcf.global.objectID{/lang}</th>
								<th colspan="2" class="columnTitle">{lang}wcf.acp.package.name{/lang}</th>
								<th class="columnText">{lang}wcf.acp.package.author{/lang}</th>
								<th class="columnText">{lang}wcf.acp.package.version{/lang}</th>
								<th class="columnDigits">{lang}wcf.acp.package.packageDate{/lang}</th>
								
								{event name='requirementHeadColumns'}
							</tr>
						</thead>
			
						<tbody>
							{content}
								{foreach from=$package->getRequiredPackages() item=requiredPackage}
									<tr class="jsPackageRow">
										<td class="columnIcon">
											{if $__wcf->session->getPermission('admin.system.package.canUpdatePackage')}
												<a href="{link controller='PackageStartInstall' id=$requiredPackage->packageID}action=update{/link}"><img src="{@$__wcf->getPath()}icon/update1.svg" alt="" title="{lang}wcf.acp.package.button.update{/lang}" class="jsTooltip" /></a>
											{else}
												<img src="{@$__wcf->getPath()}icon/update1D.svg" alt="" title="{lang}wcf.acp.package.button.update{/lang}" />
											{/if}
											{if $__wcf->session->getPermission('admin.system.package.canUninstallPackage') && $requiredPackage->package != 'com.woltlab.wcf' && $requiredPackage->packageID != PACKAGE_ID}
												<img src="{@$__wcf->getPath()}icon/delete1.svg" alt="" title="{lang}wcf.acp.package.button.uninstall{/lang}" class="jsTooltip jsUninstallButton" data-objectID="{@$requiredPackage->packageID}" data-confirm-message="{lang package=$requiredPackage}wcf.acp.package.uninstallation.confirm{/lang}" />
											{else}
												<img src="{@$__wcf->getPath()}icon/delete1D.svg" alt="" title="{lang}wcf.acp.package.button.uninstall{/lang}" />
											{/if}
										</td>
										<td class="columnID"><p>{@$requiredPackage->packageID}</p></td>
										<td class="columnIcon">
											{if $requiredPackage->isApplication}
												<img src="{@$__wcf->getPath()}icon/packageApplication1.svg" alt="" title="{lang}wcf.acp.package.type.application{/lang}" class="jsTooltip" />
											{elseif $requiredPackage->parentPackageID}
												<img src="{@$__wcf->getPath()}icon/packagePlugin1.svg" alt="" title="{lang}wcf.acp.package.type.plugin{/lang}" class="jsTooltip" />
											{else}
												<img src="{@$__wcf->getPath()}icon/package1.svg" alt="" title="{lang}wcf.acp.package.type.other{/lang}" class="jsTooltip" />
											{/if}
										</td>
										<td class="columnTitle" title="{$requiredPackage->packageDescription|language}"><p><a href="{link controller='PackageView' id=$requiredPackage->packageID}{/link}">{$requiredPackage->packageName|language}{if $requiredPackage->instanceNo > 1 && $requiredPackage->instanceName == ''} (#{#$requiredPackage->instanceNo}){/if}</a></p></td>
										<td class="columnText">{if $requiredPackage->authorURL}<p><a href="{@$__wcf->getPath()}acp/dereferrer.php?url={$requiredPackage->authorURL|rawurlencode}" class="wcf-externalURL">{$requiredPackage->author}</a>{else}{$requiredPackage->author}</p>{/if}</td>
										<td class="columnText"><p>{$requiredPackage->packageVersion}</p></td>
										<td class="columnDate"><p>{@$requiredPackage->packageDate|date}</p></td>
										
										{event name='requirementColumns'}
									</tr>
								{/foreach}
							{/content}
						</tbody>
					</table>
				</div>
			{/hascontent}

			{hascontent}
				<div id="dependencies-dependent" class="hidden">
					<hgroup class="wcf-subHeading">
						<h1>{lang}wcf.acp.package.dependencies.dependent{/lang}</h1>
						<h2>{lang}wcf.acp.package.dependencies.dependent.description{/lang}</h2>
					</hgroup>
		
					<table class="wcf-table wcf-box wcf-boxTitle wcf-marginTop wcf-shadow1">
						<thead>
							<tr>
								<th colspan="2" class="columnID">{lang}wcf.global.objectID{/lang}</th>
								<th colspan="2" class="columnTitle">{lang}wcf.acp.package.name{/lang}</th>
								<th class="columnText">{lang}wcf.acp.package.author{/lang}</th>
								<th class="columnText">{lang}wcf.acp.package.version{/lang}</th>
								<th class="columnDigits">{lang}wcf.acp.package.packageDate{/lang}</th>
								
								{event name='dependencyHeadColumns'}
							</tr>
						</thead>
			
						<tbody>
							{content}
								{foreach from=$package->getDependentPackages() item=dependentPackage}
									<tr class="jsPackageRow">
										<td class="columnIcon">
											{if $__wcf->session->getPermission('admin.system.package.canUpdatePackage')}
												<a href="{link controller='PackageStartInstall' id=$dependentPackage->packageID}action=update{/link}"><img src="{@$__wcf->getPath()}icon/update1.svg" alt="" title="{lang}wcf.acp.package.button.update{/lang}" class="jsTooltip" /></a>
											{else}
												<img src="{@$__wcf->getPath()}icon/update1D.svg" alt="" title="{lang}wcf.acp.package.button.update{/lang}" />
											{/if}
											{if $__wcf->session->getPermission('admin.system.package.canUninstallPackage') && $dependentPackage->package != 'com.woltlab.wcf' && $dependentPackage->packageID != PACKAGE_ID}
												<img src="{@$__wcf->getPath()}icon/delete1.svg" alt="" title="{lang}wcf.acp.package.button.uninstall{/lang}" class="jsTooltip jsUninstallButton" data-objectID="{@$dependentPackage->packageID}" data-confirm-message="{lang package=$dependentPackage}wcf.acp.package.uninstallation.confirm{/lang}" />
											{else}
												<img src="{@$__wcf->getPath()}icon/delete1D.svg" alt="" title="{lang}wcf.acp.package.button.uninstall{/lang}" />
											{/if}
										</td>
										<td class="columnID"><p>{@$dependentPackage->packageID}</p></td>
										<td class="columnIcon">
											{if $dependentPackage->isApplication}
												<img src="{@$__wcf->getPath()}icon/packageApplication1.svg" alt="" title="{lang}wcf.acp.package.type.application{/lang}" class="jsTooltip" />
											{elseif $dependentPackage->parentPackageID}
												<img src="{@$__wcf->getPath()}icon/packagePlugin1.svg" alt="" title="{lang}wcf.acp.package.type.plugin{/lang}" class="jsTooltip" />
											{else}
												<img src="{@$__wcf->getPath()}icon/package1.svg" alt="" title="{lang}wcf.acp.package.type.other{/lang}" class="jsTooltip" />
											{/if}
										</td>
										<td class="columnTitle" title="{$dependentPackage->packageDescription|language}"><p><a href="{link controller='PackageView' id=$dependentPackage->packageID}{/link}">{$dependentPackage->packageName|language}{if $dependentPackage->instanceNo > 1 && $dependentPackage->instanceName == ''} (#{#$dependentPackage->instanceNo}){/if}</a></p></td>
										<td class="columnText">{if $dependentPackage->authorURL}<p><a href="{@$__wcf->getPath()}acp/dereferrer.php?url={$dependentPackage->authorURL|rawurlencode}" class="wcf-externalURL">{$dependentPackage->author}</a>{else}{$dependentPackage->author}</p>{/if}</td>
										<td class="columnText"><p>{$dependentPackage->packageVersion}</p></td>
										<td class="columnDate"><p>{@$dependentPackage->packageDate|date}</p></td>
										
										{event name='dependencyColumns'}
									</tr>
								{/foreach}
							{/content}
						</tbody>
					</table>
				</div>
			{/hascontent}
		</div>
	{/if}
</div>

{assign var=noDependentIsActive value=true}
{foreach from=$package->getDependentPackages() item=dependentPackage}
	{if $dependentPackage->package != 'com.woltlab.wcf' && $dependentPackage->packageID == PACKAGE_ID}
		{assign var=noDependentIsActive value=false}
		{* TODO: maybe show users that this package can't be uninstalled because a dependent package is the active application *}
	{/if}
{/foreach}

<div class="wcf-contentFooter">
	<nav>
		<ul class="wcf-largeButtons">
			{if PACKAGE_ID != $package->packageID}
				{if $package->isApplication && $package->package != 'com.woltlab.wcf'}
					<li><a href="{@$__wcf->getPath()}{$package->packageDir}acp/index.php{@SID_ARG_1ST}" title="{lang}wcf.acp.package.button.switch{/lang}" class="wcf-button"><img src="{@$__wcf->getPath()}icon/packageACP1.svg" alt="" /> <span>{lang}wcf.acp.package.button.switch{/lang}</span></a></li>
				{/if}
				{if $__wcf->session->getPermission('admin.system.package.canUninstallPackage') && $noDependentIsActive}
					<li><a href="{link controller='Package'}action=startUninstall&packageID={@$package->packageID}{/link}" onclick="return confirm('{lang}wcf.acp.package.button.uninstall.sure{/lang}')" title="{lang}wcf.acp.package.button.uninstall{/lang}" class="wcf-button"><img src="{@$__wcf->getPath()}icon/delete1.svg" alt="" /> <span>{lang}wcf.acp.package.button.uninstall{/lang}</span></a></li>
				{/if}
			{/if}
			{if $__wcf->session->getPermission('admin.system.package.canUpdatePackage')}
				<li><a href="{link controller='PackageStartInstall' id=$package->packageID}action=update{/link}" title="{lang}wcf.acp.package.button.update{/lang}" class="wcf-button"><img src="{@$__wcf->getPath()}icon/update1.svg" alt="" /> <span>{lang}wcf.acp.package.button.update{/lang}</span></a></li>
			{/if}
			
			{event name='largeButtons'}
			
			<li><a href="{link controller='PackageList'}{/link}" title="{lang}wcf.acp.menu.link.package.list{/lang}" class="wcf-button"><img src="{@$__wcf->getPath()}icon/packageApplication1.svg" alt="" /> <span>{lang}wcf.acp.menu.link.package.list{/lang}</span></a></li>
		</ul>
	</nav>
</div>

{include file='footer'}
