//- Substance 3D Painter Cyberpunk 2077 Multilayered PBR shader
//- ============================================
//-
//- Import from libraries.
import lib-pbr.glsl
import lib-emissive.glsl
import lib-sampler.glsl
import lib-utils.glsl

#define NB_MATERIALS 20
#define NB_MASKS     (NB_MATERIALS - 1)

//: metadata {
//:   "custom-ui": "cyberpunk-multilayered/custom-ui.qml"
//: }

//: materials [
//:   {
//:      "id": "Material1",
//:      "label": "Material 1",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material2",
//:      "label": "Material 2",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material3",
//:      "label": "Material 3",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material4",
//:      "label": "Material 4",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material5",
//:      "label": "Material 5",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material6",
//:      "label": "Material 6",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material7",
//:      "label": "Material 7",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material8",
//:      "label": "Material 8",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material9",
//:      "label": "Material 9",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material10",
//:      "label": "Material 10",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material11",
//:      "label": "Material 11",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material12",
//:      "label": "Material 12",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material13",
//:      "label": "Material 13",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material14",
//:      "label": "Material 14",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material15",
//:      "label": "Material 15",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material16",
//:      "label": "Material 16",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material17",
//:      "label": "Material 17",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material18",
//:      "label": "Material 18",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material19",
//:      "label": "Material 19",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   },
//:   {
//:      "id": "Material20",
//:      "label": "Material 20",
//:      "default": "",
//:      "size": 1024,
//:      "default_color": [0.5, 0.5, 0.5]
//:   }
//: ]


//: stacks [
//:   {
//:	    "id": "Mask1",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask2",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask3",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask4",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask5",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask6",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask7",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask8",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask9",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask10",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask11",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask12",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask13",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask14",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask15",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask16",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask17",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask18",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   },
//:   {
//:	    "id": "Mask19",
//:     "channels":
//:		[
//:			{"id": "blendingmask"}
//:		]
//:   }
//: ]



//: param custom { "default": false, "label": "Debug Mode" }
uniform bool DebugMode;

//: param custom {
//:   "default": 0,
//:   "label": "Debug channel",
//:   "widget": "combobox",
//:   "values": {
//:     "BaseColor": 0,
//:     "Roughness": 1,
//:     "Metallic": 2,
//:     "Normal (Material)": 3,
//:     "Normal (Masks)": 4,
//:     "Normal (Combined)": 5,
//:     "Mask 1": 6,
//:     "Mask 2": 7,
//:     "Mask 3": 8,
//:     "Mask 4": 9,
//:     "Mask 5": 10,
//:     "Mask 6": 11,
//:     "Mask 7": 12,
//:     "Mask 8": 13,
//:     "Mask 9": 14,
//:     "Mask 10": 15,
//:     "Mask 11": 16,
//:     "Mask 12": 17,
//:     "Mask 13": 18,
//:     "Mask 14": 19,
//:     "Mask 15": 20,
//:     "Mask 16": 21,
//:     "Mask 17": 22,
//:     "Mask 18": 23,
//:     "Mask 19": 24
//:   }
//: }
uniform int DebugChannel;


//---------------------------------------------------------------
//- Channels needed for metal/rough workflow are bound here.
//---------------------------------------------------------------

//: param auto texture_normal;
uniform sampler2D mesh_normal_texture;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 1" }
uniform float u_coords1;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 2" }
uniform float u_coords2;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 3" }
uniform float u_coords3;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 4" }
uniform float u_coords4;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 5" }
uniform float u_coords5;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 6" }
uniform float u_coords6;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 7" }
uniform float u_coords7;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 8" }
uniform float u_coords8;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 9" }
uniform float u_coords9;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 10" }
uniform float u_coords10;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 11" }
uniform float u_coords11;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 12" }
uniform float u_coords12;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 13" }
uniform float u_coords13;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 14" }
uniform float u_coords14;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 15" }
uniform float u_coords15;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 16" }
uniform float u_coords16;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 17" }
uniform float u_coords17;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 18" }
uniform float u_coords18;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 19" }
uniform float u_coords19;

//: param custom { "default": 10.1, "label": "Tiling (matTile)", "min": 0.01, "max": 128.0, "group" : "Material 20" }
uniform float u_coords20;


//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 1" }
uniform float normal_intensity1;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 2" }
uniform float normal_intensity2;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 3" }
uniform float normal_intensity3;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 4" }
uniform float normal_intensity4;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 5" }
uniform float normal_intensity5;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 6" }
uniform float normal_intensity6;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 7" }
uniform float normal_intensity7;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 8" }
uniform float normal_intensity8;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 9" }
uniform float normal_intensity9;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 10" }
uniform float normal_intensity10;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 11" }
uniform float normal_intensity11;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 12" }
uniform float normal_intensity12;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 13" }
uniform float normal_intensity13;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 14" }
uniform float normal_intensity14;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 15" }
uniform float normal_intensity15;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 16" }
uniform float normal_intensity16;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 17" }
uniform float normal_intensity17;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 18" }
uniform float normal_intensity18;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 19" }
uniform float normal_intensity19;

//: param custom { "default": 1, "label": "Normal Intensity (normalStrength)", "min": 0.0, "max": 1.0, "group" : "Material 20" }
uniform float normal_intensity20;


//: param auto Material1.channel_basecolor
uniform sampler2D color1;

//: param auto Material1.channel_roughness
uniform sampler2D rough1;

//: param auto Material1.channel_metallic
uniform sampler2D metal1;

//: param auto Material1.channel_normal
uniform sampler2D normal1;


//: param auto Material2.channel_basecolor
uniform sampler2D color2;

//: param auto Material2.channel_roughness
uniform sampler2D rough2;

//: param auto Material2.channel_metallic
uniform sampler2D metal2;

//: param auto Material2.channel_normal
uniform sampler2D normal2;


//: param auto Material3.channel_basecolor
uniform sampler2D color3;

//: param auto Material3.channel_roughness
uniform sampler2D rough3;

//: param auto Material3.channel_metallic
uniform sampler2D metal3;

//: param auto Material3.channel_normal
uniform sampler2D normal3;


//: param auto Material4.channel_basecolor
uniform sampler2D color4;

//: param auto Material4.channel_roughness
uniform sampler2D rough4;

//: param auto Material4.channel_metallic
uniform sampler2D metal4;

//: param auto Material4.channel_normal
uniform sampler2D normal4;


//: param auto Material5.channel_basecolor
uniform sampler2D color5;

//: param auto Material5.channel_roughness
uniform sampler2D rough5;

//: param auto Material5.channel_metallic
uniform sampler2D metal5;

//: param auto Material5.channel_normal
uniform sampler2D normal5;


//: param auto Material6.channel_basecolor
uniform sampler2D color6;

//: param auto Material6.channel_roughness
uniform sampler2D rough6;

//: param auto Material6.channel_metallic
uniform sampler2D metal6;

//: param auto Material6.channel_normal
uniform sampler2D normal6;


//: param auto Material7.channel_basecolor
uniform sampler2D color7;

//: param auto Material7.channel_roughness
uniform sampler2D rough7;

//: param auto Material7.channel_metallic
uniform sampler2D metal7;

//: param auto Material7.channel_normal
uniform sampler2D normal7;


//: param auto Material8.channel_basecolor
uniform sampler2D color8;

//: param auto Material8.channel_roughness
uniform sampler2D rough8;

//: param auto Material8.channel_metallic
uniform sampler2D metal8;

//: param auto Material8.channel_normal
uniform sampler2D normal8;


//: param auto Material9.channel_basecolor
uniform sampler2D color9;

//: param auto Material9.channel_roughness
uniform sampler2D rough9;

//: param auto Material9.channel_metallic
uniform sampler2D metal9;

//: param auto Material9.channel_normal
uniform sampler2D normal9;


//: param auto Material10.channel_basecolor
uniform sampler2D color10;

//: param auto Material10.channel_roughness
uniform sampler2D rough10;

//: param auto Material10.channel_metallic
uniform sampler2D metal10;

//: param auto Material10.channel_normal
uniform sampler2D normal10;


//: param auto Material11.channel_basecolor
uniform sampler2D color11;

//: param auto Material11.channel_roughness
uniform sampler2D rough11;

//: param auto Material11.channel_metallic
uniform sampler2D metal11;

//: param auto Material11.channel_normal
uniform sampler2D normal11;


//: param auto Material12.channel_basecolor
uniform sampler2D color12;

//: param auto Material12.channel_roughness
uniform sampler2D rough12;

//: param auto Material12.channel_metallic
uniform sampler2D metal12;

//: param auto Material12.channel_normal
uniform sampler2D normal12;


//: param auto Material13.channel_basecolor
uniform sampler2D color13;

//: param auto Material13.channel_roughness
uniform sampler2D rough13;

//: param auto Material13.channel_metallic
uniform sampler2D metal13;

//: param auto Material13.channel_normal
uniform sampler2D normal13;


//: param auto Material14.channel_basecolor
uniform sampler2D color14;

//: param auto Material14.channel_roughness
uniform sampler2D rough14;

//: param auto Material14.channel_metallic
uniform sampler2D metal14;

//: param auto Material14.channel_normal
uniform sampler2D normal14;


//: param auto Material15.channel_basecolor
uniform sampler2D color15;

//: param auto Material15.channel_roughness
uniform sampler2D rough15;

//: param auto Material15.channel_metallic
uniform sampler2D metal15;

//: param auto Material15.channel_normal
uniform sampler2D normal15;


//: param auto Material16.channel_basecolor
uniform sampler2D color16;

//: param auto Material16.channel_roughness
uniform sampler2D rough16;

//: param auto Material16.channel_metallic
uniform sampler2D metal16;

//: param auto Material16.channel_normal
uniform sampler2D normal16;


//: param auto Material17.channel_basecolor
uniform sampler2D color17;

//: param auto Material17.channel_roughness
uniform sampler2D rough17;

//: param auto Material17.channel_metallic
uniform sampler2D metal17;

//: param auto Material17.channel_normal
uniform sampler2D normal17;


//: param auto Material18.channel_basecolor
uniform sampler2D color18;

//: param auto Material18.channel_roughness
uniform sampler2D rough18;

//: param auto Material18.channel_metallic
uniform sampler2D metal18;

//: param auto Material18.channel_normal
uniform sampler2D normal18;


//: param auto Material19.channel_basecolor
uniform sampler2D color19;

//: param auto Material19.channel_roughness
uniform sampler2D rough19;

//: param auto Material19.channel_metallic
uniform sampler2D metal19;

//: param auto Material19.channel_normal
uniform sampler2D normal19;


//: param auto Material20.channel_basecolor
uniform sampler2D color20;

//: param auto Material20.channel_roughness
uniform sampler2D rough20;

//: param auto Material20.channel_metallic
uniform sampler2D metal20;

//: param auto Material20.channel_normal
uniform sampler2D normal20;


//: param auto Mask1.channel_blendingmask
uniform SamplerSparse mask1;

//: param auto Mask2.channel_blendingmask
uniform SamplerSparse mask2;

//: param auto Mask3.channel_blendingmask
uniform SamplerSparse mask3;

//: param auto Mask4.channel_blendingmask
uniform SamplerSparse mask4;

//: param auto Mask5.channel_blendingmask
uniform SamplerSparse mask5;

//: param auto Mask6.channel_blendingmask
uniform SamplerSparse mask6;

//: param auto Mask7.channel_blendingmask
uniform SamplerSparse mask7;

//: param auto Mask8.channel_blendingmask
uniform SamplerSparse mask8;

//: param auto Mask9.channel_blendingmask
uniform SamplerSparse mask9;

//: param auto Mask10.channel_blendingmask
uniform SamplerSparse mask10;

//: param auto Mask11.channel_blendingmask
uniform SamplerSparse mask11;

//: param auto Mask12.channel_blendingmask
uniform SamplerSparse mask12;

//: param auto Mask13.channel_blendingmask
uniform SamplerSparse mask13;

//: param auto Mask14.channel_blendingmask
uniform SamplerSparse mask14;

//: param auto Mask15.channel_blendingmask
uniform SamplerSparse mask15;

//: param auto Mask16.channel_blendingmask
uniform SamplerSparse mask16;

//: param auto Mask17.channel_blendingmask
uniform SamplerSparse mask17;

//: param auto Mask18.channel_blendingmask
uniform SamplerSparse mask18;

//: param auto Mask19.channel_blendingmask
uniform SamplerSparse mask19;


/////////////////////////////////////////
////////// BLENDING FUNCTIONS ///////////
/////////////////////////////////////////

float mixGrayscale(
	float channelSampled[NB_MATERIALS],
	float Masks[NB_MASKS])
{
	float result = channelSampled[0];
	for (int i = 0; i < NB_MASKS; i++)
		result = mix(result, channelSampled[i + 1], Masks[i]);

	return result;
}

vec3 mixColor(
	vec3 channelSampled[NB_MATERIALS],
	float Masks[NB_MASKS])
{
	vec3 result = channelSampled[0];
	for (int i = 0; i < NB_MASKS; i++)
		result = mix(result, channelSampled[i + 1], Masks[i]);

	return result;
}

vec3 mixNormal(
	vec3 channelSampled[NB_MATERIALS],
	float Masks[NB_MASKS],
	float NormalIntensity[NB_MATERIALS])
{
	vec3 result = NormalIntensity[0] * channelSampled[0];
	for (int i = 0; i < NB_MASKS; i++)
		result = mix(result, NormalIntensity[i + 1] * channelSampled[i + 1], Masks[i]);

	return result;
}


void shade(V2F inputs)
{
	//-----------------------------------------------------------------------
	//Global textures
	//-----------------------------------------------------------------------
	// Get detail (ambient occlusion) and global (shadow) occlusion factors
	float occlusion = getAO(inputs.sparse_coord) * getShadowFactor();
	vec3 mesh_normal = normalUnpack(textureSparse(base_normal_texture, inputs.sparse_coord), base_normal_y_coeff);

	//-----------------------------------------------------------------------
	//Materials Masks
	//-----------------------------------------------------------------------
	float UVscale[NB_MATERIALS] = float[NB_MATERIALS](
		u_coords1, u_coords2, u_coords3, u_coords4, u_coords5,
		u_coords6, u_coords7, u_coords8, u_coords9, u_coords10,
        u_coords11, u_coords12, u_coords13, u_coords14, u_coords15,
        u_coords16, u_coords17, u_coords18, u_coords19, u_coords20);

	float NormalIntensity[NB_MATERIALS] = float[NB_MATERIALS](
		normal_intensity1, normal_intensity2, normal_intensity3, normal_intensity4,
		normal_intensity5, normal_intensity6, normal_intensity7, normal_intensity8,
		normal_intensity9, normal_intensity10, normal_intensity11, normal_intensity12,
        normal_intensity13, normal_intensity14, normal_intensity15, normal_intensity16,
        normal_intensity17, normal_intensity18, normal_intensity19, normal_intensity20);

	float Masks[NB_MASKS] = float[NB_MASKS](
		textureSparse(mask1,  inputs.sparse_coord).r, textureSparse(mask2, inputs.sparse_coord).r,
		textureSparse(mask3, inputs.sparse_coord).r, textureSparse(mask4, inputs.sparse_coord).r,
		textureSparse(mask5, inputs.sparse_coord).r, textureSparse(mask6, inputs.sparse_coord).r,
		textureSparse(mask7, inputs.sparse_coord).r, textureSparse(mask8, inputs.sparse_coord).r,
		textureSparse(mask9, inputs.sparse_coord).r, textureSparse(mask10, inputs.sparse_coord).r,
		textureSparse(mask11, inputs.sparse_coord).r, textureSparse(mask12, inputs.sparse_coord).r,
		textureSparse(mask13, inputs.sparse_coord).r, textureSparse(mask14, inputs.sparse_coord).r,
		textureSparse(mask15, inputs.sparse_coord).r, textureSparse(mask16, inputs.sparse_coord).r,
		textureSparse(mask17, inputs.sparse_coord).r, textureSparse(mask18, inputs.sparse_coord).r,
        textureSparse(mask19, inputs.sparse_coord).r);

	//-----------------------------------------------------------------------
	//Mixing
	//-----------------------------------------------------------------------
	float roughSampled[NB_MATERIALS] = float[NB_MATERIALS](
		getRoughness(rough1,  inputs.tex_coord*UVscale[0]),
		getRoughness(rough2,  inputs.tex_coord*UVscale[1]),
		getRoughness(rough3,  inputs.tex_coord*UVscale[2]),
		getRoughness(rough4,  inputs.tex_coord*UVscale[3]),
		getRoughness(rough5,  inputs.tex_coord*UVscale[4]),
		getRoughness(rough6,  inputs.tex_coord*UVscale[5]),
		getRoughness(rough7,  inputs.tex_coord*UVscale[6]),
		getRoughness(rough8,  inputs.tex_coord*UVscale[7]),
		getRoughness(rough9,  inputs.tex_coord*UVscale[8]),
		getRoughness(rough10,  inputs.tex_coord*UVscale[9]),
		getRoughness(rough11,  inputs.tex_coord*UVscale[10]),
		getRoughness(rough12,  inputs.tex_coord*UVscale[11]),
		getRoughness(rough13,  inputs.tex_coord*UVscale[12]),
		getRoughness(rough14,  inputs.tex_coord*UVscale[13]),
		getRoughness(rough15,  inputs.tex_coord*UVscale[14]),
		getRoughness(rough16,  inputs.tex_coord*UVscale[15]),
		getRoughness(rough17,  inputs.tex_coord*UVscale[16]),
		getRoughness(rough18,  inputs.tex_coord*UVscale[17]),
		getRoughness(rough19,  inputs.tex_coord*UVscale[18]),
		getRoughness(rough20,  inputs.tex_coord*UVscale[19])
	);

	float metallicSampled[NB_MATERIALS] = float[NB_MATERIALS](
		getMetallic(metal1,  inputs.tex_coord*UVscale[0]),
		getMetallic(metal2,  inputs.tex_coord*UVscale[1]),
		getMetallic(metal3,  inputs.tex_coord*UVscale[2]),
		getMetallic(metal4,  inputs.tex_coord*UVscale[3]),
		getMetallic(metal5,  inputs.tex_coord*UVscale[4]),
		getMetallic(metal6,  inputs.tex_coord*UVscale[5]),
		getMetallic(metal7,  inputs.tex_coord*UVscale[6]),
		getMetallic(metal8,  inputs.tex_coord*UVscale[7]),
		getMetallic(metal9,  inputs.tex_coord*UVscale[8]),
		getMetallic(metal10,  inputs.tex_coord*UVscale[9]),
		getMetallic(metal11,  inputs.tex_coord*UVscale[10]),
		getMetallic(metal12,  inputs.tex_coord*UVscale[11]),
		getMetallic(metal13,  inputs.tex_coord*UVscale[12]),
		getMetallic(metal14,  inputs.tex_coord*UVscale[13]),
		getMetallic(metal15,  inputs.tex_coord*UVscale[14]),
		getMetallic(metal16,  inputs.tex_coord*UVscale[15]),
		getMetallic(metal17,  inputs.tex_coord*UVscale[16]),
		getMetallic(metal18,  inputs.tex_coord*UVscale[17]),
		getMetallic(metal19,  inputs.tex_coord*UVscale[18]),
		getMetallic(metal20,  inputs.tex_coord*UVscale[19])
	);

	vec3 basecolorSampled[NB_MATERIALS] = vec3[NB_MATERIALS](
		getBaseColor(color1,  inputs.tex_coord*UVscale[0]),
		getBaseColor(color2,  inputs.tex_coord*UVscale[1]),
		getBaseColor(color3,  inputs.tex_coord*UVscale[2]),
		getBaseColor(color4,  inputs.tex_coord*UVscale[3]),
		getBaseColor(color5,  inputs.tex_coord*UVscale[4]),
		getBaseColor(color6,  inputs.tex_coord*UVscale[5]),
		getBaseColor(color7,  inputs.tex_coord*UVscale[6]),
		getBaseColor(color8,  inputs.tex_coord*UVscale[7]),
		getBaseColor(color9,  inputs.tex_coord*UVscale[8]),
		getBaseColor(color10,  inputs.tex_coord*UVscale[9]),
		getBaseColor(color11,  inputs.tex_coord*UVscale[10]),
		getBaseColor(color12,  inputs.tex_coord*UVscale[11]),
		getBaseColor(color13,  inputs.tex_coord*UVscale[12]),
		getBaseColor(color14,  inputs.tex_coord*UVscale[13]),
		getBaseColor(color15,  inputs.tex_coord*UVscale[14]),
		getBaseColor(color16,  inputs.tex_coord*UVscale[15]),
		getBaseColor(color17,  inputs.tex_coord*UVscale[16]),
		getBaseColor(color18,  inputs.tex_coord*UVscale[17]),
		getBaseColor(color19,  inputs.tex_coord*UVscale[18]),
		getBaseColor(color20,  inputs.tex_coord*UVscale[19])
	);

	vec3 normalSampled[NB_MATERIALS] = vec3[NB_MATERIALS](
		normalUnpack(texture(normal1,  inputs.tex_coord*UVscale[0])),
		normalUnpack(texture(normal2,  inputs.tex_coord*UVscale[1])),
		normalUnpack(texture(normal3,  inputs.tex_coord*UVscale[2])),
		normalUnpack(texture(normal4,  inputs.tex_coord*UVscale[3])),
		normalUnpack(texture(normal5,  inputs.tex_coord*UVscale[4])),
		normalUnpack(texture(normal6,  inputs.tex_coord*UVscale[5])),
		normalUnpack(texture(normal7,  inputs.tex_coord*UVscale[6])),
		normalUnpack(texture(normal8,  inputs.tex_coord*UVscale[7])),
		normalUnpack(texture(normal9,  inputs.tex_coord*UVscale[8])),
		normalUnpack(texture(normal10,  inputs.tex_coord*UVscale[9])),
		normalUnpack(texture(normal11,  inputs.tex_coord*UVscale[10])),
		normalUnpack(texture(normal12,  inputs.tex_coord*UVscale[11])),
		normalUnpack(texture(normal13,  inputs.tex_coord*UVscale[12])),
		normalUnpack(texture(normal14,  inputs.tex_coord*UVscale[13])),
		normalUnpack(texture(normal15,  inputs.tex_coord*UVscale[14])),
		normalUnpack(texture(normal16,  inputs.tex_coord*UVscale[15])),
		normalUnpack(texture(normal17,  inputs.tex_coord*UVscale[16])),
		normalUnpack(texture(normal18,  inputs.tex_coord*UVscale[17])),
		normalUnpack(texture(normal19,  inputs.tex_coord*UVscale[18])),
		normalUnpack(texture(normal20,  inputs.tex_coord*UVscale[19]))
	);

	float roughness = mixGrayscale(roughSampled, Masks);
	float metallic = mixGrayscale(metallicSampled, Masks);
	vec3 basecolor = mixColor(basecolorSampled, Masks);
	vec3 diffColor = generateDiffuseColor(basecolor, metallic);
	vec3 specColor = generateSpecularColor(basecolor, metallic);
	float specOcclusion = specularOcclusionCorrection(occlusion, metallic, roughness);

	//Normal channel
	vec3 normal = mixNormal(normalSampled, Masks, NormalIntensity);
	normal = normalize( vec3(normal.xy + mesh_normal.xy, mesh_normal.z) ); //UDN combine method

	vec3 finalNormal = normal;
	vec3 normalMask = vec3(0.0, 0.0, 1.0);

	//-----------------------------------------------------------------------
	//Final
	//-----------------------------------------------------------------------
	//Debug mode display result of combined channels or Masks
	if( !DebugMode ) {
		vec3 finalNormalWorldSpace = normalize(
			finalNormal.x * inputs.tangent +
			finalNormal.y * inputs.bitangent +
			finalNormal.z * inputs.normal);
		// Feed parameters for a physically based BRDF integration.
		LocalVectors vectors = computeLocalFrame(inputs, finalNormalWorldSpace, 0.0);
		emissiveColorOutput(pbrComputeEmissive(emissive_tex, inputs.sparse_coord));
		diffuseShadingOutput(occlusion * pbrComputeDiffuse(vectors.normal, diffColor));
		specularShadingOutput(specOcclusion * pbrComputeSpecular(vectors, specColor, roughness));
	} else {
		vec3 result;

		//BaseColor combined
		if( DebugChannel == 0 ) {
			result = basecolor;
		}

		//Roughness combined
		else if( DebugChannel == 1 ) {
			result = vec3(roughness);
		}

		//Metallic combined
		else if( DebugChannel == 2 ) {
			result = vec3(metallic);
		}

		//Normal combined
		else if( DebugChannel == 3) {
			normal = 0.5 * normal + vec3(0.5);
			result = sRGB2linear(normal);
		}

		//Combined masks as Normal
		else if( DebugChannel == 4 ) {
			normalMask = 0.5 * normalMask + vec3(0.5);
			result = sRGB2linear(normalMask);
		}

		//Final Normal
		else if( DebugChannel == 5 ) {
			finalNormal = 0.5 * finalNormal + vec3(0.5);
			result = sRGB2linear(finalNormal);
		}

		//Mask(s)
		else {
			result = vec3(sRGB2linear(Masks[DebugChannel - 6]));
		}

		diffuseShadingOutput(result);
	}
}
