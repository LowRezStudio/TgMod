class ImageServer extends WebApplication;

event Query(WebRequest Request, WebResponse Response)
{
    local string Image;

    Image = Request.URI;
    // End:0x8A
    if(!Response.FileExists(Path $ Image))
    {
        Response.HTTPError(404);
        return;        
    }
    else
    {
        // End:0xF0
        if((Right(Caps(Image), 4) == ".JPG") || Right(Caps(Image), 5) == ".JPEG")
        {
            Response.SendStandardHeaders("image/jpeg", true);            
        }
        else
        {
            // End:0x138
            if(Right(Caps(Image), 4) == ".GIF")
            {
                Response.SendStandardHeaders("image/gif", true);                
            }
            else
            {
                // End:0x180
                if(Right(Caps(Image), 4) == ".BMP")
                {
                    Response.SendStandardHeaders("image/bmp", true);                    
                }
                else
                {
                    // End:0x1C8
                    if(Right(Caps(Image), 4) == ".PNG")
                    {
                        Response.SendStandardHeaders("image/png", true);                        
                    }
                    else
                    {
                        Response.SendStandardHeaders("application/octet-stream", true);
                    }
                }
            }
        }
    }
    Response.IncludeBinaryFile(Path $ Image);
    //return;    
}
