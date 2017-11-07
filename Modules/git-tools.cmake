
# Get the latest abbreviated commit hash of the working branch
FUNCTION(GET_CURRENT_GITBRANCH GIT_REPO_DIR GIT_BRANCH_NAME)
  EXECUTE_PROCESS(
    COMMAND git rev-parse --abbrev-ref HEAD
    WORKING_DIRECTORY ${GIT_REPO_DIR}
    OUTPUT_VARIABLE GIT_BRANCH
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  SET(${GIT_BRANCH_NAME} "${GIT_BRANCH}" PARENT_SCOPE)
ENDFUNCTION(GET_CURRENT_GITBRANCH)

# Get latest git tag of current branch
FUNCTION(GET_LAST_GIT_TAG GIT_REPO_DIR GIT_TAG)
  EXECUTE_PROCESS(
    COMMAND git describe --tags
    WORKING_DIRECTORY ${GIT_REPO_DIR}
    OUTPUT_VARIABLE LAST_TAG
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  IF("${LAST_TAG}" EQUAL "fatal: No names found, cannot describe anything.")
    SET(LAST_TAG "")
  ENDIF()
  TART_DEBUG("Current git tag is ${LAST_TAG} of repo ${GIT_REPO_DIR}")
  SET(${GIT_TAG} "${LAST_TAG}" PARENT_SCOPE)
ENDFUNCTION(GET_LAST_GIT_TAG)

# Get the current working branch
FUNCTION(GET_CURRENT_GIT_COMMIT_ABBREVIATED_HASH GIT_REPO_DIR COMMIT_HASH)
  EXECUTE_PROCESS(
    COMMAND git log -1 --format=%h --quiet
    WORKING_DIRECTORY ${GIT_REPO_DIR}
    OUTPUT_VARIABLE GIT_COMMIT_HASH
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  TART_DEBUG("Current git hash is ${GIT_COMMIT_HASH}")
  SET(${COMMIT_HASH} "${GIT_COMMIT_HASH}" PARENT_SCOPE)
ENDFUNCTION(GET_CURRENT_GIT_COMMIT_ABBREVIATED_HASH)

# Clone git repo
FUNCTION(GIT_CLONE_REPO GIT_REPO_URL DESTINATION_DIR)
  TART_WARNING("Cloning ${GIT_REPO_URL} \n  into ${DESTINATION_DIR}.\nMake sure to ignore this repo if under VCS.")
  EXECUTE_PROCESS(
    COMMAND git clone ${GIT_REPO_URL} --quiet
    WORKING_DIRECTORY ${DESTINATION_DIR}
  )
ENDFUNCTION(GIT_CLONE_REPO)

# Checkout git hash/tag/branch
FUNCTION(GIT_CHECKOUT GIT_REPO_DIR DESIRED_CHECKOUT)
  TART_DEBUG("Checking out ${DESIRED_CHECKOUT}\nof Repo ${GIT_REPO_DIR}")
  EXECUTE_PROCESS(
    COMMAND git checkout ${DESIRED_CHECKOUT} --quiet
    WORKING_DIRECTORY ${GIT_REPO_DIR}
  )
ENDFUNCTION(GIT_CHECKOUT)

# pull git
FUNCTION(GIT_PULL GIT_REPO_DIR)
  EXECUTE_PROCESS(
    COMMAND git checkout master --quiet
    WORKING_DIRECTORY ${GIT_REPO_DIR}
  )
  EXECUTE_PROCESS(
    COMMAND git pull --quiet
    WORKING_DIRECTORY ${GIT_REPO_DIR}
  )
  TART_DEBUG("Pulling master from ${GIT_REPO_DIR}")
ENDFUNCTION(GIT_PULL)

# Try to checkout desired git tag
FUNCTION(GIT_TRY_CHECKOUT_TAG GIT_REPO_DIR GIT_TAG)
  GET_LAST_GIT_TAG(${GIT_REPO_DIR} CURRENT_GIT_TAG)
  STRING(COMPARE EQUAL "${GIT_TAG}" "${CURRENT_GIT_TAG}" IS_AT_CURRENT_TAG)
  IF (${IS_AT_CURRENT_TAG})
    RETURN()
  ELSE()
    GIT_PULL(${GIT_REPO_DIR})
    GIT_CHECKOUT(${WS_GIT_REPO_DIR} ${GIT_TAG})
  ENDIF()
  # TODO(nidegen) handle error if git command fails
ENDFUNCTION(GIT_TRY_CHECKOUT_TAG)

# Check if directory is clone of git url
FUNCTION(CHECK_IS_DIR_GIT_REPO GIT_REPO_DIR DESIRED_GIT_REPO_URL DIR_IS_GIT_REPO)
  TART_DEBUG("Checking if ${GIT_REPO_DIR} is a clone of ${DESIRED_GIT_REPO_URL}")
  SET(${DIR_IS_GIT_REPO} FALSE PARENT_SCOPE)
  IF(EXISTS ${GIT_REPO_DIR})
    EXECUTE_PROCESS(
      COMMAND git config --get remote.origin.url
      WORKING_DIRECTORY ${GIT_REPO_DIR}
      OUTPUT_VARIABLE CURRENT_GIT_REMOTE_URL
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    STRING(COMPARE EQUAL "${DESIRED_GIT_REPO_URL}" "${CURRENT_GIT_REMOTE_URL}" HAS_DESIRED_REMOTE_URL)
    TART_DEBUG("Repo has desired remote url: ${HAS_DESIRED_REMOTE_URL}")
    SET(${DIR_IS_GIT_REPO} ${HAS_DESIRED_REMOTE_URL} PARENT_SCOPE)
  ELSE()
    TART_DEBUG(SEND_ERROR "Directory does not exist for checked git repository")
  ENDIF()
ENDFUNCTION(CHECK_IS_DIR_GIT_REPO)

# Get the current working branch
FUNCTION(CHECK_IF_GIT_URL GIT_URL IS_GIT_URL)
  # Find variable name
  # TODO(nidegen) make use of regex instead of `git ls-remote the-url-to-test`
  # SET(RXP "?:git|ssh|https?|git@[-\\w.]+):(\\/\\/)?(.*?)(\\.git)(\\/?|\\#[-\\d\\w._]+?)$")
  # SET(RXP "((git|ssh|http(s)?)|(git\@[\\w\\.]+))(:(\/\/)?)([\\w\\.@\\:\/\\-\~]+)(\\.git)(\/)?")
  # MESSAGE("${RXP}")
  
  # EXECUTE_PROCESS(
  #   COMMAND git ls-remote ${GIT_URL}
  #   OUTPUT_VARIABLE IS_GIT_URL
  #   OUTPUT_STRIP_TRAILING_WHITESPACE
  # )
  # STRING(REGEX MATCH "${RXP}" MATCHED_URL ${GIT_URL})
  # MESSAGE(${MATCHED_URL})
  TART_DEBUG("GIT URL CHECKER NOT WORKING YET")
  # STRING(COMPARE EQUAL "${MATCHED_URL}" "${GIT_URL}" IS_GIT_URL)
  SET(${IS_GIT_URL} "FALSE" PARENT_SCOPE)
ENDFUNCTION(CHECK_IF_GIT_URL)
