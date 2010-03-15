package
{
	import net.blog2t.minimalcomps.*;	/*Use Minimal Components– in the first place*/
	import com.bit101.components.*;		/*Then default to original Minimal Components*/
	
	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(backgroundColor="0xeeeeee", width="600", height="400")]
	public class Test extends Sprite
	{
		private var myCheckBox:CheckBox;
		private var myColorChooser:ColorChooser;
		private var myLabel:Label;
		
		private var myHUISlider:HUISlider;
		private var myHSlider:HSlider;
		private var myProgressBar:ProgressBar;
		
		private var myRadioButton1:RadioButton;
		private var myRadioButton2:RadioButton;
		private var myRadioButton3:RadioButton;
		private var myRadioButton4:RadioButton;
		
		private var panel1:Panel;
		private var panel2:Panel;
		
		public function Test()
		{
			myCheckBox = new CheckBox(this, 130, 100, "CheckBox");
			myCheckBox.value = true;

			myColorChooser = new ColorChooser(this, 130, 130, 0xff0000, null);
			myColorChooser.usePopup = true;

			myLabel = new Label(this, 130, 160, "Label");
			myLabel.background = true;

			myHUISlider = new HUISlider(this, 130, 220, "HUISlider");
			myHUISlider.displayHex = true;
			
			myHSlider = new HSlider(this, 130, 200);
			myProgressBar = new ProgressBar(this, 130, 250);
			myProgressBar.value = 0.5;
			
			panel1 = new Panel(this, 300, 100);
			panel2 = new Panel(this, 420, 100);
			
			myRadioButton1 = new RadioButton(panel1, 10, 20, "RadioButton");
			myRadioButton2 = new RadioButton(panel1, 10, 40, "RadioButton");
			myRadioButton3 = new RadioButton(panel2, 10, 20, "RadioButton");
			myRadioButton4 = new RadioButton(panel2, 10, 40, "RadioButton");
		}
	}
}
