SET LOCATION_OF_XML_FILES="C:\dev\packages\MicroscopeSimulator2"
SET MSIM_EXE_LOCATION="C:\Program Files (x86)\CISMM\Microscope Simulator 2.1.1\bin\MicroscopeSimulator.exe"
FOR /R %LOCATION_OF_XML_FILES% %%i in (*.xml) DO (
ECHO %%i
%MSIM_EXE_LOCATION% "--batch-mode" "--open-simulation" "%%i" "--save-fluorescence-stack" "%%i.image.tif"
)
