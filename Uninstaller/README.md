USE:  
Supply named program after "set SoftName=" and it should iterate through to check for, receive, and run uninstall strings.

TODO:  
Better comment  
First check for QuietUninstallString, else UninstallString
v Add check for when software installed in both registry locations v  
~~Add section to check non-32bit software (i.e. HKLM\Software\Microsoft)~~  
~~Better iteration(Not GOTO:end but beginning)~~  
~~Check for and replace msiexec /I uninstalls with /x~~  