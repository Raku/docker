# Rakudo Star

[![Build Status](https://travis-ci.org/perl6/docker.svg?branch=master)](https://travis-ci.org/perl6/docker)

This Docker image includes Rakudo Star, which is a Raku compiler distribution that includes MoarVM
virtual machine, Rakudo compiler, a suite of modules that users may find useful, and language documentation.

Project homepage: https://rakudo.org

GitHub repository: https://github.com/rakudo/star

The Dockerfile responsible: https://github.com/perl6/docker/tree/master/Dockerfile

Raku Language Specification: https://github.com/perl6/roast

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
    > say 'Hello, Perl!'
    Hello, Perl!

You can also provide raku command line switches to a temporary container:

    $ docker run --rm rakudo-star raku -e 'say "Hello!"'

In addition, you can run a script located in the current folder:

    $ docker run --rm -v "$(pwd):/script" rakudo-star raku /script/my_p6_script.raku

# Contributing/Getting Help

Many Raku developers are present on [#raku on Freenode](https://webchat.freenode.net/#raku)

Issues for Rakudo are tracked on https://github.com/rakudo/rakudo/issues
