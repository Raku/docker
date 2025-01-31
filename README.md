# Rakudo Star

[![Docker Image CI](https://github.com/Raku/docker/actions/workflows/test-docker-image.yml/badge.svg?branch=master)](https://github.com/Raku/docker/actions/workflows/test-docker-image.yml)

This Docker image includes Rakudo Star, which is a Raku compiler distribution that includes MoarVM
virtual machine, Rakudo compiler, a suite of modules that users may find useful, and language documentation.

Project homepage: https://rakudo.org

GitHub repository: https://github.com/rakudo/star

Raku Language Specification: https://github.com/raku/roast

Raku Language Documentation: https://docs.raku.org/

# Build

You can build an image from this Dockerfile as indicated below:

    $ docker build -t rakudo-star /path_to_dockerfile/

In addition, you can specify the version of Rakudo Star that you want at build time:

    $ docker build --build-arg rakudo_version=${DESIRED_VERSION} -t rakudo-star /path_to_dockerfile/

If no version is specified, it will default to the version listed in the Dockerfile. It is recommended that
you use the default version.

# Usage

Running a short-term foreground process with the image will launch a Raku REPL:

    $ docker run --rm -it rakudo-star
    > say 'Hello, Raku!'
    Hello, Raku!

You can also provide raku command line switches to a temporary container:

    $ docker run --rm rakudo-star raku -e 'say "Hello!"'

In addition, you can run a script located in the current folder:

    $ docker run --rm -v "$(pwd):/script" rakudo-star raku /script/my_raku_script.raku

# Updating Docker Hub Image

`rakudo-star` is an Official Image on Docker Hub.
To update the `rakudo-star` image, make the necessary changes to
[library/rakudo-star](https://github.com/docker-library/official-images/blob/master/library/rakudo-star).

# Contributing/Getting Help

Many Raku developers are present on [#raku on Libera.Chat](https://kiwiirc.com/client/irc.libera.chat/#raku)

Issues for Rakudo are tracked on https://github.com/rakudo/rakudo/issues
