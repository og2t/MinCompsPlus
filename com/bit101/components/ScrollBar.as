/**
 * ScrollBar.as
 * Keith Peters
 * version 0.102
 * 
 * Base class for HScrollBar and VScrollBar
 * 
 * Copyright (c) 2010 Keith Peters
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.bit101.components
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ScrollBar extends Component
	{
		protected var _upButton:PushButton;
		protected var _downButton:PushButton;
		protected var _scrollSlider:ScrollSlider;
		protected var _orientation:String;
		
		/**
		 * Constructor
		 * @param orientation Whether this is a vertical or horizontal slider.
		 * @param parent The parent DisplayObjectContainer on which to add this Slider.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
		 */
		public function ScrollBar(orientation:String, parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, defaultHandler:Function = null)
		{
			_orientation = orientation;
			super(parent, xpos, ypos);
			if(defaultHandler != null)
			{
				addEventListener(Event.CHANGE, defaultHandler);
			}
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			_scrollSlider = new ScrollSlider(_orientation, this, 0, 10, onChange);
			_upButton = new PushButton(this, 0, 0, "", onUpClick);
			_upButton.setSize(10, 10);
			_downButton = new PushButton(this, 0, 0, "", onDownClick);
			_downButton.setSize(10, 10);
		}
		
		protected override function init():void
		{
			super.init();
			if(_orientation == Slider.HORIZONTAL)
			{
				setSize(100, 10);
			}
			else
			{
				setSize(10, 100);
			}
		}
		
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Convenience method to set the three main parameters in one shot.
		 * @param min The minimum value of the slider.
		 * @param max The maximum value of the slider.
		 * @param value The value of the slider.
		 */
		public function setSliderParams(min:Number, max:Number, value:Number):void
		{
			_scrollSlider.setSliderParams(min, max, value);
		}
		
		/**
		 * Sets the percentage of the size of the thumb button.
		 */
		public function setThumbPercent(value:Number):void
		{
			_scrollSlider.setThumbPercent(value);
		}
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			if(_orientation == Slider.VERTICAL)
			{
				_scrollSlider.x = 0;
				_scrollSlider.y = 10;
				_scrollSlider.width = 10;
				_scrollSlider.height = _height - 20;
				_downButton.x = 0;
				_downButton.y = _height - 10;
			}
			else
			{
				_scrollSlider.x = 10;
				_scrollSlider.y = 0;
				_scrollSlider.width = _width - 20;
				_scrollSlider.height = _height;
				_downButton.x = _width - 10;
				_downButton.y = 0;
			}
		}

		
		
		
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets / gets the current value of this scroll bar.
		 */
		public function set value(v:Number):void
		{
			_scrollSlider.value = v;
		}
		public function get value():Number
		{
			return _scrollSlider.value;
		}
		
		
		
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		protected function onUpClick(event:MouseEvent):void
		{
			_scrollSlider.value--;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function onDownClick(event:MouseEvent):void
		{
			_scrollSlider.value++;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function onChange(event:Event):void
		{
			dispatchEvent(event);
		}
	}
}



import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import com.bit101.components.Style;
import com.bit101.components.Slider;

/**
 * Helper class for the slider portion of the scroll bar.
 */
class ScrollSlider extends Slider
{
	protected var _thumbPercent:Number = 1.0;
	
	/**
	 * Constructor
	 * @param orientation Whether this is a vertical or horizontal slider.
	 * @param parent The parent DisplayObjectContainer on which to add this Slider.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
	 */
	public function ScrollSlider(orientation:String, parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, defaultHandler:Function = null)
	{
		super(orientation, parent, xpos, ypos);
		if(defaultHandler != null)
		{
			addEventListener(Event.CHANGE, defaultHandler);
		}
	}
	
	/**
	 * Initializes the component.
	 */
	protected override function init():void
	{
		super.init();
		setSliderParams(1, 1, 0);
		backClick = true;
	}
	
	/**
	 * Draws the handle of the slider.
	 */
	override protected function drawHandle() : void
	{
		_handle.graphics.clear();
		if(_orientation == HORIZONTAL)
		{
			_handle.graphics.beginFill(0, 0);
			_handle.graphics.drawRect(0, 0, _width * _thumbPercent, _height);
			_handle.graphics.endFill();
			_handle.graphics.beginFill(Style.BUTTON_FACE);
			_handle.graphics.drawRect(1, 1, _width * _thumbPercent - 2, _height - 2);
			
		}
		else
		{
			_handle.graphics.beginFill(0, 0);
			_handle.graphics.drawRect(0, 0, _width  - 2, _height * _thumbPercent);
			_handle.graphics.endFill();
			_handle.graphics.beginFill(Style.BUTTON_FACE);
			_handle.graphics.drawRect(1, 1, _width - 2, _height * _thumbPercent - 2);
		}
		_handle.graphics.endFill();
		positionHandle();
	}
	
	/**
	 * Adjusts position of handle when value, maximum or minimum have changed.
	 * TODO: Should also be called when slider is resized.
	 */
	protected override function positionHandle():void
	{
		var range:Number;
		if(_orientation == HORIZONTAL)
		{
			range = width - _handle.width;
			_handle.x = (_value - _min) / (_max - _min) * range;
		}
		else
		{
			range = height - _handle.height;
			_handle.y = (_value - _min) / (_max - _min) * range;
		}
	}
	
	
	
	///////////////////////////////////
	// public methods
	///////////////////////////////////
	
	/**
	 * Sets the percentage of the size of the thumb button.
	 */
	public function setThumbPercent(value:Number):void
	{
		_thumbPercent = value;
		if(_orientation == HORIZONTAL && _thumbPercent * _width < _height)
		{
			_thumbPercent = _height / _width;
		}
		else if(_orientation == VERTICAL && _thumbPercent * _height < _width)
		{
			_thumbPercent = _width / _height;
		}
		invalidate();
	}
	
	
	
	
	
	///////////////////////////////////
	// event handlers
	///////////////////////////////////
	
	/**
	 * Handler called when user clicks the background of the slider, causing the handle to move to that point. Only active if backClick is true.
	 * @param event The MouseEvent passed by the system.
	 */
	protected override function onBackClick(event:MouseEvent):void
	{
		if(_orientation == HORIZONTAL)
		{
			if(mouseX < _handle.x)
			{
				_handle.x -= (_handle.width - 0);
			}
			else
			{
				_handle.x += (_handle.width - 0);
			}
			_handle.x = Math.max(_handle.x, 0);
			_handle.x = Math.min(_handle.x, width - _handle.width);
			_value = _handle.x / (width - _handle.width) * (_max - _min) + _min;
		}
		else
		{
			if(mouseY < _handle.y)
			{
				_handle.y -= (_handle.height - 2);
			}
			else
			{
				_handle.y += (_handle.height - 2);
			}
			_handle.y = Math.max(_handle.y, 0);
			_handle.y = Math.min(_handle.y, height - _handle.height);
			_value = _handle.y / (height - _handle.height) * (_max - _min) + _min;
		}
		dispatchEvent(new Event(Event.CHANGE));
		
	}
	
	/**
	 * Internal mouseDown handler. Starts dragging the handle.
	 * @param event The MouseEvent passed by the system.
	 */
	protected override function onDrag(event:MouseEvent):void
	{
		stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);
		if(_orientation == HORIZONTAL)
		{
			_handle.startDrag(false, new Rectangle(0, 0, width - width * _thumbPercent, 0));
		}
		else
		{
			_handle.startDrag(false, new Rectangle(0, 0, 0, height - height * _thumbPercent));
		}
	}
	
	/**
	 * Internal mouseMove handler for when the handle is being moved.
	 * @param event The MouseEvent passed by the system.
	 */
	protected override function onSlide(event:MouseEvent):void
	{
		var oldValue:Number = _value;
		if(_orientation == HORIZONTAL)
		{
			_value = _handle.x / (width - _width * _thumbPercent) * (_max - _min) + _min;
		}
		else
		{
			_value = _handle.y / (height - height * _thumbPercent) * (_max - _min) + _min;
		}
		if(_value != oldValue)
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
	
}
