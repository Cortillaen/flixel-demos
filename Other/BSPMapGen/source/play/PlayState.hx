package play;

import flixel.FlxG;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxStringUtil;
import generate.GenerateState;

class PlayState extends FlxState
{
	static inline var TILE_SIZE:Int = 16;
	
	var map:FlxTilemap;
	var player:Player;
	
	override public function create():Void
	{
		map = new FlxTilemap();
		var csvData:String = FlxStringUtil.bitmapToCSV(GenerateState.mapData);
		map.loadMap(csvData, "assets/images/tiles.png", TILE_SIZE, TILE_SIZE, AUTO);
		add(map);
		
		// Randomly pick room for player to start in
		var emptyTiles:Array<FlxPoint> = map.getTileCoords(0, false);
		var randomEmptyTile:FlxPoint = emptyTiles[FlxG.random.int(0, emptyTiles.length)];
		
		add(new Player(randomEmptyTile.x, randomEmptyTile.y));
		
		var gutter:Int = 10;
		add(new FlxButton(gutter, gutter, "Back (Space)", back));
	}
	
	override public function update():Void
	{
		super.update();
		FlxG.collide(player, map);
		
		if (FlxG.keys.justReleased.SPACE)
		{
			back();
		}
	}
	
	function back():Void
	{
		FlxG.switchState(new GenerateState());
	}
}