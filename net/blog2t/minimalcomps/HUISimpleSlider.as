/**
 * HSimpleSlider.as
 * based on Minimal Components by Keith Peters
 * 
 * A progress bar component for showing a changing value in relation to a total.
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
 
package net.blog2t.minimalcomps
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import net.blog2t.minimalcomps.HSimpleSlider;
	import com.bit101.components.Component;
	
	public class HUISimpleSlider extends Component
	{
		protected var _label:Label;
		protected var _valueLabel:Label;
		protected var _precision:int = 1;
		private var _labelText:String;
		private var _displayHex:Boolean = false;
		private var _slider:HSimpleSlider;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this ProgressBar.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
		public function HUISimpleSlider(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, label:String = "", defaultEventHandler:Function = null)
		{
			super(parent, xpos, ypos);
			if (defaultEventHandler != null) addEventListener(Event.CHANGE, defaultEventHandler);
			_labelText = label;
			formatValueLabel();
		}
		
		/**
		 * Initilizes the component.
		 */
		override protected function init():void
		{
			super.init();
			setSize(200, 10);
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			super.addChildren();
			_slider = new HSimpleSlider(this, 0, 0, onSliderChange);
			_slider.setSize(0, 10);
			_slider.setSliderParams(0, 100, 0);
			_label = new Label(this, 0, 0);
			_valueLabel = new Label(this);
		}
		
		/**
		 * Draws the visual ui of this component.
		 */
		override public function draw():void
		{
			super.draw();
			_label.text = _labelText;
			_label.draw();
			formatValueLabel();
			
			_slider.x = _label.width + 5;
			_slider.y = _slider.height / 2 - 1;
			_slider.width = width - _label.width - 50 - 10;

			_valueLabel.x = _slider.x + _slider.width + 5;
		}
		
		/**
		 * Formats the value of the slider to a string based on the current level of precision.
		 */
		protected function formatValueLabel():void
		{
			var mult:Number = Math.pow(10, _precision);
			var val:String = (Math.round(_slider.value * mult) / mult).toString();
			var parts:Array = val.split(".");
			var valHex:String = int(val).toString(16).toUpperCase();
			
			if(parts[1] == null)
			{ 
				if(_precision > 0)
				{
					val += "."
				}
				for(var i:uint = 0; i < _precision; i++)
				{
					val += "0";
				}
			}
			else if(parts[1].length < _precision)
			{
				for(i = 0; i < _precision - parts[1].length; i++)
				{
					val += "0";
				}
			}
			
			if (_displayHex)
			{
				if (valHex.length < 2) valHex = "0" + valHex;
				_valueLabel.text = "0x" + valHex;
				
			} else {
				_valueLabel.text = val;
			}
			
			positionLabel();
		}
		
		/**
		 * Centers the label when label text is changed.
		 */
		protected function positionLabel():void
		{
			_valueLabel.x = _slider.x + _slider.width + 5;
		}
		
		/**
		 * Handler called when the slider's value changes.
		 * @param event The Event passed by the slider.
		 */
		protected function onSliderChange(event:Event):void
		{
			formatValueLabel();
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		/**
		 * Gets / sets the hex format of the label value.
		 */
		public function set displayHex(state:Boolean):void
		{
			_displayHex = state;
		}
		
		public function get displayHex():Boolean
		{
			return _displayHex;
		}
	}
}