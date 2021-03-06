			</section>
			<!-- CONTENT -->
		</div>
	</div>
	<!-- /MAIN -->
	
	<!-- FOOTER -->
	<footer id="pageFooter" class="layoutFluid footer">
		<nav id="footerNavigation" class="navigation navigationFooter clearfix">
			<ul class="navigationIcons">
				<li id="toTopLink" class="toTopLink"><a href="{$__wcf->getAnchor('top')}" title="{lang}wcf.global.scrollUp{/lang}" class="jsTooltip"><img src="{@$__wcf->getPath()}icon/toTop.svg" alt="" class="icon16" /> <span class="invisible">{lang}wcf.global.scrollUp{/lang}</span></a></li>
				{if PACKAGE_ID && SHOW_CLOCK}
					<li class="separator"><p><img src="{@$__wcf->getPath()}icon/time.svg" alt="" class="icon16" /> <span>{@TIME_NOW|plainTime}</span></p></li>
				{/if}
			</ul>
		</nav>
		
		<div class="footerContent">
			{if PACKAGE_ID && ENABLE_BENCHMARK}{include file='benchmark' sandbox=false}{/if}
			
			<address class="copyright marginTop"><a href="http://www.woltlab.com" title="Go to the WoltLab website">Copyright &copy; 2001-2012 WoltLab&reg; GmbH</a></address>
		</div>
	</footer>
	<!-- /FOOTER -->
	<a id="bottom"></a>
</body>
</html>
