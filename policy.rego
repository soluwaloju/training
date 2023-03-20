package org

import future.keywords

policy_name["example"]

use_official_docker_image[image] = reason {
  some image in docker_images   # docker_images are parsed below
  not startswith(image, "circleci")
  not startswith(image, "cimg")
  reason := sprintf("%s is not an approved Docker image", [image])
}

# helper to parse docker images from the config
docker_images := {image | walk(input, [path, value])  # walk the entire config tree
                          path[_] == "docker"         # find any settings that match 'docker'
                          image := value[_].image}    # grab the images from that section

hard_fail["use_official_docker_image"]

enable_rule["use_official_docker_image"]
