
{pkgs, inputs, ... }:
{
home-manager.users.stephan = {

programs.firefox = {
enable = true;
profiles.stephan = {
id = 0;
search.engines = {
"Nix Packages" = {
urls = [{
template = "https://search.nixos.org/packages";
params = [
{ name = "type"; value = "packages"; }
{ name = "query"; value = "{searchTerms}"; }
];
}];

      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = [ "@np" ];
    };
  };
  search.force = true;

  bookmarks = [
    {
      name = "wikipedia";
      tags = [ "wiki" ];
      keyword = "wiki";
      url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
    }

    {    
      name = "kernel.org";    
      url = "https://www.kernel.org";   
     }  

    {    
    name = "Nix sites";    
    toolbar = true;    
    bookmarks = [      
                  {        
                    name = "homepage";        
                    url = "https://nixos.org/";     
                    }      
                  {  
                    name = "wiki";        
                    tags = [ "wiki" "nix" ];        
                    url = "https://nixos.wiki/";       
                  } 

                  {
                    name = "";
                    tags = [ "kalender" ];
                    keyword = "kalender";
                    url = "https://nextcloud.pve-proxmox.de/index.php/apps/calendar/dayGridMonth/now";
                   }
                ];  
      }
   
  ];

  settings = {
    "dom.security.https_only_mode" = true;
    "browser.download.panel.shown" = true;
    "identity.fxaccounts.enabled" = true;
    "signon.rememberSignons" = false;
"app.normandy.first_run" = false;
"app.shield.optoutstudies.enabled" = false;

# disable updates (pretty pointless with nix)
"app.update.channel" = "default";

"browser.contentblocking.category" = "standard"; # "strict"
"browser.ctrlTab.recentlyUsedOrder" = false;

"browser.download.useDownloadDir" = false;
"browser.download.viewableInternally.typeWasRegistered.svg" = true;
"browser.download.viewableInternally.typeWasRegistered.webp" = true;
"browser.download.viewableInternally.typeWasRegistered.xml" = true;

"browser.link.open_newwindow" = true;

"browser.search.region" = "De";
"browser.search.widget.inNavBar" = true;

"browser.shell.checkDefaultBrowser" = false;
"browser.startup.homepage" = "https://nixos.org";
"browser.tabs.loadInBackground" = true;
"browser.urlbar.placeholderName" = "DuckDuckGo";
"browser.urlbar.showSearchSuggestionsFirst" = false;

# disable all the annoying quick actions
"browser.urlbar.quickactions.enabled" = false;
"browser.urlbar.quickactions.showPrefs" = false;
"browser.urlbar.shortcuts.quickactions" = false;
"browser.urlbar.suggest.quickactions" = false;

"distribution.searchplugins.defaultLocale" = "en-US";

"doh-rollout.balrog-migration-done" = true;
"doh-rollout.doneFirstRun" = true;

"dom.forms.autocomplete.formautofill" = false;

"general.autoScroll" = true;
"general.useragent.locale" = "de-De";

"extensions.activeThemeID" = "firefox-alpenglow@mozilla.org";

"extensions.extensions.activeThemeID" = "firefox-alpenglow@mozilla.org";
"extensions.update.enabled" = false;
"extensions.webcompat.enable_picture_in_picture_overrides" = true;
"extensions.webcompat.enable_shims" = true;
"extensions.webcompat.perform_injections" = true;
"extensions.webcompat.perform_ua_overrides" = true;

"print.print_footerleft" = "";
"print.print_footerright" = "";
"print.print_headerleft" = "";
"print.print_headerright" = "";

"privacy.donottrackheader.enabled" = true;

# Yubikey
"security.webauth.u2f" = true;
"security.webauth.webauthn" = true;
"security.webauth.webauthn_enable_softtoken" = true;
"security.webauth.webauthn_enable_usbtoken" = true;

"toolkit.legacyUserProfileCustomizations.stylesheets" = true;

  };

  userChrome = ''                         
    /* some css */                        
  '';                                      

  extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
    bitwarden
    blocktube 
i-dont-care-about-cookies
ublock-origin
privacy-badger
darkreader
    ff2mpv
  ];

};
};
};
}
