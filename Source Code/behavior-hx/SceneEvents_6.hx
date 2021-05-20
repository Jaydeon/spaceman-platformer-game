package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;
import box2D.collision.shapes.B2Shape;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class SceneEvents_6 extends SceneScript
{
	public var _Idle:Actor;
	public var _plaeractor:Actor;
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("Idle", "_Idle");
		nameMap.set("plaer actor", "_plaeractor");
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_plaeractor = getActor(1);
		propertyChanged("_plaeractor", _plaeractor);
		runLater(1000 * .5, function(timeTask:TimedTask):Void
		{
			dialog.core.Dialog.cbCall("Gamejar", "Style", this, "");
		}, null);
		setVolumeForAllSounds(20/100);
		
		/* ======================== Specific Actor ======================== */
		addCollisionListener(_plaeractor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && (getActor(2) == event.otherActor))
			{
				event.otherActor.setAnimation("" + "Shook");
				event.otherActor.disableBehavior("Slime Behavior Copy");
				dialog.core.Dialog.cbCall("Touch Nook", "Style", this, "");
				engine.pause();
				setVolumeForAllSounds(100/100);
			}
		});
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener("Key 1", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				createRecycledActor(getActorType(29), getActor(1).getX(), getActor(1).getY(), Script.FRONT);
				getLastCreatedActor().fadeTo(0, 0, Linear.easeNone);
				_plaeractor.fadeTo(0, .5, Linear.easeNone);
				_plaeractor = getLastCreatedActor();
				propertyChanged("_plaeractor", _plaeractor);
				getLastCreatedActor().fadeTo(1, .5, Linear.easeNone);
			}
		});
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener("Key 2", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				createRecycledActor(getActorType(31), getActor(1).getX(), getActor(1).getY(), Script.FRONT);
				getLastCreatedActor().fadeTo(0, 0, Linear.easeNone);
				_plaeractor.fadeTo(0, .5, Linear.easeNone);
				_plaeractor = getLastCreatedActor();
				propertyChanged("_plaeractor", _plaeractor);
				getLastCreatedActor().fadeTo(1, .5, Linear.easeNone);
			}
		});
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener("Key 3", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				createRecycledActor(getActorType(33), getActor(1).getX(), getActor(1).getY(), Script.FRONT);
				getLastCreatedActor().fadeTo(0, 0, Linear.easeNone);
				_plaeractor.fadeTo(0, .5, Linear.easeNone);
				_plaeractor = getLastCreatedActor();
				propertyChanged("_plaeractor", _plaeractor);
				getLastCreatedActor().fadeTo(1, .5, Linear.easeNone);
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}