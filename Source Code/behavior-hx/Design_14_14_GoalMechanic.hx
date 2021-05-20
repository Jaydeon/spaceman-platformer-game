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



class Design_14_14_GoalMechanic extends SceneScript
{
	public var _PlayerActor:Actor;
	public var _Goal:Region;
	public var _NextScene:Scene;
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("Player Actor", "_PlayerActor");
		nameMap.set("Goal", "_Goal");
		nameMap.set("Next Scene", "_NextScene");
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_PlayerActor = getValueForScene("Scene Manager", "_PlayerActor");
		propertyChanged("_PlayerActor", _PlayerActor);
		
		/* ======================== Specific Actor ======================== */
		addActorEntersRegionListener(_Goal, function(a:Actor, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAs(_PlayerActor, a))
			{
				getLastCreatedActor().say("Movement", "_customEvent_" + "ReachedGoal");
				runLater(1000 * 1.5, function(timeTask:TimedTask):Void
				{
					switchScene(_NextScene.getID(), createFadeOut(.5, Utils.getColorRGB(0,0,0)), createFadeIn(.5, Utils.getColorRGB(0,0,0)));
				}, null);
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}