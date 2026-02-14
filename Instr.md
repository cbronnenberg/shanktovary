⭐ Recommended Tab Layout (Design View)
In App Designer, drag a Tab Group onto the right side of your app.
Inside it, create these tabs:

1. TimeHistoriesTab
Add one UIAxes → rename to TimeAxes

This axes will host the 3‑subplot tiled layout (Accel / Vel / Disp)

2. FFTTab
Add one UIAxes → rename to FFTAxes

This axes will host the 3‑subplot FFT layout

3. SpectrogramTab
Add one UIAxes → rename to SpectrogramAxes

4. BandLimitedTab
Add one UIAxes → rename to BandAxes

This gives you four clean workspaces.

⭐ Controls Panel (Left Side)
Add these UI components in Design View and rename them exactly as shown:

Filter Controls
HPField (NumericEditField)

LPField

OrderField

Time‑History Toggles
ShowAccelCheckBox

ShowVelocityCheckBox

ShowDisplacementCheckBox

NormalizeCheckBox

FFT Toggles
FFTScaleDropDown (Items: Log, Linear)

Band‑Limited Controls
FilterBetweenIntegrationsCheckBox

BandPlotModeDropDown (Items: Offset, Overlay, Normalize)

A/B Comparison Controls
CompareFiltersCheckBox

StoreFilterAButton

StoreFilterBButton

Update Button
UpdateButton

This is everything the callbacks will reference.

 