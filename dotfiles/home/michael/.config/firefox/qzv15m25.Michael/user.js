/* Michael's user.js
 * plugin.override_internal_types
 */

/** Startup Settings **/
user_pref("browser.startup.page", 3);

/*****************************************************************************/

/** Hidden Features **/
/* Hold Shift + scroll to move faster, ALT + scroll to move very fast.*/
user_pref("mousewheel.acceleration.start", 4);
user_pref("mousewheel.with_alt.action.override_x", 1);
user_pref("mousewheel.with_alt.delta_multiplier_x", 10000);
user_pref("mousewheel.with_alt.delta_multiplier_y", 10000);
user_pref("mousewheel.with_shift.action", 1);
user_pref("mousewheel.with_shift.action.override_x", 1);
user_pref("mousewheel.with_shift.delta_multiplier_x", 500);
user_pref("mousewheel.with_shift.delta_multiplier_y", 500);

/* Instant in-page search - just start typing to activate */
user_pref("accessibility.typeaheadfind", true);
user_pref("accessibility.typeaheadfind.autostart", true);
user_pref("accessibility.typeaheadfind.casesensitive", 0);
user_pref("findbar.highlightAll", true);
user_pref("findbar.modalHighlight", true);

/* Unhide SSL expert error page */
user_pref("browser.xul.error_pages.expert_bad_cert", true);

/* Force websites to create new tabs rather than windows. */
/* All HTML links with target="_blank" and JavaScript calls to window.open() are
 * included. This might cause problems sometimes.*/
user_pref("browser.link.open_newwindow", 3);
user_pref("browser.link.open_newwindow.restriction", 3);

user_pref("layout.spellcheckDefault", 0);

// user_pref("dom.gamepad.enabled", true);

// Source Code
//user_pref("view_source.editor.external", true);
//user_pref("view_source.editor.path", "{EDITOR}");
user_pref("view_source.wrap_long_lines", true);

/* ??? */
user_pref("devtools.performance.ui.experimental", true);
user_pref("dom.experimental_forms", true);

/*****************************************************************************/


/** Appearance , UI **/
/* Font settings */
user_pref("browser.display.use_document_fonts", 0);
user_pref("font.default.x-western", "sans-serif");
user_pref("font.internaluseonly.changed", true);
user_pref("font.minimum-size.x-western", 12);
user_pref("font.name.monospace.x-western", "FuraCode Nerd Font");
user_pref("font.name.sans-serif.x-western", "Arimo Nerd Font");
user_pref("font.name.serif.x-western", "Tinos Nerd Font");
user_pref("font.size.variable.x-western", 12);

/* Don't hide UI in fullscreen.*/
user_pref("browser.fullscreen.autohide", false);


/* Smallest possible minimum tab size - best combined with an addon like Tree 
 * Style Tab.*/
user_pref("browser.tabs.tabMinWidth", 50);

/*****************************************************************************/

/** Performance Settings **/
user_pref("media.hardware-video-decoding.force-enabled", true);
user_pref("dom.ipc.processCount.web", 4);
user_pref("browser.cache.use_new_backend", 1);

/*****************************************************************************/

/* Increase number of persistent connections per server (default 6)
 * http://kb.mozillazine.org/Network.http.max-persistent-connections-per-server
 * supposedly "Anything above 10 is excessive.", but this doesn't seem to be
 * backed up and a few comments claim 22-25 connections are fine.*/
user_pref("network.http.max-persistent-connections-per-server", 10);



user_pref("browser.bookmarks.restore_default_bookmarks", false);
user_pref("browser.bookmarks.showMobileBookmarks", false);
user_pref("browser.download.hide_plugins_without_extensions", false);

user_pref("browser.eme.ui.firstContentShown", true);
user_pref("browser.feeds.showFirstRunUI", false);
user_pref("browser.migrated-sync-button", true);
user_pref("browser.migration.version", 59);

/* New Tab Page - Activity Stream*/
browser.newtabpage.activity-stream.enabled
browser.library.activity-stream.enabled
browser.newtabpage.activity-stream.disableSnippets
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.migrationExpired", true);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry.ping.endpoint", "");
user_pref("browser.newtabpage.activity-stream.topSitesCount", 36);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories.options", "{show_spocs\":false,\"personalized\":false}");

user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtabpage.introShown", true);
user_pref("browser.newtabpage.pinned", "[]");
user_pref("browser.newtabpage.storageVersion", 1);


user_pref("browser.onboarding.notification.prompt-count", 1);
user_pref("browser.onboarding.notification.tour-ids-queue", "");
user_pref("browser.onboarding.seen-tourset-version", 2);
user_pref("browser.onboarding.shieldstudy.enabled", false);
user_pref("browser.onboarding.state", "watermark");
user_pref("browser.onboarding.tour-type", "update");
user_pref("browser.onboarding.tour.onboarding-tour-customize.completed", true);
user_pref("browser.onboarding.tour.onboarding-tour-library.completed", true);
user_pref("browser.onboarding.tour.onboarding-tour-performance.completed", true);
user_pref("browser.onboarding.tour.onboarding-tour-screenshots.completed", true);
user_pref("browser.onboarding.tour.onboarding-tour-singlesearch.completed", true);
user_pref("browser.onboarding.tour.onboarding-tour-sync.completed", true);
user_pref("browser.reader.detectedFirstArticle", true);
user_pref("browser.rights.3.shown", true);



/** Search Options **/
/* URL Bar Search - change to only search through tabs and history*/
user_pref("browser.urlbar.maxRichResults", 40)
/* TODO
 * user_pref("browser.urlbar.searchSuggestionsChoice
user_pref("browser.urlbar.suggest.bookmark
browser.urlbar.suggest.openpage*/

/* Web Search*/
user_pref("browser.search.countryCode", "AU");
user_pref("browser.search.defaultenginename", "Google");
user_pref("browser.search.hiddenOneOffs", "Yahoo,Bing,Amazon.com,eBay,Twitter");
user_pref("browser.search.region", "AU");
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.search.useDBForOrder", true);
user_pref("browser.search.widget.inNavBar", true);

user_pref("browser.selfsupport.enabled", false);
user_pref("browser.sessionstore.interval", 150000);
user_pref("browser.shell.checkDefaultBrowser", true);
user_pref("browser.shell.didSkipDefaultBrowserCheckOnFirstRun", true);
user_pref("browser.syncPromoViewsLeftMap", "{\"passwords\":0,\"addons\":1,\"bookmarks\":0}");

user_pref("browser.tabs.delayHidingAudioPlayingIconMS", 0);

user_pref("browser.tabs.remote.autostart.2", true);
user_pref("browser.tabs.remote.force-enable", true);

user_pref("browser.tabs.remote.warmup.unloadDelayMs", 0);

user_pref("browser.toolbarbuttons.introduced.pocket-button", true);

user_pref("datareporting.healthreport.pendingDeleteRemoteData", true);
user_pref("datareporting.healthreport.service.firstRun", true);
user_pref("datareporting.policy.dataSubmissionPolicyAcceptedVersion", 2);

/* Developer Tools Settings */
user_pref("devtools.cache.disabled", true);
user_pref("devtools.chrome.enabled", true);
user_pref("devtools.command-button-frames.enabled", false);
user_pref("devtools.command-button-rulers.enabled", true);
user_pref("devtools.debugger.remote-enabled", false);
user_pref("devtools.dom.enabled", true);
user_pref("devtools.editor.autoclosebrackets", false);
user_pref("devtools.editor.tabsize", 4);
user_pref("devtools.gcli.hideIntro", true);
user_pref("devtools.inspector.activeSidebar", "layoutview");
user_pref("devtools.inspector.showUserAgentStyles", true);
user_pref("devtools.layout.grid.opened", false);
user_pref("devtools.netmonitor.panes-network-details-height", 50);
user_pref("devtools.promote.layoutview", 0);
user_pref("devtools.promote.layoutview.showPromoteBar", false);
user_pref("devtools.scratchpad.recentFilesMax", 15);
user_pref("devtools.screenshot.audio.enabled", false);
user_pref("devtools.selfxss.count", 5);
user_pref("devtools.storage.enabled", false);
user_pref("devtools.theme", "light");
user_pref("devtools.toolbox.footer.height", 341);
user_pref("devtools.toolbox.previousHost", "window");
user_pref("devtools.toolbox.splitconsoleHeight", 161);
user_pref("devtools.toolsidebar-height.inspector", 150);
user_pref("devtools.toolsidebar-width.inspector", 450);
user_pref("devtools.toolsidebar-width.netmonitor", 0);
user_pref("devtools.toolsidebar-width.webconsole", 363);
user_pref("devtools.webconsole.filter.csserror", false);
user_pref("devtools.webconsole.filter.jswarn", false);
user_pref("devtools.webconsole.filter.networkinfo", true);
user_pref("devtools.webconsole.filter.netxhr", true);
user_pref("devtools.webconsole.filter.secerror", false);
user_pref("devtools.webconsole.filter.secwarn", false);
user_pref("devtools.webconsole.filter.serviceworkers", false);
user_pref("devtools.webconsole.timestampMessages", true);
user_pref("devtools.webide.autoinstallADBHelper", false);
user_pref("devtools.webide.autoinstallFxdtAdapters", false);

user_pref("distribution.canonical.bookmarksProcessed", true);

user_pref("dom.apps.reset-permissions", true);
user_pref("dom.browserElement.maxScreenshotDelayMS", 0);
user_pref("dom.mozApps.used", true);

/* Delay threshold for treating open windows created from JavaScript timing events as popups.*/
user_pref("dom.disable_open_click_delay", 3000);
/* Prevent js from focusing windows*/
user_pref("dom.disable_window_flip", true);
/*Prevent js from moving/resizing windows*/
user_pref("dom.disable_window_move_resize", true);
/* Prevent js from setting window options*/
user_pref("dom.disable_window_open_feature.close", true);
user_pref("dom.disable_window_open_feature.location", true);
user_pref("dom.disable_window_open_feature.menubar", true);
user_pref("dom.disable_window_open_feature.minimizable", true);
user_pref("dom.disable_window_open_feature.personalbar", true);
user_pref("dom.disable_window_open_feature.resizable", true);
user_pref("dom.disable_window_open_feature.status", true);
user_pref("dom.disable_window_open_feature.titlebar", true);
user_pref("dom.disable_window_open_feature.toolbar", true);
user_pref("dom.disable_window_showModalDialog", true);
user_pref("dom.popup_maximum", 5);

ser_pref("experiments.activeExperiment", false);
user_pref("experiments.enabled", false);
user_pref("experiments.manifest.uri", "");
user_pref("experiments.supported", false);
user_pref("extensions.adbhelper@mozilla.org.debug", false);
user_pref("extensions.adblockplus.notificationdata", "{\"lastCheck\":1459678928205,\"softExpiration\":1459728699109,\"hardExpiration\":1459826165983,\"data\":{\"notifications\":[],\"version\":\"201604030316\"},\"lastError\":0,\"downloadStatus\":\"synchronize_ok\",\"downloadCount\":67}");
user_pref("extensions.alwaysUnpack", true);
user_pref("extensions.blocklist.pingCountTotal", 568);
user_pref("extensions.blocklist.pingCountVersion", 12);
user_pref("extensions.databaseSchema", 23);
user_pref("extensions.dave@tails.boum.org.sdk.baseURI", "resource://dave-at-tails-dot-boum-dot-org/");
user_pref("extensions.dave@tails.boum.org.sdk.domain", "dave-at-tails-dot-boum-dot-org");
user_pref("extensions.dave@tails.boum.org.sdk.load.reason", "startup");
user_pref("extensions.dave@tails.boum.org.sdk.rootURI", "jar:file:///home/michael/.mozilla/firefox/qzv15m25.Michael/extensions/dave@tails.boum.org.xpi!/");
user_pref("extensions.dave@tails.boum.org.sdk.version", "0.2.8");
user_pref("extensions.e10s.rollout.blocklist", "");
user_pref("extensions.e10s.rollout.hasAddon", true);
user_pref("extensions.e10s.rollout.policy", "50allmpc");
user_pref("extensions.e10sBlockedByAddons", false);
user_pref("extensions.e10sMultiBlockedByAddons", true);
user_pref("extensions.followonsearch.cohortSample", "0.0");
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("extensions.formautofill.firstTimeUse", false);
user_pref("extensions.fxdevtools-adapters@mozilla.org.sdk.baseURI", "resource://fxdevtools-adapters-at-mozilla-dot-org/");
user_pref("extensions.fxdevtools-adapters@mozilla.org.sdk.domain", "fxdevtools-adapters-at-mozilla-dot-org");
user_pref("extensions.fxdevtools-adapters@mozilla.org.sdk.load.reason", "startup");
user_pref("extensions.fxdevtools-adapters@mozilla.org.sdk.rootURI", "file:///home/michael/.mozilla/firefox/qzv15m25.Michael/extensions/fxdevtools-adapters@mozilla.org/");
user_pref("extensions.fxdevtools-adapters@mozilla.org.sdk.version", "0.3.8");
user_pref("extensions.getAddons.cache.lastUpdate", 1513033528);
user_pref("extensions.getAddons.databaseSchema", 5);
user_pref("extensions.greasemonkey.enabled", false);
user_pref("extensions.greasemonkey.haveInsertedToolbarbutton", true);
user_pref("extensions.greasemonkey.menuCommanderEventNameSuffix", "IHUW6Z25SLVZHXSFGASC22H6CQQI4NDV");
user_pref("extensions.greasemonkey.newscript_namespace", "michael-scripts");
user_pref("extensions.greasemonkey.stats.prompted", true);
user_pref("extensions.greasemonkey.sync.enabled", false);
user_pref("extensions.greasemonkey.version", "3.17");
user_pref("extensions.hotfix.lastVersion", "20170302.01");
user_pref("extensions.lastAppBuildId", "20171129230719");
user_pref("extensions.lastAppVersion", "57.0.1");
user_pref("extensions.lastPlatformVersion", "57.0.1");
user_pref("extensions.livehttpheaders.exclude", false);
user_pref("extensions.livehttpheaders.excludeRegexp", ".gif$|.jpg$|.ico$|.css$|.js$");
user_pref("extensions.livehttpheaders.filter", false);
user_pref("extensions.livehttpheaders.filterRegexp", "/$|.html$");
user_pref("extensions.livehttpheaders.mode", 1);
user_pref("extensions.livehttpheaders.style", 0);
user_pref("extensions.livehttpheaders.tab", false);
user_pref("extensions.pendingOperations", false);
user_pref("extensions.pocket.api", "");
user_pref("extensions.pocket.enabled", false);
user_pref("extensions.pocket.oAuthConsumerKey", "");
user_pref("extensions.pocket.settings.test.panelSignUp", "");
user_pref("extensions.pocket.site", "");
user_pref("extensions.regexfind.key_findRegexPrevState", "on");
user_pref("extensions.screenshots.disabled", true);
user_pref("extensions.shield-recipe-client.api_url", "");
user_pref("extensions.shield-recipe-client.dev_mode", true);
user_pref("extensions.shield-recipe-client.enabled", false);
user_pref("extensions.shield-recipe-client.first_run", false);
user_pref("extensions.shield-recipe-client.startupExperimentMigrated", false);
user_pref("extensions.sidebar-button.shown", true);
user_pref("extensions.systemAddonSet", "{\"schema\":1,\"directory\":\"{30867ce4-40b7-4cf6-a07e-301b6e4834ee}\",\"addons\":{\"disable-media-wmf-nv12@mozilla.org\":{\"version\":\"1.1\"}}}");
user_pref("extensions.ublock0.cloudStorage.myFiltersPane", "");
user_pref("extensions.ublock0.cloudStorage.myRulesPane", "");
user_pref("extensions.ublock0.cloudStorage.tpFiltersPane", "");
user_pref("extensions.ublock0.cloudStorage.whitelistPane", "");
user_pref("extensions.ublock0.shortcuts.launch-element-picker", "");
user_pref("extensions.ublock0.shortcuts.launch-element-zapper", "");
user_pref("extensions.ublock0.shortcuts.launch-logger", "");
user_pref("extensions.ui.dictionary.hidden", true);
user_pref("extensions.ui.experiment.hidden", true);
user_pref("extensions.ui.lastCategory", "addons://list/extension");
user_pref("extensions.ui.locale.hidden", false);


user_pref("gecko.handlerService.migrated", true);
user_pref("general.warnOnAboutConfig", false);

user_pref("geo.enabled", false);
user_pref("geo.wifi.uri", "");
user_pref("geo.wifi.xhr.timeout", 1);
user_pref("idle.lastDailyNotification", 1513011838);

user_pref("lightweightThemes.persisted.footerURL", false);
user_pref("lightweightThemes.persisted.headerURL", false);
user_pref("lightweightThemes.selectedThemeID", "firefox-compact-light@mozilla.org");

user_pref("lightweightThemes.usedThemes", "[{\"id\":\"477241\",\"name\":\"Michael\",\"textcolor\":\"#002d8f\",\"accentcolor\":\"#ffffff\",\"author\":\"Redbud\",\"updateDate\":1510147689806,\"installDate\":1510147689806}]");

user_pref("network.allow-experiments", false);
user_pref("network.cookie.prefsMigrated", true);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.http.speculative-parallel-limit", 0);

user_pref("network.predictor.cleaned-up", true);
user_pref("network.predictor.enabled", false);
user_pref("network.prefetch-next", false);

user_pref("network.proxy.backup.ftp", "127.0.0.1");
user_pref("network.proxy.backup.ftp_port", 9050);
user_pref("network.proxy.backup.socks", "127.0.0.1");
user_pref("network.proxy.backup.socks_port", 9050);
user_pref("network.proxy.backup.ssl", "punterpal.com.au");
user_pref("network.proxy.backup.ssl_port", 9050);
user_pref("network.proxy.ftp", "punterpal.com.au");
user_pref("network.proxy.ftp_port", 8113);
user_pref("network.proxy.http", "punterpal.com.au");
user_pref("network.proxy.http_port", 8113);
user_pref("network.proxy.no_proxies_on", "");
user_pref("network.proxy.share_proxy_settings", true);
user_pref("network.proxy.socks", "punterpal.com.au");
user_pref("network.proxy.socks_port", 8113);
user_pref("network.proxy.socks_remote_dns", true);
user_pref("network.proxy.ssl", "punterpal.com.au");

user_pref("network.proxy.ssl_port", 8113);
user_pref("network.proxy.type", 0);

user_pref("network.warnOnAboutNetworking", false);

user_pref("plugin.disable_full_page_plugin_for_types", "application/pdf");
user_pref("plugin.importedState", true);

user_pref("pref.downloads.disable_button.edit_actions", false);
user_pref("pref.general.disable_button.default_browser", false);
user_pref("pref.privacy.disable_button.view_passwords", false);

/** Privacy settings **/
user_pref("privacy.cpd.offlineApps", true);
user_pref("privacy.cpd.siteSettings", true);
user_pref("privacy.resistFingerprinting", true);
user_pref("privacy.trackingprotection.annotate_channels", false);
user_pref("privacy.trackingprotection.introCount", 20);

user_pref("privacy.userContext.enabled", true);
user_pref("privacy.userContext.extension", "@testpilot-containers");
user_pref("privacy.userContext.longPressBehavior", 2);
user_pref("privacy.userContext.ui.enabled", true);
user_pref("privacy.usercontext.about_newtab_segregation.enabled", true);

/* hide (not spoof) referrer when leaving a .onion domain (FF54+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1305144 ***/
user_pref("network.http.referer.hideOnionSource", true);

user_pref("security.dialog_enable_delay", 0);

user_pref("device.sensors.enabled", false);

// Disable unsafe ciphers/protocols
user_pref("security.tls.version.min", 1); // disable SSLv3
//user_pref("security.ssl3.rsa_rc4_128_md5", false);
//user_pref("security.ssl3.rsa_rc4_128_sha", false);
//user_pref("security.ssl3.ecdh_ecdsa_rc4_128_sha", false);
//user_pref("security.ssl3.ecdh_rsa_rc4_128_sha", false);
//user_pref("security.ssl3.ecdhe_ecdsa_rc4_128_sha", false);
//user_pref("security.ssl3.ecdhe_rsa_rc4_128_sha", false);
// Disable potentially unsafe ciphers
//user_pref("security.ssl3.ecdh_ecdsa_des_ede3_sha", false);
//user_pref("security.ssl3.ecdh_ecdsa_rc4_128_sha", false);
//user_pref("security.ssl3.ecdh_rsa_des_ede3_sha", false);
//user_pref("security.ssl3.ecdhe_ecdsa_des_ede3_sha;true", false);
//user_pref("security.ssl3.ecdhe_rsa_des_ede3_sha", false);
//
/* PREF: Ensure you have a security delay when installing add-ons (milliseconds)*/
// http://kb.mozillazine.org/Disable_extension_install_delay_-_Firefox
// http://www.squarefree.com/2004/07/01/race-conditions-in-security-dialogs/
user_pref("security.dialog_enable_delay", 1000);

user_pref("services.sync.tabs.lastSync", "0");
user_pref("services.sync.tabs.lastSyncLocal", "0");

user_pref("signon.importedFromSqlite", true);
user_pref("signon.rememberSignons", false);

/* Prevent phishing by showing punycode characters */
user_pref("network.IDN_show_punycode, false);

/*****************************************************************************/

/** Disable Bullshit **/
/* Disable Telemetry */
user_pref("testpilot.backup.beacon.enabled", false);
user_pref("testpilot.backup.datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("browser.ping-centre.telemetry", false);
user_pref("browser.tabs.crashReporting.sendReport", false);

/* Disable Google Safe Browsing. */
user_pref("browser.safebrowsing.blockedURIs.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.passwords.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.safebrowsing.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("beacon.enabled", false);

/* Disable 'Accessibility Service Indicator' - can be used by malicious local
 * applications to steal data*/
user_pref("accessibility.force_disabled", 1); 

/* Disable autocomplete */
user_pref("browser.urlbar.autocomplete.enabled", false);

// PREF: Opt-out of add-on metadata updates
// https://blog.mozilla.org/addons/how-to-opt-out-of-add-on-metadata-updates/
user_pref("extensions.getAddons.cache.enabled", false);

// PREF: Opt-out of themes (Persona) updates
// https://support.mozilla.org/t5/Firefox/how-do-I-prevent-autoamtic-updates-in-a-50-user-environment/td-p/144287
user_pref("lightweightThemes.update.enabled", false);

/* Misc. Bullshit */
user_pref("general.warnOnAboutConfig", false);
user_pref("social.remote-install.enabled", false);
user_pref("social.toast-notifications.enabled", false);
user_pref("social.whitelist", "");

/*****************************************************************************/

/** Misc. Tweaks, Options etc.**/
/* Prevent websites from automatically refreshing the page*/
user_pref("accessibility.blockautorefresh", true);

/* Don't close firefox with the last tab*/
user_pref("browser.tabs.closeWindowWithLastTab", false);

/* Allow userscripts to close windows */
user_pref("dom.allow_scripts_to_close_windows", true);

/* Don't remove https?:// prefix*/
user_pref("browser.urlbar.trimURLs", false);

/* Make sure this shit is disabled*/
user_pref("accessibility.browsewithcaret", false);

/* Disable auto update - will check, but user decides*/
user_pref("app.update.auto", false);
user_pref("extensions.update.autoUpdateDefault", false);

/* Tab Settings */
user_pref("browser.sessionstore.max_tabs_undo", 64);
user_pref("browser.sessionstore.max_windows_undo", 64);
user_pref("Browser.tabs.loadBookmarksInTabs", true);
user_pref("Browser.tabs.loadBookmarksInBackground", true);
user_pref("Browser.tabs.loadDivertedInBackground", true);
user_pref("Browser.tabs.restorebutton", 1);
user_pref("browser.sessionstore.dom_storage_limit", 4096);

/*****************************************************************************/
