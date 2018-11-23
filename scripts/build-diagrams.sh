#!/bin/bash

PLANTUML=~/Downloads/plantuml.jar
java -jar $PLANTUML -v -tsvg resource/components.uml -o ../resource/
java -jar $PLANTUML -v -tsvg resource/sequence.uml -o ../resource/
