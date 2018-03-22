# Get git url and tag from yaml entry
FUNCTION(GET_GIT_REPO_URL_AND_TAG_FROM_DETAILS REPO_DETAILS REPO_NAME GIT_URL GIT_TAG)
  FOREACH(DETAIL ${REPO_DETAILS})
    IF(NEXT_IS_GITHUB_USER)
      SET(${GIT_URL} "https://github.com/${DETAIL}/${REPO_NAME}.git" PARENT_SCOPE)
      SET(NEXT_IS_GITHUB_USER FALSE)
      SET(NEXT_IS_GIT_TAG TRUE)
      CONTINUE()
    ENDIF()
    IF(NEXT_IS_GIT_TAG)
      SET(${GIT_TAG} "${DETAIL}" PARENT_SCOPE)
      SET(NEXT_IS_GIT_TAG FALSE)
    ENDIF()
    # Check if current depenency entry opens details
    STRING(COMPARE EQUAL "${DETAIL}" "github" NEXT_IS_GITHUB_USER)
  ENDFOREACH()
ENDFUNCTION(GET_GIT_REPO_URL_AND_TAG_FROM_DETAILS)

# Find closest matching tart.yaml file
FUNCTION(FIND_PACKAGE_TART_YAML_FILEPATH SEARCH_DIR PACKAGE_NAME TART_YAML_FILEPATH)
  IF(EXISTS "${SEARCH_DIR}/${PACKAGE_NAME}/tart.yaml")
    SET(${TART_YAML_FILEPATH} "${SEARCH_DIR}/${PACKAGE_NAME}" PARENT_SCOPE)
  ELSE()
   TART_ERROR("Package ${PACKAGE_NAME} in ${SEARCH_DIR} has no tart.yaml file! aborting")
  ENDIF()

ENDFUNCTION(FIND_PACKAGE_TART_YAML_FILEPATH)
