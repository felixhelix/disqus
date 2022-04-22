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
<div id="disqus_privacy">
	<div id="disqus_toggle">
		<button type="button" id="disqus_switch" class="disqus activate">{translate key="plugins.generic.disqus.button.consent"}</button>
	</div>
	<div id="disqus_privacy_info">
		{translate key="plugins.generic.disqus.privacyInfo"}
	</div>
</div>

<script>

var disqus_config = function () {
	this.page.url = {$submissionUrl|json_encode};
	this.page.identifier = {$submissionId|json_encode};
};

var d = document;
var disqusToggle = d.getElementById('disqus_toggle');
var disqusPrivacy = d.getElementById('disqus_privacy');
var disqusPrivacyInfo = d.getElementById('disqus_privacy_info');
var disqusSwitch = d.getElementById('disqus_switch');
var disqusActive = false;

function loadDisqus() {
	/* disqus already loaded? */
	if (typeof DISQUS != "undefined") {
		DISQUS.reset({ reload: true });
	} else {
 	 	var s = d.createElement('script');
		s.src = '//{$disqusForumName|escape}.disqus.com/embed.js';
		s.setAttribute('data-timestamp', +new Date());
		(d.head || d.body).appendChild(s);
	}
	/* set disqus status */	
	disqusActive = true;			
	if ("{$disqusGDPR}" != "") {
		/* GDPR compliance selected */
		/* hide privacy message */
		disqusPrivacyInfo.style.display = "none";	
		/* set button css */
		disqusSwitch.className = "disqus deactivate";	
		disqusSwitch.textContent = "{translate key="plugins.generic.disqus.button.block"}";	
	} else {
		/* hide GDPR block */
		disqusPrivacy.style.display = "none";	
	}
}

function unloadDisqus() {
	/* set disqus status */	
	disqusActive = false;
	/* remove disqus contents */
	var discussFrame = d.getElementById('disqus_thread');
	while (discussFrame.firstChild) {
		discussFrame.firstChild.remove();     
	}
	var disqusRecommendations = d.getElementById('disqus_recommendations');
	disqusRecommendations.remove();
	/* remove disqus js */
	s = document.querySelector("[src='//{$disqusForumName|escape}.disqus.com/embed.js']");
	if (typeof s != "undefined") {
		(d.head || d.body).removeChild(s);
	}
	/* show privacy message */
	disqusPrivacyInfo.style.display = "block";	
	/* set button */
	disqusSwitch.className = "disqus activate";	
	disqusSwitch.textContent = "{translate key="plugins.generic.disqus.button.consent"}";	
}

if ("{$disqusGDPR}" != "") {
	/* GDPR compliance selected */
	/* check cookie status */
	if (document.cookie.split(';').some((item) => item.trim().startsWith('disqusConsent='))) {
		const cookieValue = document.cookie
			.split('; ')
			.find(row => row.startsWith('disqusConsent='))
			.split('=')[1];
		if (cookieValue == 'true') {
			/* user consented */
			loadDisqus();
		}
	}	
	/* toggle disqus */
	disqusSwitch.addEventListener('click', () => {
		if(disqusActive == false) {
			loadDisqus();		
			/* set session cookie to remember choice */
			d.cookie = 'disqusConsent=true; SameSite=strict; Secure";';
		} else {
			unloadDisqus();
			/* set session cookie to remember choice */
			d.cookie = 'disqusConsent=false; SameSite=strict; Secure";';
		}
	}); 
} else {
	/* no GDPR compliance selected */
	loadDisqus();
};

</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>