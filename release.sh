#!/bin/bash
# Name: release.sh
# Description: Creates Rundeck plugin zip file for release

    # Commands
    CAT="/bin/cat"
    CP="/bin/cp"
    GREP="/bin/grep -Pio"
    MKDIR="/bin/mkdir"
    MKTEMP="/bin/mktemp"
    RM="/bin/rm"
    SED="/bin/sed"
    ZIP="/usr/bin/zip"

    # Read and store plugin.yaml
    CONTENT_DIR="contents"
    YAML_FILE="plugin.yaml"
    YAML_CONTENT="$( ${CAT} ${YAML_FILE} )"

    # Setup
    VERSION=$( ${GREP} '(?<=^version: )[0-9.]*' <<< "${YAML_CONTENT}" )
    PLUGIN=$( ${GREP} '(?<=^name: )[a-zA-Z0-9-]*' <<< "${YAML_CONTENT}" )
    RELEASE_DATE=$( date -u +%Y-%m-%dT%H:%M:%S%z )
    RELEASE_DIR=$( ${MKTEMP} -d )

    # Build release package
    PLUGIN_NAME="${PLUGIN}-${VERSION}-plugin"
    ${MKDIR} -p ${RELEASE_DIR}/${PLUGIN_NAME}
    ${SED} "s/RELEASE_DATE/${RELEASE_DATE}/" ${YAML_FILE} > ${RELEASE_DIR}/${PLUGIN_NAME}/${YAML_FILE}
    ${CP} -a ${CONTENT_DIR} ${RELEASE_DIR}/${PLUGIN_NAME}
    ${ZIP} -r ${PLUGIN_NAME}.zip ${RELEASE_DIR}/${PLUGIN_NAME}

    # Cleanup
    rm -rf ${RELEASE_DIR}
