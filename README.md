# PAWS-Decomp

Decompilation of the 2023 mobile game Super Cat Tales: PAWS. This is the Android version 1.0.59 because that's what i have. For now, the app icons are missing and for whatever reason, sprites scale using bilinear filtering, which looks blurry.

## Building

#### Prerequisites

You will need the following software to be installed:

- [Visual Studio Code](https://code.visualstudio.com/). You can use other IDEs or even compile it from the command line, but these instructions are for VS Code.
- [The ActionScript and MXML extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=bowlerhatllc.vscode-as3mxml). Once again, you can use other extensions or compile it from the command line, but these instructions are for the ActionScript and MXML extension.
- [The Adobe Air SDK](https://airsdk.harman.com/).

#### Compiling

1. Set the AIR_HOME environment variable to the path of your AIR sdk.
1. Open the directory of the decomp in Visual Studio.
1. Go to the **Terminal** menu and select **Run Build Task...**. Alternatively, use the Ctrl+Shift+B keyboard shortcut (or Command+Shift+B on macOS).
1. Select one of the options and let it compile! If it complains about a certificate, open up the asconfig.json file in a text editor. You'll find how to fix it in there.