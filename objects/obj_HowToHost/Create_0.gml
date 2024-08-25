//This should work as a powerpoint presentation
slide_n = 0;
title = "test";
text = @"testing
more testing";
image = spr_Title;
max_slides = 5;

//Each slide should have title, text, and an image
function change_slide(slide) {

	slide_n = slide;
	//slide_n = clamp(slide, 0, 3);
	//clamp + loop slides
	if slide_n > max_slides {
		slide_n = 0;	
	}
	if slide_n < 0 {
		slide_n = max_slides;	
	}
	
	switch slide_n {
		//"Ships"
		case 0:
			title = "STEP 1";
			text = 
@"Go to the Host Game tab and 
accept any windows prompts when attempting to host.
After starting to host a game, back out of the game.";
			break;
			
		case 1:
			title = "STEP 2";
			text =
@"Firstly, you need to obtain your IPv4 Address 
and Router Settings IP.
To do this, open the command prompt by typing 
'cmd' into the windows search bar,
Then open it and type in 'ipconfig' and hit Enter.
Make a note of the IPv4 Address and 
Default Gateway for later in the guide.";
			break;
			
		case 2:
			title = "STEP 3";
			text =
@"Open a Web Browser, and enter the Default Gateway 
into the URL search bar.
This should take you to your routers settings.
If this does not work, there should be an IP on the router you can try.
Log in to the router settings using details that can be found on your router.";
			break;
			
		case 3:
			title = "STEP 4";
			text =
@"Within your network settings, locate the port forwarding section.
Add a new setting/rule (this may be called something different),
And type the IPv4 Address from earlier as the IP,
And for any option that says 'port' pick a number between
50000 and 65000 (make sure to use the same number for all ports).
Make a note of this number for later.
For the protocol, choose TCP.";
			break;
			
		case 4:
			title = "STEP 5";
			text =
@"After enabling this port forward, you should be able to host.
Go to the Host Game tab, Type in the port you port forwarded with,
And players should now be able to join if given your IPv4 Address
And the port!";
			break;
			
			
		case 5:
			title = "STEP 6";
			text = 
@"When not using the port to host, it is probably best
to close/disable the port forward.

If you are unable to host, you can try a local lobby with
ctrl+d+4+o
Please note this is not the intended way to play 
and is just a failsafe in case networking isn't possible for you. 
You can use this to see most of the games mechanics in action, 
and it is more of a sandbox to showcase the game than an actual mode.
P2's controls are arrow keys, i, o, p, 8, 9, 0"
			break;
			
	}
	
}

change_slide(0)