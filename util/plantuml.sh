#!/bin/bash
UML=model.uml
TYPE='PNG'
MAINPATH='.'
DOCLETPATH=$MAINPATH/doclet
PUMLPATH=$MAINPATH/util

set -e

echo "Creating $UML... ===================

javadoc -encoding UTF-8   -private -quiet    -J-DdestinationFile=$UML -J-DcreatePackages=false -J-DshowPublicMethods=true -J-DshowPublicConstructors=false -J-DshowPublicFields=true -doclet de.mallox.doclet.PlantUMLDoclet -docletpath util/plantUmlDoclet.jar -sourcepath . $(find src/main -name *.java)

echo "Done creating plantUML model ==================
echo ""

cat $UML

echo ""
echo "Converting $UML to $TYPE... ====================

java -Djava.awt.headless=true -jar util/plantuml-1.2021.14.jar \
     -config $PUMLPATH/config.cfg \
     -o $(pwd) \
     -t $TYPE $UML
ret=$?

echo "Done generating PNG from model $ret"
