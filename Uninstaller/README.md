USE:  
Supply named program after "set SoftName=" and it should iterate through to check for, receive, and run uninstall strings.

TODO:  
Better comment  
First check for QuietUninstallString, else UninstallString
Add section to check non-32bit software (i.e. HKLM\Software\Microsoft)  
Add some common non-msi silent uninstalls (re: Firefox, etc)  
~~Better iteration(Not GOTO:end but beginning)~~  
~~Check for and replace msiexec /I uninstalls with /x~~  