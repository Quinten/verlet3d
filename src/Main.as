package 
{
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.methods.FilteredShadowMapMethod;
	import away3d.primitives.Plane;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * @author Quinten Clause
	 */
	public class Main extends Sprite 
	{
		private var _view:View3D;
		private var _cube:Vector.<Verlet3dCube> = new Vector.<Verlet3dCube>(10, true);
		private var _light:PointLight;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_view = new View3D();
			_view.backgroundColor = 0xffffff;
			this.addChild(_view);
			this.addChild(new AwayStats(_view));
			
			var dirLight:DirectionalLight = new DirectionalLight();
			dirLight.y = 1000;
			dirLight.z = 500;
			dirLight.castsShadows = true;
			_view.scene.addChild(dirLight); 
			
			var material:ColorMaterial = new ColorMaterial(0xffffff, 1);
			material.lights = [dirLight];
			material.shadowMethod = new FilteredShadowMapMethod(dirLight);

			var secondMaterial:ColorMaterial = new ColorMaterial(0xffeeaa, 1);
			secondMaterial.lights = [dirLight];
			
			for (var c:int = 0; c < 10; c++){
				_cube[c] = new Verlet3dCube(secondMaterial, 100, 100, 100, 0, 400, c * 250, false);
				_cube[c].castsShadows = true;
				_cube[c].setBounds( -600, 600, -200, 1000, -30000, 30000);
				_view.scene.addChild(_cube[c]);
			}
			
			var floor:Plane = new Plane(material, 1200, 30000, 1, 1, false);
			floor.y = -200;
			_view.scene.addChild(floor);

			_light = new PointLight();
			_light.x = -1000;
			_light.y = 1000;
			_light.z = -1000;
			_light.color = 0xffeeaa;
			material.lights.push(_light);
			_view.scene.addChild(_light);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, onR);
			
			this.addEventListener(Event.ENTER_FRAME, onF);
        }

		private function onR(e:Event):void
		{
			_view.width = stage.stageWidth;
			_view.height = stage.stageHeight;
		}
		
		
		private function onF(e:Event):void
		{
			for (var c:int = 0; c < 10; c++)
				_cube[c].update();
			_view.render();
		}
		
	}
}