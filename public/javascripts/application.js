// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


// Micropost Character Counter
window.onload(function()
{
    //set max length
    var max_length = 140;

		var counter = document.getElementById("counter");
 
    //load in max characters when page loads
    counter.innerHTML = max_length;
 
    //run listen key press
    whenkeydown(max_length);
});
 
whenkeydown = function(max_length)
{
    var mp_text = document.getElementById("mp_text");

		mp_text.unbind().keyup(function()
    {
        //check if the appropriate text area is being typed into
        if(document.activeElement.id === "mp_text")
        {
            //get the data in the field
            var text = mp_text.value;
 
            //set number of characters
            var numofchars = text.length;
 
            //set the chars left
            var chars_left = max_length - numofchars;
 
            //check if we are still within our maximum number of characters or not
            if(numofchars <= max_length)
            {
                //set the length of the text into the counter span
                counter.innerHTML = chars_left;
								counter.style.color="#000000";
            }
            else
            {
                //style numbers in red
								counter.innerHTML = chars_left;
								counter.style.color="#FF0000";
            };
        };
    });
};