# ABAP unit tests by example

The intent of this repository is to collect different examples of ABAP unit tests.

Feel free to add you examples here.

Be sure that the complete code is shared and no company specific artefacts are used.

## Combinations

there is an object that can have three different levels of visibility:
 - display -> VISIBLE_ALWAYS
 - display only in overview -> VISIBLE_OVERVIEW
 - hide -> VISIBLE_NEVER

there is customizing that defines the "view level" for a general view and for a specific view this function returns the option that needs to be used for displaying the object.

_example 1:_
if the general option allows "display in overview" but the specific setting is "hidden" then the specific option overrules the general option because specific allows "less" and therfore returns the specific option.

_example 2:_
if the general option allows "overview" but the specific setting is "always" then the specific option cannot overrule the general option because it would grant more visibility what is not allowed and therfore returns the general option
