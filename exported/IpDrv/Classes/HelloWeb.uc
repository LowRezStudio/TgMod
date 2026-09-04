class HelloWeb extends WebApplication;

function Init()
{
    //return;    
}

event Query(WebRequest Request, WebResponse Response)
{
    local int I;

    // End:0x7F
    if((Request.UserName != "test") || Request.Password != "test")
    {
        Response.FailAuthentication("HelloWeb");
        return;
    }
    switch(Request.URI)
    {
        // End:0x330
        case "/form.html":
            Response.SendText("<form method=post action=submit.html>");
            Response.SendText("<input type=edit name=TestEdit>");
            Response.SendText("<p><select multiple name=selecter>");
            Response.SendText("<option value=\"one\">Number One");
            Response.SendText("<option value=\"two\">Number Two");
            Response.SendText("<option value=\"three\">Number Three");
            Response.SendText("<option value=\"four\">Number Four");
            Response.SendText("</select><p>");
            Response.SendText("<input type=submit name=Submit value=Submit>");
            Response.SendText("</form>");
            // End:0x6AE
            break;
        // End:0x4E0
        case "/submit.html":
            Response.SendText("Thanks for submitting the form.<br>");
            Response.SendText(("TestEdit was \"" $ Request.GetVariable("TestEdit")) $ "\"<p>");
            Response.SendText("You selected these items:<br>");
            I = Request.GetVariableCount("selecter") - 1;
            J0x45F:

            // End:0x4DD [Loop If]
            if(I >= 0)
            {
                Response.SendText(("\"" $ Request.GetVariableNumber("selecter", I)) $ "\"<br>");
                I--;
                // [Loop Continue]
                goto J0x45F;
            }
            // End:0x6AE
            break;
        // End:0x5E3
        case "/include.html":
            Response.Subst("variable1", "This is variable 1");
            Response.Subst("variable2", "This is variable 2");
            Response.Subst("variable3", "This is variable 3");
            Response.IncludeUHTM("testinclude.html");
            // End:0x6AE
            break;
        // End:0xFFFF
        default:
            Response.SendText("Hello web!  The current level is " $ WorldInfo.Title);
            Response.SendText("<br>Click <a href=\"form.html\">this link</a> to go to a test form");
            // End:0x6AE
            break;
            break;
    }
    //return;    
}
