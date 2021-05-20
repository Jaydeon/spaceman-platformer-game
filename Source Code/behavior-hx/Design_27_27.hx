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



class Design_27_27 extends ActorScript
{
	public var _PlayerActor:Actor;
	public var _AttackDelay:Bool;
	public var _AttackAnimations:String;
	public var _IdleAnimations:String;
	public var _OriginXPosition:Actor;
	public var _OriginX:Float;
	public var _Arrow:ActorType;
	public var _ArrowYOffset:Float;
	public var _XDirection:Float;
	public var _FireRange:Float;
	public var _anchor:Actor;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Player Actor", "_PlayerActor");
		nameMap.set("Attack Delay", "_AttackDelay");
		_AttackDelay = false;
		nameMap.set("Attack Animations", "_AttackAnimations");
		nameMap.set("Idle Animations", "_IdleAnimations");
		nameMap.set("Origin X Position", "_OriginXPosition");
		nameMap.set("Origin X", "_OriginX");
		_OriginX = 0.0;
		nameMap.set("Arrow", "_Arrow");
		nameMap.set("Arrow Y Offset", "_ArrowYOffset");
		_ArrowYOffset = 0.0;
		nameMap.set("X Direction", "_XDirection");
		_XDirection = 0.0;
		nameMap.set("Fire Range", "_FireRange");
		_FireRange = 1000.0;
		nameMap.set("anchor", "_anchor");
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_OriginX = asNumber(actor.getX());
		propertyChanged("_OriginX", _OriginX);
		_PlayerActor = getValueForScene("Scene Manager", "_PlayerActor");
		propertyChanged("_PlayerActor", _PlayerActor);
		actor.anchorToScreen();
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((_PlayerActor.getX() < actor.getX()))
				{
					actor.growTo(100/100, 100/100, 0, Linear.easeNone);
					_XDirection = asNumber(50);
					propertyChanged("_XDirection", _XDirection);
				}
				else
				{
					actor.growTo(-100/100, 100/100, 0, Linear.easeNone);
					_XDirection = asNumber(-50);
					propertyChanged("_XDirection", _XDirection);
				}
				if(!(_AttackDelay))
				{
					if(((Math.abs((_PlayerActor.getXCenter() - actor.getXCenter())) <= _FireRange) && ((_PlayerActor.getY() + (_PlayerActor.getHeight())) == (_PlayerActor.getY() + (_PlayerActor.getHeight())))))
					{
						createRecycledActor(_Arrow, actor.getXCenter(), (actor.getY() * 1.5), Script.BACK);
						getLastCreatedActor().growTo(_XDirection/100, 50/100, 0, Linear.easeNone);
						if((_XDirection == -50))
						{
							getLastCreatedActor().setX((actor.getXCenter() + (getLastCreatedActor().getWidth()/2)));
						}
						if((_XDirection == 50))
						{
							getLastCreatedActor().setX((actor.getXCenter() - (getLastCreatedActor().getWidth()/2)));
						}
						getLastCreatedActor().setY((actor.getYCenter() - ((getLastCreatedActor().getHeight()/2) + _ArrowYOffset)));
						if((_XDirection == -100))
						{
							getLastCreatedActor().applyImpulse(1, 0, 30);
						}
						else
						{
							getLastCreatedActor().applyImpulse(-1, 0, 30);
						}
						_AttackDelay = true;
						propertyChanged("_AttackDelay", _AttackDelay);
						runLater(1000 * .5, function(timeTask:TimedTask):Void
						{
							_AttackDelay = false;
							propertyChanged("_AttackDelay", _AttackDelay);
						}, actor);
						actor.setAnimation("" + _AttackAnimations);
						runLater(1000 * (actor.getNumFrames() * 1), function(timeTask:TimedTask):Void
						{
							actor.setAnimation("" + _IdleAnimations);
						}, actor);
					}
				}
				actor.setX(_OriginX);
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}