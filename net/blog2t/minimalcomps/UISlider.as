/**
 * UISlider.as
 * Keith Peters
 * 
 * A Slider with a label and value label. Abstract base class for VUISlider and HUISlider
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
	import com.bit101.components.UISlider;

	public class UISlider extends com.bit101.components.UISlider
	{
		private var _displayHex:Boolean = false;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this UISlider.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param label The initial string to display as this component's label.
		 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
		 */
		public function UISlider(parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0, label:String = "", defaultEventHandler:Function = null)
		{
			super(parent, x, y, label, defaultEventHandler);
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			super.addChildren();
			_slider.backClick = true;
		}
		
		/**
		 * Formats the value of the slider to a string based on the current level of precision.
		 */
		override protected function formatValueLabel():void
		{
			var mult:Number = Math.pow(10, _precision);
			var val:String = (Math.round(_slider.value * mult) / mult).toString();
			var valHex:String = int(val).toString(16).toUpperCase();
			
			super.formatValueLabel();
			
			if (_displayHex)
			{
				if (valHex.length < 2) valHex = "0" + valHex;
				_valueLabel.text = "0x" + valHex;
			} else {
				_valueLabel.text = val;
			}
			
			super.positionLabel();
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