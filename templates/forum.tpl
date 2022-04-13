{**
 * plugins/generic/disqus/templates/forum.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * A template to be included under the abstract.
 *}
<div id="disqus_thread"></div>
<div id="toggle-switch">
	<input type="checkbox" class="toggle-switch-checkbox" id="disqus_active">
</div>
<div id="switch-content">
	<h3 class="switch-content-title">Redaktionell empfohlener externer Inhalt: Disqus Kommentar Funktion</h3>
	<p>Ich bin damit einverstanden, dass mir externe Inhalte von Disqus angezeigt werden. 
	Damit werden personenbezogene Daten an Drittplattformen übermittelt. Die Redaktion der MiDU hat darauf keinen Einfluss. 
	Näheres dazu lesen Sie in unserer <a title="privacy options" href="/datenschutz-112.html#datenschutz" target="_blank" rel="noopener noreferrer">Datenschutzerklärung</a>. 
	Sie können die Anzeige jederzeit wieder deaktivieren.</p>
</div>

<script>

var disqus_config = function () {ldelim}
	this.page.url = {$submissionUrl|json_encode};
	this.page.identifier = {$submissionId|json_encode};
{rdelim};

var d = document;
var disqus_active = d.getElementById('disqus_active');
var switchConent = d.getElementById('switch-content');

function loadDisqus() {
	/* include disqus js */
  	var s = d.createElement('script');
	s.src = '//{$disqusForumName|escape}.disqus.com/embed.js';
	s.setAttribute('data-timestamp', +new Date());
	(d.head || d.body).appendChild(s);
}

/* check if user already consented */
if (document.cookie.split(';').some((item) => item.trim().startsWith('disqusConsent='))) {
	const cookieValue = document.cookie
  		.split('; ')
  		.find(row => row.startsWith('disqusConsent='))
  		.split('=')[1];
	if (cookieValue == 'true') {
		loadDisqus();
		/* hide privacy message */
		switchConent.style.visibility = "hidden";	
		/* set checkbox */	
		disqus_active.checked = true;
	}
}	

/* toggle disqus */
disqus_active.addEventListener('change', () => {
	if(disqus_active.checked) {
		/* already loaded? */
		if (typeof DISQUS != "undefined") {
			DISQUS.reset({
				reload: true
			});
		}
		else {
			/* load disqus */
			loadDisqus();
		}
		/* hide privacy message */
		switchConent.style.visibility = "hidden";
		/* set session cookie to remember choice */
		d.cookie = 'disqusConsent=true; SameSite=strict; Secure";';
	} else {
		var discuss_frame = d.getElementById('disqus_thread');
		while (discuss_frame.firstChild) {
  			discuss_frame.firstChild.remove();     
		}
		s = document.querySelector("[src='//{$disqusForumName|escape}.disqus.com/embed.js']");
		if (typeof s != "undefined") {
			(d.head || d.body).removeChild(s);
		}
		/* show privacy message */
		switchConent.style.visibility = "unset";	
		/* set session cookie to remember choice */
		d.cookie = 'disqusConsent=false; SameSite=strict; Secure";';
	}
});

</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>