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



class Design_3_3_mvmt extends ActorScript
{
	public var _walk:String;
	public var _idle:String;
	public var _grounded:Bool;
	public var _jump:String;
	public var _air:Bool;
	public var _Allow:Bool;
	
	/* ========================= Custom Event ========================= */
	public function _customEvent_ReachedGoal():Void
	{
		_Allow = false;
		propertyChanged("_Allow", _Allow);
		actor.setXVelocity(0);
		actor.setAnimation("" + _idle);
		disableThisBehavior();
	}
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("walk", "_walk");
		nameMap.set("idle", "_idle");
		nameMap.set("grounded", "_grounded");
		_grounded = false;
		nameMap.set("jump", "_jump");
		nameMap.set("air", "_air");
		_air = false;
		nameMap.set("Allow", "_Allow");
		_Allow = false;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_Allow = true;
		propertyChanged("_Allow", _Allow);
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				engine.cameraFollow(actor);
				if((_Allow == true))
				{
					if(((actor.getX() >= 0) && ((actor.getX() + (actor.getWidth())) <= (getSceneWidth()))))
					{
						if((isKeyPressed("up") && _grounded))
						{
							runLater(1000 * 0.075, function(timeTask:TimedTask):Void
							{
								_grounded = false;
								propertyChanged("_grounded", _grounded);
							}, actor);
							_air = true;
							propertyChanged("_air", _air);
							actor.setAnimation("" + _jump);
							actor.applyImpulse(0, -1, 40);
						}
						if(isKeyDown("left"))
						{
							actor.setXVelocity(-12);
							actor.growTo(-100/100, 100/100, 0, Linear.easeNone);
							if(!(_air))
							{
								actor.setAnimation("" + _walk);
							}
						}
						else if(isKeyDown("right"))
						{
							actor.setXVelocity(12);
							actor.growTo(100/100, 100/100, 0, Linear.easeNone);
							if(!(_air))
							{
								actor.setAnimation("" + _walk);
							}
						}
						else if(!(_air))
						{
							actor.setXVelocity(0);
							actor.setAnimation("" + _idle);
						}
					}
					else
					{
						actor.setXVelocity(0);
						if((actor.getX() < 0))
						{
							actor.setX(0);
						}
						else if(((actor.getX() + (actor.getWidth())) > (getSceneWidth())))
						{
							actor.setX(((getSceneWidth()) - (actor.getWidth())));
						}
					}
				}
			}
		});
		
		/* ======================= Member of Group ======================== */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorGroup(1),event.otherActor.getType(),event.otherActor.getGroup()))
			{
				if(event.thisFromBottom)
				{
					if(!(_grounded))
					{
						_grounded = true;
						propertyChanged("_grounded", _grounded);
						_air = false;
						propertyChanged("_air", _air);
					}
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}