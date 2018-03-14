// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

 Shader "Custom/GradientShader_XY" {
     Properties {
         [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
         _ColorTop ("Top Color", Color) = (1,1,1,1)
         _ColorMid ("Mid Color", Color) = (1,1,1,1)
         _ColorBot ("Bot Color", Color) = (1,1,1,1)
         _ColorH ("H Color", Color) = (1,1,1,1)
         _ColorK ("K Color", Color) = (1,1,1,1)
         _ColorM ("M Color", Color) = (1,1,1,1)
         _Middle ("Middle", Range(0.001, 0.999)) = 1
     }
 
     SubShader {
         Tags {"Queue"="Background"  "IgnoreProjector"="True"}
         LOD 100
 
         ZWrite On
 
         Pass {
         CGPROGRAM
         #pragma vertex vert  
         #pragma fragment frag
         #include "UnityCG.cginc"
 
         fixed4 _ColorTop;
         fixed4 _ColorMid;
         fixed4 _ColorBot;
         fixed4 _ColorH;
         fixed4 _ColorK;
         fixed4 _ColorM;
         float  _Middle;
         float _Point;
 
         struct v2f {
             float4 pos : SV_POSITION;
             float4 texcoord : TEXCOORD0;
         };
 
         v2f vert (appdata_full v) {
             v2f o;
             o.pos = UnityObjectToClipPos (v.vertex);
             o.texcoord = v.texcoord;
             return o;
         }
 
         fixed4 frag (v2f i) : COLOR {
             fixed4 c = lerp(_ColorBot, _ColorMid, i.texcoord.y / _Middle) * step(i.texcoord.y, _Middle) + lerp(_ColorBot, _ColorMid, i.texcoord.x / _Middle) * step(i.texcoord.x, _Middle);
             c += lerp(_ColorMid, _ColorTop, (i.texcoord.y - _Middle) / (1 - _Middle)) * step(_Middle, i.texcoord.y) + lerp(_ColorMid, _ColorTop, (i.texcoord.x - _Middle) / (1 - _Middle)) * step(_Middle, i.texcoord.x);

             fixed4 c2 = lerp(_ColorH, _ColorK, i.texcoord.y / _Point) * step(i.texcoord.y, _Point) + lerp(_ColorM, _ColorK, i.texcoord.x / _Point) * step(i.texcoord.x, _Point);
             c2 += lerp(_ColorK, _ColorH, (i.texcoord.y - _Point) / (1 - _Point)) * step(_Point, i.texcoord.y) + lerp(_ColorK, _ColorH, (i.texcoord.x - _Point) / (1 - _Point)) * step(_Point, i.texcoord.x);

             c.a = 1;
             c2.a = 1;
             return c, c2;
         }
         ENDCG
         }
     }
 }