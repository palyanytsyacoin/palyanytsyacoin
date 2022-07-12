#!/bin/bash
# create multiresolution windows icon
ICON_DST=../../src/qt/res/icons/PalyanytsyaCoin.ico

convert ../../src/qt/res/icons/PalyanytsyaCoin-16.png ../../src/qt/res/icons/PalyanytsyaCoin-32.png ../../src/qt/res/icons/PalyanytsyaCoin-48.png ${ICON_DST}
