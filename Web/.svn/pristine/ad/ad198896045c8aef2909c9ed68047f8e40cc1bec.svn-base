<cfoutput>
<font face="arial">
<a href="#cgi.script_name#?skin=default">Default</a> |
<a href="#cgi.script_name#?skin=beige">Beige</a> |
<a href="#cgi.script_name#?skin=blue">Blue</a> |
<a href="#cgi.script_name#?skin=red">Red</a> |
<a href="#cgi.script_name#?skin=silver">Silver</a> |
</font>
</cfoutput>
<cfparam name="url.skin" default="default">

<hr>

<cfchart format="flash"
    chartwidth="400"
    chartheight="300"
    seriesplacement="stacked"
    show3d="true"
    style="#url.skin#">

    <cfchartseries type="bar" seriesLabel="January">
        <cfchartdata item="Books" value="60"/>
        <cfchartdata item="DVD's" value="30"/>
        <cfchartdata item="Videos" value="25"/>
        <cfchartdata item="CD's" value="39"/>
        <cfchartdata item="Magazines" value="55"/>
    </cfchartseries>
    <cfchartseries type="bar" seriesLabel="February">
        <cfchartdata item="Books" value="40"/>
        <cfchartdata item="DVD's" value="57"/>
        <cfchartdata item="Videos" value="25"/>
        <cfchartdata item="CD's" value="29"/>
        <cfchartdata item="Magazines" value="15"/>
    </cfchartseries>
    <cfchartseries type="bar" seriesLabel="March">
        <cfchartdata item="Books" value="36"/>
        <cfchartdata item="DVD's" value="20"/>
        <cfchartdata item="Videos" value="20"/>
        <cfchartdata item="CD's" value="45"/>
        <cfchartdata item="Magazines" value="20"/>
    </cfchartseries>

</cfchart>
