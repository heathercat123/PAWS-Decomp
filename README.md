# PAWS-Decomp

Decompilation of the 2023 mobile game Super Cat Tales: PAWS. This is the Android version 1.0.59 because that's what i have.

Only issue is, some Air Native Extensions (ANEs) made by distriqt used in the game are paid. My (stupid) solution was to just... decompile them too and it... worked. For better accuracy, it would be appreciated if someone gave them to me. This may sound illegal, but in reality you need a key that isn't in the actual ANEs to use them. Neutronized's is somewhere in the decomp.

## Building

#### Prerequisites

You will need the following software to be installed:

- [Visual Studio Code](https://code.visualstudio.com/). You can use other IDEs or even compile it from the command line, but these instructions are for VS Code.
- [The ActionScript and MXML extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=bowlerhatllc.vscode-as3mxml). Once again, you can use other extensions or compile it from the command line, but these instructions are for the ActionScript and MXML extension.
- [The Adobe Air SDK](https://airsdk.harman.com/).

#### Compiling
NOTE: These instrucions are made for VSCode ONLY. To compile from the command line, [install asconfigc](https://github.com/BowlerHatLLC/asconfigc?tab=readme-ov-file#installation) refer to [this](https://github.com/BowlerHatLLC/asconfigc?tab=readme-ov-file#command-line-usage). 
1. Set the AIR_HOME environment variable to the path of your AIR sdk.
1. Open the directory of the decomp in Visual Studio.
1. Go to the **Terminal** menu and select **Run Build Task...**. Alternatively, use the Ctrl+Shift+B keyboard shortcut (or Command+Shift+B on macOS).
1. Select one of the options and let it compile! If it complains about a certificate, read this and set asconfig.json accordingly: https://help.adobe.com/en_US/air/build/WS5b3ccc516d4fbf351e63e3d118666ade46-7f74.html