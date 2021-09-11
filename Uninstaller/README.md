USE:  
Supply named program after "set SoftName=" and it should iterate through to check for and receive uninstall strings  

TODO:  
Better comment  
Better iteration ~~(Not GOTO:end but beginning)~~  
Add section to check non-32bit software (i.e. HKLM\Software\Microsoft)  
Check for and replace msiexec /I uninstalls with /x  
Add some common non-msi silent uninstalls (re: Firefox, etc)  
