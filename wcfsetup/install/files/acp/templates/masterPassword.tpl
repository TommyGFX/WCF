{include file='header'}

<script type="text/javascript">
	//<![CDATA[
	$(function() {
		$('#masterPassword').focus();
	});
	//]]>
</script>

<header class="wcf-container wcf-mainHeading">
	<img src="{@$__wcf->getPath()}icon/login1.svg" alt="" class="wcf-containerIcon" />
	<hgroup class="wcf-containerContent">
		<h1>{lang}wcf.acp.masterPassword.enter{/lang}</h1>
	</hgroup>
</header>

{if $errorField != ''}
	<p class="wcf-error">{lang}wcf.global.form.error{/lang}</p>
{/if}

<form method="post" action="{link controller='MasterPassword'}{/link}">
	<div class="wcf-box wcf-marginTop wcf-boxPadding wcf-shadow1">
		
		<fieldset>
			<legend>{lang}wcf.acp.masterPassword.enter{/lang}</legend>
		
			<dl{if $errorField == 'masterPassword'} class="wcf-formError"{/if}>
				<dt><label for="masterPassword">{lang}wcf.acp.masterPassword{/lang}</label></dt>
				<dd>
					<input type="password" id="masterPassword" name="masterPassword" value="{$masterPassword}" class="medium" />
					{if $errorField == 'masterPassword'}
						<small class="wcf-innerError">
							{if $errorType == 'empty'}
								{lang}wcf.global.form.error.empty{/lang}
							{else}
								{lang}wcf.acp.masterPassword.error.{@$errorType}{/lang}
							{/if}
						</small>
					{/if}
					<small>{lang}wcf.acp.masterPassword.enter.description{/lang}</small>
				</dd>
			</dl>
			
			{event name='enterFields'}
		</fieldset>
		
		{event name='fieldsets'}
	</div>

	<div class="wcf-formSubmit">
		<input type="reset" value="{lang}wcf.global.button.reset{/lang}" accesskey="r" />
		<input type="submit" name="submitButton" value="{lang}wcf.global.button.submit{/lang}" accesskey="s" />
		{@SID_INPUT_TAG}
 		<input type="hidden" name="url" value="{$url}" />
 	</div>
</form>

{include file='footer'}
