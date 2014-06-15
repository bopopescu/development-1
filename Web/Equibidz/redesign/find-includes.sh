#!/bin/bash

searchstr='.*cfinclude.*template.*=.*session\_include\.cfm.*'

echo.
echo Searching for regular expression '$searchstr' in pwd=`pwd`
echo.

egrep -R '$searchstr' *

#perl -p -i -e 's/\<cfinclude.*template\s?=\s?"?session\_include\.cfm\s?"\s?\/?\>//g' `find ./ -name *.html`
#perl -p -i -e 's/oldstring/newstring/g' `grep -ril oldstring *`

#egrep -e -R <cfinclude.*template\s?=\s?"?session_include.cfm\s?"\s?\/?> *

# cfinclude.*template="?app_globals.*cfinclude.*template="timenow[^\>]+
