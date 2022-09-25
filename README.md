# Cyberpunk Substance Resources

Collection of resources for Substance to streamline Cyberpunk 2077 multilayered assets.

![substance resources example 3](https://user-images.githubusercontent.com/65016231/192145740-62aaf24c-c8c5-4096-9d98-5d4b9d0037ec.png)


## What's included?
**Substance Designer**
- Python script which automatically creates a Substance Designer Graph of each Cyberpunk material file.

**Substance Painter**
- All base game Cyberpunk 2077 mltemplates converted to Painter materials [(only in release version)](https://github.com/WolvenKit/Cyberpunk-Substance-Resources/releases)
- Painter export templates for batch exporting Cyberpunk-style masks
- Painter project template for setting up batch exports

![substance resources example 4](https://user-images.githubusercontent.com/65016231/192145774-747fc9d8-6240-4b26-bd58-be74eb17ec50.png)


-------------------

## Running the Substance Designer Python script

1) Download the source code for this repository, or the *Cyberpunk SD Script.py* directly.
2) Run Substance Designer and open the Python Editor window. (Windows/Python Editor)
3) From within the Python Editor window, open the downloaded *Cyberpunk SD Script.py* file.
4) Use the Python Editor to edit the user input section at the beginning of the Python file. The base path and image format must be set for the script to function correctly. The script looks for mltemplate files exported to JSON, and raw format textures (.png, .tga, etc.). This directory should be prepared by using WolvenKit 8.7+.
5) Press the *Run* button. (looks like play icon)


-------------------

## To-Do List

- Allow color swapping and other adjustments (some complications with Designer API and Painter Dynamic material shader)
- Implement some interoperability with WolvenKit by import or exporting mlsetup data with Painter

## Help

Looking for help using this project? [Reach out on the Cyberpunk 2077 Modding Discord.](https://discord.gg/Epkq79kd96)

Interested in contributing? Feel free to submit a pull request. Alternatively, reach out on Discord by using the server invitation link above.
