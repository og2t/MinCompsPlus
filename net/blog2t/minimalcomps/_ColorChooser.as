/**
 * ColorChooser.as
 * Keith Peters
 * version 0.101
 * 
 * A Color Chooser component, allowing textual input, a default gradient, or custom image.
 * 
 * Copyright (c) 2010 Keith Peters
 * 
 * popup color choosing code by Rashid Ghassempouri
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
	import flash.display.IBitmapDrawable;
	import com.bit101.components.ColorChooser;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.display.DisplayObject;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class ColorChooser extends com.bit101.components.ColorChooser
	{
		private var _sampledPixel:BitmapData;
		private var _offset:Matrix;
		private var _localPoint:Point;
		protected var _label:Label;
		private var _labelText:String;

		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this ColorChooser.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param value The initial color value of this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
		 */
		public function ColorChooser(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, value:uint = 0xff0000, defaultHandler:Function = null, label:String = "")
		{
			super(parent, xpos, ypos, value, defaultHandler);
			_labelText = label;
		}		
		
		override protected function init():void
		{
			super.init();
			_sampledPixel = new BitmapData(1, 1, false, 0x0);
			_offset = new Matrix();
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			_label = new Label(this, 0, 0);
			_swatch.addEventListener(MouseEvent.CLICK, onSwatchClick);
		}
		
		/**
		 * Centers the label when label text is changed.
		 */
		protected function positionLabel():void
		{
			_input.x = _label.width + _label.x + 5;
			_swatch.x = _input.x + 50;
		}

		/**
		 *	Sample the color of a DisplayObject with a globalPoint offset.
		 *	Skip the component itself and when it's not IBitmapDrawable. 
		 */
		protected function sampleColor(displayObject:Object, globalPoint:Point):void
		{
			if (displayObject == this || !(displayObject is IBitmapDrawable)) return;

			_localPoint = displayObject.globalToLocal(globalPoint);

			if (displayObject is Bitmap)
			{				
				value = displayObject.bitmapData.getPixel(_localPoint.x, _localPoint.y);
			} else {
				_offset.identity();
				_offset.translate(-_localPoint.x, -_localPoint.y);
				_sampledPixel.draw(displayObject as IBitmapDrawable, _offset);
				value = _sampledPixel.getPixel(0, 0);
			}
		}

		private function drawColors(displayObject:DisplayObject):void
		{
			_colors = new BitmapData(displayObject.width, displayObject.height);
			_colors.draw(displayObject);
			while (_colorsContainer.numChildren) _colorsContainer.removeChildAt(0);
			_colorsContainer.addChild(new Bitmap(_colors));
			placeColors();
		}
		
		/**
		 *	When swatch is clicked, listen for stage mouse down and start sampling the color.
		 */
		protected function onSwatchClick(event:MouseEvent):void
		{
			_swatch.removeEventListener(MouseEvent.CLICK, onSwatchClick);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseSample);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageMouseDown);

			displayColors();
		}

		/**
		 *	Get the last object under mouse and try sampling it's color.
		 */
		protected function onMouseSample(event:MouseEvent):void
		{
			var globalPoint:Point = new Point(event.stageX, event.stageY);
			var objects:Array = stage.getObjectsUnderPoint(globalPoint);
			sampleColor(objects[objects.length - 1], globalPoint);
			dispatchEvent(new Event(Event.CHANGE));
		}

		/**
		 *	Sampling color done. Revert all events to their default stage.
		 */
		protected function onStageMouseDown(event:MouseEvent):void
		{
			_swatch.addEventListener(MouseEvent.CLICK, onSwatchClick);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseSample);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onStageMouseDown);
			displayColors();
		}
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			_label.text = _labelText;
			_label.draw();
			positionLabel();
		}
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * The color picker mode Display functions
		 */
		private function displayColors():void 
		{
			if (_colorsContainer.parent) _colorsContainer.parent.removeChild(_colorsContainer);
			else _swatch.addChild(_colorsContainer);
		}		

		private function placeColors():void
		{
			_colorsContainer.x = 20;
			_colorsContainer.y = _swatch.y;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Gets / sets the text shown in this component's label.
		 */
		public function set label(str:String):void
		{
			_labelText = str;
//			invalidate();
			draw();
		}
		public function get label():String
		{
			return _labelText;
		}
	}
}