package  
{
	import away3d.materials.MaterialBase;
	import away3d.primitives.Cube;
	import flat.verlet3d.Verlet3dPoint;
	import flat.verlet3d.Verlet3dStick;
	
	/**
	 * @author Quinten Clause
	 */
	public class Verlet3dCube extends Cube 
	{
		private var _point:Vector.<Verlet3dPoint> = new Vector.<Verlet3dPoint>(8, true);
		private var _stick:Vector.<Verlet3dStick> = new Vector.<Verlet3dStick>(28, true);
		
		private var _verletVertices:Vector.<Number> = new Vector.<Number>(72, true);
		
		private var _left:Number = -1000;
		private var _right:Number = 1000;
		private var _bottom:Number = -1000;
		private var _top:Number = 1000;
		private var _back:Number = -1000;
		private var _front:Number = 1000;
		
		private var f:int = 0;
		
		public function Verlet3dCube(material:MaterialBase = null, width:Number = 100, height:Number = 100, depth:Number = 100, x_:Number = 0, y_:Number = 0, z_:Number = 0, tile6:Boolean = true) 
		{
			super(material, width, height, depth, 1, 1, 1, tile6);
			
			this.geometry.subGeometries[0].autoDeriveVertexNormals = true;
			this.geometry.subGeometries[0].autoDeriveVertexTangents = true;
			
			_point[0] = new Verlet3dPoint( x_ - width / 2, y_ - height / 2, z_ - depth / 2);
			_point[1] = new Verlet3dPoint( x_ - width / 2, y_ - height / 2, z_ + depth / 2);
			_point[2] = new Verlet3dPoint( x_ - width / 2, y_ + height / 2, z_ - depth / 2);
			_point[3] = new Verlet3dPoint( x_ - width / 2, y_ + height / 2, z_ + depth / 2);
			_point[4] = new Verlet3dPoint( x_ + width / 2, y_ - height / 2, z_ - depth / 2);
			_point[5] = new Verlet3dPoint( x_ + width / 2, y_ - height / 2, z_ + depth / 2);
			_point[6] = new Verlet3dPoint( x_ + width / 2, y_ + height / 2, z_ - depth / 2);
			_point[7] = new Verlet3dPoint( x_ + width / 2, y_ + height / 2, z_ + depth / 2);
			
			//_point[0].vX = 50;
			//_point[0].vY = -10;
			
			var s:int = 0;
			for (var a:int = 0; a < 8; a++) {
				for (var b:int = a + 1; b < 8; b++) {
					_stick[s] = new Verlet3dStick(_point[a], _point[b]);
					s++;
				}
			}
		}
		
		public function update():void
		{
			//_point[0].vX = (_point[6].x - _point[0].x) / 50;
			//_point[1].vX = (_point[7].x - _point[1].x) / 50;
			//_point[6].vX = -3;
			//_point[7].vX = -3;
			//_point[0].vY = 10;
			f++;
			if (f > 120) {
				//_point[0].vY = _point[0].vX = 40;
				//_point[1].vY = _point[1].vX = 40;
				_point[0].vY = 60;
				_point[1].vY = 60;
				_point[7].vX = _point[6].vX = (3 - Math.random() * 6) * 20;
				//_point[3].vZ = _point[4].vZ = (3 - Math.random() * 6) * 20;
				f = 0;
			}
			
			for (var p:int = 0; p < 8; p++) {
				_point[p].vY -= .5;
				_point[p].update();
				_point[p].constrainBounds(_left, _right, _bottom, _top, _back, _front);
			}
			
			for (var s:int = 0; s < 28; s++) {
				_stick[s].update();
			}
			
			_verletVertices[0]  = _verletVertices[27] = _verletVertices[48] = _point[0].x;
			_verletVertices[1]  = _verletVertices[28] = _verletVertices[49] = _point[0].y;
			_verletVertices[2]  = _verletVertices[29] = _verletVertices[50] = _point[0].z;
			
			_verletVertices[3]  = _verletVertices[33] = _verletVertices[54] = _point[1].x;
			_verletVertices[4]  = _verletVertices[34] = _verletVertices[55] = _point[1].y;
			_verletVertices[5]  = _verletVertices[35] = _verletVertices[56] = _point[1].z;
			
			_verletVertices[6]  = _verletVertices[24] = _verletVertices[60] = _point[2].x;
			_verletVertices[7]  = _verletVertices[25] = _verletVertices[61] = _point[2].y;
			_verletVertices[8]  = _verletVertices[26] = _verletVertices[62] = _point[2].z;
			
			_verletVertices[9]  = _verletVertices[30] = _verletVertices[66] = _point[3].x;
			_verletVertices[10] = _verletVertices[31] = _verletVertices[67] = _point[3].y;
			_verletVertices[11] = _verletVertices[32] = _verletVertices[68] = _point[3].z;
			
			_verletVertices[12] = _verletVertices[39] = _verletVertices[51] = _point[4].x;
			_verletVertices[13] = _verletVertices[40] = _verletVertices[52] = _point[4].y;
			_verletVertices[14] = _verletVertices[41] = _verletVertices[53] = _point[4].z;
			
			_verletVertices[15] = _verletVertices[45] = _verletVertices[57] = _point[5].x;
			_verletVertices[16] = _verletVertices[46] = _verletVertices[58] = _point[5].y;
			_verletVertices[17] = _verletVertices[47] = _verletVertices[59] = _point[5].z;
			
			_verletVertices[18] = _verletVertices[36] = _verletVertices[63] = _point[6].x;
			_verletVertices[19] = _verletVertices[37] = _verletVertices[64] = _point[6].y;
			_verletVertices[20] = _verletVertices[38] = _verletVertices[65] = _point[6].z;
			
			_verletVertices[21] = _verletVertices[42] = _verletVertices[69] = _point[7].x;
			_verletVertices[22] = _verletVertices[43] = _verletVertices[70] = _point[7].y;
			_verletVertices[23] = _verletVertices[44] = _verletVertices[71] = _point[7].z;
			
			this.geometry.subGeometries[0].updateVertexData(_verletVertices);
		}
		
		public function setBounds(left_:Number, right_:Number, bottom_:Number, top_:Number, back_:Number, front_:Number):void
		{
			_left = left_;
			_right = right_;
			_bottom = bottom_;
			_top = top_;
			_back = back_;
			_front = front_;
		}
		
	}
}