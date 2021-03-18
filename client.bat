SET P=%~dp0%

SET P="%P:~0,-1%"

processing-java --sketch=%P% --force --run