$(document).ready(function()
{
    var max_length = 140;
 
    //run listen key press
    whenkeydown(max_length);
});
 
whenkeydown = function(max_length)
{
    $("#micropost_content").unbind().keyup(function()
    {
        //check if the appropriate text area is being typed into
        if(document.activeElement.id === "micropost_content")
        {
            //get the data in the field
            var text = $(this).val();
 
            //set number of characters
            var numofchars = text.length;
 
            if(numofchars <= max_length)
            {
                //set the length of the text into the counter span
                $("#counter").html("").html(max_length - text.length);
								
								//change color to red when reaching 120 charaters
								if(numofchars >= 120)
								{
									$("#counter").css('color', '#F00');
								}
								else
								{
									$("#counter").css('color', '#000');
								}
            }
            else
            {
                //make sure string gets trimmed to max character length
                $(this).val(text.substring(0, max_length));
            }
        }
    });
};