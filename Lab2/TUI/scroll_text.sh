#!/bin/bash
cat > temp.txt << 'EOF'
This is a very long text that will demonstrate
the scrollable text box feature in whiptail.
You can scroll up and down through this content
using the arrow keys.

This is a very long text that will demonstrate
the scrollable text box feature in whiptail.
You can scroll up and down through this content
using the arrow keys.


This is a very long text that will demonstrate
the scrollable text box feature in whiptail.
You can scroll up and down through this content
using the arrow keys.
EOF

whiptail --textbox temp.txt 0 0 --scrolltext
rm temp.txt