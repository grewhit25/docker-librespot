#!/bin/bash

source ./buildx_ci_images.sh
#set -ex; setup_ci_environment::main; set +x
set -ex; build_ci_images::main; set +x
