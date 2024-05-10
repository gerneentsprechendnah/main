
{pkgs, inputs, ... }:
{
home-manager.users.stephan = {
			     programs.thunderbird = {
			                            enable = true;
						    profiles.stephan = {
						                       isDefault = true;
								       settings = {
								                  "mail.spellcheck.inline" = false;
						                                  };
						                       };				  
		                                    settings = {
                                                               "general.useragent.override" = "";  
							       "privacy.donottrackheader.enabled" = true;
							       "browser.display.use_system_colors" = true;
                                                               "browser.underline_anchors" = false;
        						       "calendar.alarms.playsound" = true;
        							"calendar.alarms.show" = true;
        							"calendar.alarms.showmissed" = false;
        							"calendar.view.dayendhour" = 22;
        							"calendar.view.showLocation" = true;
        							"datareporting.healthreport.uploadEnabled" = false;
        							"intl.date_time.pattern_override.date_short" = "yyyy-MM-dd";
        							"intl.date_time.pattern_override.date_medium" = "yyyy-MM-dd";
        							"intl.date_time.pattern_override.date_long" = "yyyy-MM-dd";
        							"intl.date_time.pattern_override.date_full" = "yyyy-MM-dd";
        							"intl.date_time.pattern_override.time_short" = "HH:mm";
        							"intl.date_time.pattern_override.time_medium" = "HH:mm";
        							"intl.date_time.pattern_override.time_long" = "HH:mm";
       								"intl.date_time.pattern_override.time_full" = "HH:mm";
       								"intl.date_time.pattern_override.connector_short" = " ";
        							"mail.compose.default_to_paragraph" = false;
       								"mail.purge.ask" = false;
        							"mail.startup.enabledMailCheckOnce" = true;
        							"mailnews.start_page.enabled" = false;
        							"network.cookie.cookieBehavior" = 2;
        							"places.history.enabled" = false;
        							"spellchecker.dictionary" = "en-US,de-DE";
						               };
						    };
                             

			     accounts.email = {
                                               accounts = {
					                   privat = {
							            address = "stephan@ritthaler.me";
								    userName = "stephan@ritthaler.me";
								    realName = "Stephan Ritthaler";
								    signature = {
								               text = ''
									                Stephan Ritthaler
											Kirchenstieg 1a
											21465 Reinbek

											E-Mail: stephan@ritthaler.me
											Tel.: 
										      '';
									       showSignature = "attach";	      
									       };
								    imap = {
								            host ="web296.dogado.net";
									    port = 993;
								           };   
								    smtp = {
								            host = "web296.dogado.net";
									    port = 465;
								           };
								    folders = {
								              inbox = "Inbox";
									      sent = "Sent";
									      drafts = "Drafts";
									      archive = "archive";
									      trash = "Trash";
								              };
								    thunderbird = {
							                          enable = true;
							                          };   
							            };
							   };

			                         };




                          };
}
