#!/bin/bash
# Strip extended attributes from Flutter framework before codesigning

if [ -f "${BUILT_PRODUCTS_DIR}/Flutter.framework/Flutter" ]; then
    echo "Stripping extended attributes from Flutter.framework..."
    xattr -cr "${BUILT_PRODUCTS_DIR}/Flutter.framework" 2>/dev/null || true
fi
