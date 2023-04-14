import os
import sd
import json
from sd.tools import io
from sd.ui.graphgrid import *
from sd.api.sbs.sdsbscompgraph import *
from sd.api.sdvaluecolorrgba import *
from sd.api.sdvaluefloat import *
from sd.api.sdvaluefloat4 import *
from sd.api.sdvalueusage import *
from sd.api.sdvaluearray import *
from sd.api.sdvalueenum import *
from sd.api.sdvaluestring import *
from sd.api.sdvaluestruct import *
from sd.api.sdvaluebool import *
from sd.api.sdtypeusage import *
from sd.api.sdtypestruct import *
from sd.api.sdtypecolorrgba import *
from sd.api.sdtexture import *
from sd.api.sdresourcebitmap import *
from sd.api.sdresourcefolder import *
from sd.api.sdarray import *

def main(aSDContext):

    # =========================================================================
    # User input
    
    # Full system file path leading to exported templates and textures (i.e. C:\\modding\\cyberpunk\\wolvenkitproject\\source\\raw)
    BasePath = "Q:\\77.modding\\77.wkitprojects\\mltemplate\\source\\raw\\"
    
    # Raw texture format of exported textures (.png, .tga, etc.)
    # TGA is recommended for now due to potential color space issues with WolvenKit PNG exports
    rawTextureFormat = ".tga"

    # (optional) Set path to PNG format previews named after each mltemplate to include previews
    previewsPath = ("")

    # End of user input

    # =========================================================================
    # Create a new Package
    
    cGridSize = GraphGrid.sGetFirstLevelSize()
    sbsPackageName = "Cyberpunk 2077 Materials"
    
    sdPackageMgr = aSDContext.getSDApplication().getPackageMgr()
    sdPackage = sdPackageMgr.newUserPackage()

    sdResource = SDResourceFolder.sNew(sdPackage)
    sdResource.setIdentifier("Resources")

    # =========================================================================
    # Create list of mltemplate json files exported by WolvenKit

    fileList = os.listdir(BasePath)
    for (dirpath, dirnames, filenames) in os.walk(BasePath):
        fileList += [os.path.join(dirpath, file) for file in filenames]

    templateList = [ file for file in fileList if file.endswith(".mltemplate.json")]


    # =========================================================================
    # Iterate through each xxx.mltemplate.json file building a substance compositing graph for each
    for elem in templateList:
        try:
            print(("Reading",elem))
            file = open(elem,mode='r')
            data = json.loads(file.read())
            template_name = os.path.basename(elem)
            template_name_noext = os.path.splitext(template_name)[0]
            template_name_noext2 = os.path.splitext(template_name_noext)[0]
            template_name_png = template_name_noext2 + (".png")


            # =========================================================================
            # Create a new Substance Compositing Graph in this package
            sdSBSCompGraph = SDSBSCompGraph.sNew(sdPackage)
            sdSBSCompGraph.setIdentifier(template_name_noext2)
            graphTags = SDValueString.sNew("Cyberpunk, 2077")
            sdSBSCompGraph.setAnnotationPropertyValueFromId('tags', graphTags)

            if previewsPath != (""):
                sdTexture = SDTexture.sFromFile(previewsPath+template_name_png)
                sdSBSCompGraph.setIcon(sdTexture)


            # =========================================================================
            # Setup linked bitmap texture paths

            colorTextureRelativePath = data["Data"]["RootChunk"]["colorTexture"]["DepotPath"]
            normalTextureRelativePath = data["Data"]["RootChunk"]["normalTexture"]["DepotPath"]
            roughnessTextureRelativePath = data["Data"]["RootChunk"]["roughnessTexture"]["DepotPath"]
            metalnessTextureRelativePath = data["Data"]["RootChunk"]["metalnessTexture"]["DepotPath"]

            colorTextureFullPath = BasePath + (os.path.splitext(colorTextureRelativePath)[0]+rawTextureFormat)
            normalTextureFullPath = BasePath + (os.path.splitext(normalTextureRelativePath)[0]+rawTextureFormat)
            roughnessTextureFullPath = BasePath + (os.path.splitext(roughnessTextureRelativePath)[0]+rawTextureFormat)
            metalnessTextureFullPath = BasePath + (os.path.splitext(metalnessTextureRelativePath)[0]+rawTextureFormat)

            colorTextureFilename = os.path.basename(colorTextureRelativePath)
            normalTextureFilename = os.path.basename(normalTextureRelativePath)
            roughnessTextureFilename = os.path.basename(roughnessTextureRelativePath)
            metalnessTextureFilename = os.path.basename(metalnessTextureRelativePath)

            colorTextureIdentifier = colorTextureFilename.replace(".xbm", "")
            normalTextureIdentifier = normalTextureFilename.replace(".xbm", "")
            roughnessTextureIdentifier = roughnessTextureFilename.replace(".xbm", "")
            metalnessTextureIdentifier = metalnessTextureFilename.replace(".xbm", "")

            # TODO: prevent duplicate resources
            #textureTable = sdResource.getChildren(False)
            #for elem in textureTable:
                #resourceIdentifier = elem.getIdentifier()


            # Color
            colorSDResourceBitmap = SDResourceBitmap.sNewFromFile(sdResource, colorTextureFullPath, EmbedMethod.Linked)
            colorSDResourceBitmap.setIdentifier(colorTextureIdentifier)

            # Normal
            normalSDResourceBitmap = SDResourceBitmap.sNewFromFile(sdResource, normalTextureFullPath, EmbedMethod.Linked)
            normalSDResourceBitmap.setIdentifier(normalTextureIdentifier)

            # Roughness
            roughnessSDResourceBitmap = SDResourceBitmap.sNewFromFile(sdResource, roughnessTextureFullPath, EmbedMethod.Linked)
            roughnessSDResourceBitmap.setIdentifier(roughnessTextureIdentifier)

            # Metalness
            metalnessSDResourceBitmap = SDResourceBitmap.sNewFromFile(sdResource, metalnessTextureFullPath, EmbedMethod.Linked)
            metalnessSDResourceBitmap.setIdentifier(metalnessTextureIdentifier)


            # =========================================================================
            # Define overrides
            colorDefaultOverride = data["Data"]["RootChunk"]["defaultOverrides"]["colorScale"]
            normalDefaultOverride = data["Data"]["RootChunk"]["defaultOverrides"]["normalStrength"]
            roughnessDefaultOverride = data["Data"]["RootChunk"]["defaultOverrides"]["roughLevelsOut"]
            metalnessDefaultOverride = data["Data"]["RootChunk"]["defaultOverrides"]["metalLevelsOut"]
            overrideTable = data["Data"]["RootChunk"]["overrides"]

            Output = {}
            Output["ColorScale"] = {}
            Output["NormalStrength"] = {}
            Output["RoughLevelsOut"] = {}
            Output["MetalLevelsOut"] = {}
            
            for x in overrideTable["colorScale"]:
                overrideName = x["n"]
                colorR = float(x["v"]["Elements"][0])
                colorG = float(x["v"]["Elements"][1])
                colorB = float(x["v"]["Elements"][2])
                Output["ColorScale"][overrideName] = (colorR,colorG,colorB,1)

            for x in overrideTable["normalStrength"]:
                overrideName = x["n"]
                normStrength = 0
                if x.get("v") is not None:
                    normStrength = float(x["v"])
                Output["NormalStrength"][overrideName] = normStrength
                
            for x in overrideTable["roughLevelsOut"]:
                overrideName = x["n"]
                roughOut0 = float(x["v"]["Elements"][1])
                roughOut1 = float(x["v"]["Elements"][0])
                Output["RoughLevelsOut"][overrideName] = [(roughOut0,roughOut0,roughOut0,1),(roughOut1,roughOut1,roughOut1,1)]

            for x in overrideTable["metalLevelsOut"]:
                overrideName = x["n"]
                if x.get("v") is not None:
                    metalOut0 = float(x["v"]["Elements"][0])
                    metalOut1 = float(x["v"]["Elements"][1])
                else:
                    metalOut0 = 0
                    metalOut1 = 1
                Output["MetalLevelsOut"][overrideName] = [(metalOut0,metalOut0,metalOut0,1),(metalOut1,metalOut1,metalOut1,1)]

            if "ColorScale" in Output and colorDefaultOverride in Output["ColorScale"]:
              defaultColor = (Output["ColorScale"][colorDefaultOverride])
            if "NormalStrength" in Output:
              defaultNormal = (Output["NormalStrength"][normalDefaultOverride])
        
            if "RoughLevelsOut" in Output and roughnessDefaultOverride in Output["RoughLevelsOut"]:
              defaultRoughness = (Output["RoughLevelsOut"][roughnessDefaultOverride])
              defaultRoughness0 = defaultRoughness[0]
              defaultRoughness1 = defaultRoughness[1]
      
            if "MetalLevelsOut" in Output and metalnessDefaultOverride in Output["MetalLevelsOut"]:
              defaultMetalness = (Output["MetalLevelsOut"][metalnessDefaultOverride])
              defaultMetalness0 = defaultMetalness[1]
              defaultMetalness1 = defaultMetalness[0]


            # =========================================================================
            # COLOR

            # TODO: Replace uniform color with input color node and set default color (might not be exposed within API)
            #colorCompNodeInput = sdSBSCompGraph.newNode('sbs::compositing::input_color')
            #colorCompNodeInput.setPosition(float2(-2*cGridSize, cGridSize))
            #colorValueColorRGBA = SDValueColorRGBA.sNew(ColorRGBA(defaultColor[0],defaultColor[1],defaultColor[2],defaultColor[3]))

            # Create a uniform color node
            colorCompNodeUniform = sdSBSCompGraph.newNode('sbs::compositing::uniform')
            colorCompNodeUniform.setPosition(float2(-2*cGridSize, cGridSize))
            colorCompNodeUniform.setInputPropertyInheritanceMethodFromId('$format', SDPropertyInheritanceMethod.Absolute)
            colorCompNodeUniform.setInputPropertyValueFromId('$format', SDValueEnum.sFromValueId('sbs::compositing::format', '8_bits_per_channel'))
            colorValueColorRGBA = SDValueColorRGBA.sNew(ColorRGBA(defaultColor[0],defaultColor[1],defaultColor[2],defaultColor[3]))
            colorCompNodeUniform.setInputPropertyValueFromId('outputcolor', colorValueColorRGBA)

            #   - Instantiate the bitmap resource to the graph to have a node that will refers the created bitmap resource
            colorCompNodeBitmap = sdSBSCompGraph.newInstanceNode(colorSDResourceBitmap)
            colorCompNodeBitmap.setPosition(float2(-2*cGridSize, -cGridSize))
            colorCompNodeBitmap.setInputPropertyInheritanceMethodFromId('$format', SDPropertyInheritanceMethod.Absolute)
            colorCompNodeBitmap.setInputPropertyValueFromId('$format', SDValueEnum.sFromValueId('sbs::compositing::format', '8_bits_per_channel'))

            # =========================================================================
            # Create a blend Node
            colorCompNodeBlend = sdSBSCompGraph.newNode('sbs::compositing::blend')
            colorCompNodeBlend.setPosition(float2(0, 0))
            colorCompNodeBlend.setInputPropertyValueFromId('blendingmode', SDValueEnum.sFromValue("sbs::compositing::blendingmode",3))

            # =========================================================================
            # Create an output Node
            colorCompNodeOutput = sdSBSCompGraph.newNode('sbs::compositing::output')
            colorCompNodeOutput.setPosition(float2(2*cGridSize, 0))
            colorsdValueString = SDValueString.sNew("basecolor")
            colorCompNodeOutput.setAnnotationPropertyValueFromId('identifier', colorsdValueString)

            sdValueArray = SDValueArray.sNew(SDTypeUsage.sNew(), 0)
            sdValueUsage = SDValueUsage.sNew(SDUsage.sNew('baseColor', 'RGBA', 'sRGB'))
            sdValueArray.pushBack(sdValueUsage)

            colorCompNodeOutput.setAnnotationPropertyValueFromId('usages', sdValueArray)

            # =========================================================================
            # Create connections
            colorCompNodeBitmap.newPropertyConnectionFromId('unique_filter_output', colorCompNodeBlend, 'destination')
            colorCompNodeUniform.newPropertyConnectionFromId('unique_filter_output', colorCompNodeBlend, 'source')
            colorCompNodeBlend.newPropertyConnectionFromId('unique_filter_output', colorCompNodeOutput, 'inputNodeOutput')




            # =========================================================================
            # NORMAL

            # Create a uniform color node
            normalCompNodeUniform = sdSBSCompGraph.newNode('sbs::compositing::uniform')
            normalCompNodeUniform.setPosition(float2(-2*cGridSize, 5*cGridSize))
            normalCompNodeUniform.setInputPropertyInheritanceMethodFromId('$format', SDPropertyInheritanceMethod.Absolute)
            normalCompNodeUniform.setInputPropertyValueFromId('$format', SDValueEnum.sFromValueId('sbs::compositing::format', '8_bits_per_channel'))
            normalValueColorRGBA = SDValueColorRGBA.sNew(ColorRGBA(0.5, 0.5, 1.0, 1.0))
            normalCompNodeUniform.setInputPropertyValueFromId('outputcolor', normalValueColorRGBA)

            #   - Instantiate the bitmap resource to the graph to have a node that will refers the created bitmap resource
            normalCompNodeBitmap = sdSBSCompGraph.newInstanceNode(normalSDResourceBitmap)
            normalCompNodeBitmap.setPosition(float2(-8*cGridSize, 3*cGridSize))
            normalCompNodeBitmap.setInputPropertyInheritanceMethodFromId('$format', SDPropertyInheritanceMethod.Absolute)
            normalCompNodeBitmap.setInputPropertyValueFromId('$format', SDValueEnum.sFromValueId('sbs::compositing::format', '8_bits_per_channel'))

            # Create RGBA
            normalGrayscale1 = sdSBSCompGraph.newNode('sbs::compositing::grayscaleconversion')
            normalGrayscale1.setPosition(float2(-6.5*cGridSize, 2.5*cGridSize))
            normalWeight1 = SDValueFloat4.sNew(float4(1.0,0,0,0))
            normalGrayscale1.setInputPropertyValueFromId('channelsweights', normalWeight1)

            normalGrayscale2 = sdSBSCompGraph.newNode('sbs::compositing::grayscaleconversion')
            normalGrayscale2.setPosition(float2(-6.5*cGridSize, 3.5*cGridSize))
            normalWeight2 = SDValueFloat4.sNew(float4(0,1,0,0))
            normalGrayscale2.setInputPropertyValueFromId('channelsweights', normalWeight2)

            normalShuffle1 = sdSBSCompGraph.newNode('sbs::compositing::shuffle')
            normalShuffle1.setPosition(float2(-5*cGridSize, 2.5*cGridSize))

            normalShuffle2 = sdSBSCompGraph.newNode('sbs::compositing::shuffle')
            normalShuffle2.setPosition(float2(-3.5*cGridSize, 3.5*cGridSize))
            normalShuffle2.setInputPropertyValueFromId('channelblue', SDValueEnum.sFromValue("sbs::compositing::channelblue",6))
            normalShuffle2.setInputPropertyValueFromId('channelalpha', SDValueEnum.sFromValue("sbs::compositing::channelalpha",7))

            normalFill = sdSBSCompGraph.newNode('sbs::compositing::uniform')
            normalFill.setPosition(float2(-5*cGridSize, 4.5*cGridSize))
            normalFill.setInputPropertyInheritanceMethodFromId('$format', SDPropertyInheritanceMethod.Absolute)
            normalFill.setInputPropertyValueFromId('$format', SDValueEnum.sFromValueId('sbs::compositing::format', '8_bits_per_channel'))
            normalFillValueColorRGBA = SDValueColorRGBA.sNew(ColorRGBA(1.0, 1.0, 1.0, 1.0))
            normalFill.setInputPropertyValueFromId('outputcolor', normalFillValueColorRGBA)


            # =========================================================================
            # Create a blend Node
            normalCompNodeBlend = sdSBSCompGraph.newNode('sbs::compositing::blend')
            normalCompNodeBlend.setPosition(float2(0, 4*cGridSize))
            normalOpacity = SDValueFloat.sNew(defaultNormal)
            normalCompNodeBlend.setInputPropertyValueFromId('opacitymult', normalOpacity)

            # =========================================================================
            # Create an output Node
            normalCompNodeOutput = sdSBSCompGraph.newNode('sbs::compositing::output')
            normalCompNodeOutput.setPosition(float2(2*cGridSize, 4*cGridSize))
            normalsdValueString = SDValueString.sNew("normal")
            normalCompNodeOutput.setAnnotationPropertyValueFromId('identifier', normalsdValueString)

            sdValueArray = SDValueArray.sNew(SDTypeUsage.sNew(), 0)
            sdValueUsage = SDValueUsage.sNew(SDUsage.sNew('normal', 'RGBA', 'Linear'))
            sdValueArray.pushBack(sdValueUsage)

            normalCompNodeOutput.setAnnotationPropertyValueFromId('usages', sdValueArray)

            # =========================================================================
            # Create connections
            normalCompNodeBitmap.newPropertyConnectionFromId('unique_filter_output', normalGrayscale1, 'input1')
            normalCompNodeBitmap.newPropertyConnectionFromId('unique_filter_output', normalGrayscale2, 'input1')
            normalGrayscale1.newPropertyConnectionFromId('unique_filter_output', normalShuffle1, 'input1')
            normalGrayscale2.newPropertyConnectionFromId('unique_filter_output', normalShuffle1, 'input2')
            normalShuffle1.newPropertyConnectionFromId('unique_filter_output', normalShuffle2, 'input1')
            normalFill.newPropertyConnectionFromId('unique_filter_output', normalShuffle2, 'input2')
            normalShuffle2.newPropertyConnectionFromId('unique_filter_output', normalCompNodeBlend, 'source')
            normalCompNodeUniform.newPropertyConnectionFromId('unique_filter_output', normalCompNodeBlend, 'destination')
            normalCompNodeBlend.newPropertyConnectionFromId('unique_filter_output', normalCompNodeOutput, 'inputNodeOutput')




            # =========================================================================
            # ROUGHNESS

            #   - Instantiate the bitmap resource to the graph to have a node that will refers the created bitmap resource
            roughnessCompNodeBitmap = sdSBSCompGraph.newInstanceNode(roughnessSDResourceBitmap)
            roughnessCompNodeBitmap.setPosition(float2(-2*cGridSize, 8*cGridSize))
            roughnessCompNodeBitmap.setInputPropertyInheritanceMethodFromId('$format', SDPropertyInheritanceMethod.Absolute)
            roughnessCompNodeBitmap.setInputPropertyValueFromId('$format', SDValueEnum.sFromValueId('sbs::compositing::format', '8_bits_per_channel'))
            roughnessCompNodeBitmap.setInputPropertyValueFromId('colorswitch', SDValueBool.sNew(False))


            # =========================================================================
            # Create a gradient node
            roughnessCompNodeGradient = sdSBSCompGraph.newNode('sbs::compositing::gradient')
            roughnessCompNodeGradient.setPosition(float2(0, 8*cGridSize))
            roughnessCompNodeGradient.setInputPropertyValueFromId('colorswitch', SDValueBool.sNew(False))

            sdTypeStructGradientKeyRGBAStructType = SDTypeStruct.sNew('sbs::compositing::gradient_key_rgba')

            # Create key 0 to START
            roughnessStructKey0 = SDValueStruct.sNew(sdTypeStructGradientKeyRGBAStructType)
            roughness0ValueColorRGBA = SDValueColorRGBA.sNew(ColorRGBA(defaultRoughness0[0],defaultRoughness0[1],defaultRoughness0[2],defaultRoughness0[3]))
            roughnessStructKey0.setPropertyValueFromId('value', roughness0ValueColorRGBA)
            roughnessStructKey0.setPropertyValueFromId('position', SDValueFloat.sNew(0))
            roughnessStructKey0.setPropertyValueFromId('midpoint', SDValueFloat.sNew(0.5))

            # Create key 1 to END
            roughnessStructKey1 = SDValueStruct.sNew(sdTypeStructGradientKeyRGBAStructType)
            roughness1ValueColorRGBA = SDValueColorRGBA.sNew(ColorRGBA(defaultRoughness1[0],defaultRoughness1[1],defaultRoughness1[2],defaultRoughness1[3]))
            roughnessStructKey1.setPropertyValueFromId('value', roughness1ValueColorRGBA)
            roughnessStructKey1.setPropertyValueFromId('position', SDValueFloat.sNew(1))
            roughnessStructKey1.setPropertyValueFromId('midpoint', SDValueFloat.sNew(0.5))

            # Create array of keys
            roughnessKeyValueArray = SDValueArray.sNew(sdTypeStructGradientKeyRGBAStructType, 0)
            roughnessKeyValueArray.pushBack(roughnessStructKey0)
            roughnessKeyValueArray.pushBack(roughnessStructKey1)

            # Set the key array to the node property
            roughnessCompNodeGradient.setInputPropertyValueFromId('gradientrgba', roughnessKeyValueArray)


            # =========================================================================
            # Create an output Node
            roughnessCompNodeOutput = sdSBSCompGraph.newNode('sbs::compositing::output')
            roughnessCompNodeOutput.setPosition(float2(2*cGridSize, 8*cGridSize))
            roughnesssdValueString = SDValueString.sNew("roughness")
            roughnessCompNodeOutput.setAnnotationPropertyValueFromId('identifier', roughnesssdValueString)

            sdValueArray = SDValueArray.sNew(SDTypeUsage.sNew(), 0)
            sdValueUsage = SDValueUsage.sNew(SDUsage.sNew('roughness', 'RGBA', 'Linear'))
            sdValueArray.pushBack(sdValueUsage)

            roughnessCompNodeOutput.setAnnotationPropertyValueFromId('usages', sdValueArray)

            # =========================================================================
            # Create connections
            roughnessCompNodeBitmap.newPropertyConnectionFromId('unique_filter_output', roughnessCompNodeGradient, 'input1')
            roughnessCompNodeGradient.newPropertyConnectionFromId('unique_filter_output', roughnessCompNodeOutput, 'inputNodeOutput')




            # =========================================================================
            # METALNESS

            #   - Instantiate the bitmap resource to the graph to have a node that will refers the created bitmap resource
            metalnessCompNodeBitmap = sdSBSCompGraph.newInstanceNode(metalnessSDResourceBitmap)
            metalnessCompNodeBitmap.setPosition(float2(-2*cGridSize, 12*cGridSize))
            metalnessCompNodeBitmap.setInputPropertyInheritanceMethodFromId('$format', SDPropertyInheritanceMethod.Absolute)
            metalnessCompNodeBitmap.setInputPropertyValueFromId('$format', SDValueEnum.sFromValueId('sbs::compositing::format', '8_bits_per_channel'))
            metalnessCompNodeBitmap.setInputPropertyValueFromId('colorswitch', SDValueBool.sNew(False))


            # =========================================================================
            # Create a gradient node
            metalnessCompNodeGradient = sdSBSCompGraph.newNode('sbs::compositing::gradient')
            metalnessCompNodeGradient.setPosition(float2(0, 12*cGridSize))
            metalnessCompNodeGradient.setInputPropertyValueFromId('colorswitch', SDValueBool.sNew(False))

            sdTypeStructGradientKeyRGBAStructType = SDTypeStruct.sNew('sbs::compositing::gradient_key_rgba')

            # Create key 0 to START
            metalnessStructKey0 = SDValueStruct.sNew(sdTypeStructGradientKeyRGBAStructType)
            metalness0ValueColorRGBA = SDValueColorRGBA.sNew(ColorRGBA(defaultMetalness0[0],defaultMetalness0[1],defaultMetalness0[2],defaultMetalness0[3]))
            metalnessStructKey0.setPropertyValueFromId('value', metalness0ValueColorRGBA)
            metalnessStructKey0.setPropertyValueFromId('position', SDValueFloat.sNew(0))
            metalnessStructKey0.setPropertyValueFromId('midpoint', SDValueFloat.sNew(0.5))

            # Create key 1 to END
            metalnessStructKey1 = SDValueStruct.sNew(sdTypeStructGradientKeyRGBAStructType)
            metalness1ValueColorRGBA = SDValueColorRGBA.sNew(ColorRGBA(defaultMetalness1[0],defaultMetalness1[1],defaultMetalness1[2],defaultMetalness1[3]))
            metalnessStructKey1.setPropertyValueFromId('value', metalness1ValueColorRGBA)
            metalnessStructKey1.setPropertyValueFromId('position', SDValueFloat.sNew(1))
            metalnessStructKey1.setPropertyValueFromId('midpoint', SDValueFloat.sNew(0.5))

            # Create array of keys
            metalnessKeyValueArray = SDValueArray.sNew(sdTypeStructGradientKeyRGBAStructType, 0)
            metalnessKeyValueArray.pushBack(metalnessStructKey0)
            metalnessKeyValueArray.pushBack(metalnessStructKey1)

            # Set the key array to the node property
            metalnessCompNodeGradient.setInputPropertyValueFromId('gradientrgba', metalnessKeyValueArray)


            # =========================================================================
            # Create an output Node
            metalnessCompNodeOutput = sdSBSCompGraph.newNode('sbs::compositing::output')
            metalnessCompNodeOutput.setPosition(float2(2*cGridSize, 12*cGridSize))
            metalnesssdValueString = SDValueString.sNew("metallic")
            metalnessCompNodeOutput.setAnnotationPropertyValueFromId('identifier', metalnesssdValueString)

            sdValueArray = SDValueArray.sNew(SDTypeUsage.sNew(), 0)
            sdValueUsage = SDValueUsage.sNew(SDUsage.sNew('metallic', 'RGBA', 'Linear'))
            sdValueArray.pushBack(sdValueUsage)

            metalnessCompNodeOutput.setAnnotationPropertyValueFromId('usages', sdValueArray)

            # =========================================================================
            # Create connections
            metalnessCompNodeBitmap.newPropertyConnectionFromId('unique_filter_output', metalnessCompNodeGradient, 'input1')
            metalnessCompNodeGradient.newPropertyConnectionFromId('unique_filter_output', metalnessCompNodeOutput, 'inputNodeOutput')



            # Removed mask element for now - may be related to slow-downs and is not necessary for traditional or dynamic-layering workflow.
            # =========================================================================
            # MASK

            # Create a uniform color node
            #maskCompNodeUniform = sdSBSCompGraph.newNode('sbs::compositing::uniform')
            #maskCompNodeUniform.setPosition(float2(-2*cGridSize, 16*cGridSize))
            #maskCompNodeUniform.setInputPropertyInheritanceMethodFromId('$format', SDPropertyInheritanceMethod.Absolute)
            #maskCompNodeUniform.setInputPropertyValueFromId('$format', SDValueEnum.sFromValueId('sbs::compositing::format', '8_bits_per_channel'))
            #maskValueColorRGBA = SDValueColorRGBA.sNew(ColorRGBA(0.0, 0.0, 0.0, 1.0))
            #maskCompNodeUniform.setInputPropertyValueFromId('outputcolor', maskValueColorRGBA)

            # =========================================================================
            # Create an output Node
            #maskCompNodeOutput = sdSBSCompGraph.newNode('sbs::compositing::output')
            #maskCompNodeOutput.setPosition(float2(2*cGridSize, 16*cGridSize))
            #masksdValueString = SDValueString.sNew("mask")
            #maskCompNodeOutput.setAnnotationPropertyValueFromId('identifier', masksdValueString)

            #sdValueArray = SDValueArray.sNew(SDTypeUsage.sNew(), 0)
            #sdValueUsage = SDValueUsage.sNew(SDUsage.sNew('mask', 'RGBA', 'Linear'))
            #sdValueArray.pushBack(sdValueUsage)

            #maskCompNodeOutput.setAnnotationPropertyValueFromId('usages', sdValueArray)

            # =========================================================================
            # Create connections
            #maskCompNodeUniform.newPropertyConnectionFromId('unique_filter_output', maskCompNodeOutput, 'inputNodeOutput')

            # Print success message for each mltemplate (useful for debugging when code is not reached)
            print("Success")

        except:
            print('An exception occurred. File was skipped…')

    # =========================================================================
    # Save the new package on disk
    dstFileAbsPath = os.path.join(io.getUserDocumentOutputDir(__file__), sbsPackageName + '.sbs')
    sdPackageMgr.savePackageAs(sdPackage, dstFileAbsPath)
    print('Save output file to ' + dstFileAbsPath)


if __name__ == '__main__':
    main(sd.getContext())
