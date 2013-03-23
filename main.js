/**
 * Soul keeper.
 * Gamedevparty #4 - March 2013
 */

// game resources
var g_resources= [
    {
            name: "gripe_run_right",
                type: "image",
                src: "data/sprite/gripe_run_right.png"
    }
];

var soulKeeper = 
{	
    /*
     * Game initialization
     */
	onload: function()
	{
		
		// init the video
		if (!me.video.init('jsapp', 800, 600, false, 1.0))
		{
            alert("Sorry but your browser does not support html 5 canvas.");
            return;
		}
				
		// initialize the "audio"
		me.audio.init("mp3,ogg");
		
		// set all resources to be loaded
		me.loader.onload = this.loaded.bind(this);
		
		// set all resources to be loaded
		me.loader.preload(g_resources);

		// load everything & display a loading screen
		me.state.change(me.state.LOADING);
	},
	
	
	/* ---
	
		callback when everything is loaded
		
		---										*/
	loaded: function ()
	{
		// set the "Play/Ingame" Screen Object
		me.state.set(me.state.PLAY, new PlayScreen());
      
      // start the game 
		me.state.change(me.state.PLAY);
	}

}; // jsApp

/* the in game stuff*/
var PlayScreen = me.ScreenObject.extend(
{
   onResetEvent: function()
	{	
      // stuff to reset on state change
        
	},
	
    /*
     * Action to perform when game is finished (state change)
     */
	onDestroyEvent: function()
	{
   }

});

/**
 * Load SoulKeeper!
 */
window.onReady(function() 
{
	soulKeeper.onload();
});
