SETLOCAL

call %WORKSPACE%\opscode-ci-scripts\load-omnibus-toolchain.bat

set OMNIBUS_PROJECT_NAME=%1

IF "%CLEAN%"=="true" (
  rmdir /Q /S c:\opscode
  rmdir /Q /S c:\omnibus-ruby
  rmdir /Q /S .\pkg
)

call copy /Y omnibus.rb.example omnibus.rb || GOTO :error

call bundle install || GOTO :error

IF "%RELEASE_BUILD%"=="true" (
  call bundle exec omnibus build project %OMNIBUS_PROJECT_NAME%-windows --no-timestamp || GOTO :error
) ELSE (
  call bundle exec omnibus build project %OMNIBUS_PROJECT_NAME%-windows || GOTO :error
)

GOTO :EOF

:error
ECHO Failed with error level %errorlevel%

ENDLOCAL
