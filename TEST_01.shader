Shader "Custom/TEST_01"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_ColorA ("First Color", Color) = (1,1,1,1)
		_ColorB ("Second Color", Color) = (1,1,1,1)
		_ColorC ("Third Color", Color) = (1,1,1,1)
		_ColorD ("Fourth Color", Color) = (1,1,1,1)
		_Middle ("Middle", Range(0.001,0.999)) = 1
	}
	SubShader
	{
		Tags { "Queue"="Background" "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			//#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float2 texcoord : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			fixed4 _ColorA;
			fixed4 _ColorB;
			fixed4 _ColorC;
			fixed4 _ColorD;

			float _Middle;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
			    float2 coord = i.texcoord.xy/_ScreenParams.xy;

				fixed4 c = lerp(_ColorA, _ColorB, i.texcoord.y / _Middle) * step(i.texcoord.y, _Middle);
				i.texcoord.xy += sin(( i.texcoord.x + _Time * _ColorA) * _ColorC) + cos(( i.texcoord.y + _Time * _ColorB) * _ColorD) *_ColorA;
				c += lerp(_ColorA, _ColorC, (i.texcoord.y - _Middle) / (1 - _Middle)) * step(_Middle, i.texcoord.y);
				//c += lerp(_ColorC, _ColorD, (i.texcoord.x - _Middle) / (1 - _Middle)) * step(_Middle, i.texcoord.x);
				c.a = 1;
				return c;
				// sample the texture
				//fixed4 col = tex2D(_MainTex, i.uv);
				// apply fog
				//UNITY_APPLY_FOG(i.fogCoord, col);
				//return col;
			}
			ENDCG
		}
	}
}
