#!/bin/bash
set -e

fvm flutter packages pub run build_runner build --delete-conflicting-outputs
#flutter pub global run intl_utils:generate

echo "Build Data Done !!!"