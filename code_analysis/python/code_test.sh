#!/bin/bash
set -e

pip install nose2 coverage nosexcover pylint pytest pytest-cov 

sonar-scanner 