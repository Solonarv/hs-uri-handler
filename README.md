# hs-uri-handler

A simple library that abstracts over the various platform-specific
ways to register an URI handler.

Includes a small utility executable which can be called by other programs
to register a handler. This is mainly useful to ease privilege handling.

Currently, the only supported OS is Windows. The library has been tested
on Windows 8.1, but should work on all versions since XP. I do not have
access to any other OSes currently, so I am unable to implement support for
them. Feel free to PR an implementation.hs-uri-handler: A platform-agnostic way to register URI handlers.

Output from `register-uri-handler --help`:

    Usage: register-uri-handler EXE [ARGS] (-n|-s|--name|--scheme SCHEME)
                                [-d|--desc DESCRIPTION] [--icon ICON]
                                [--icon-index ARG]
    Register EXE as a URI handler for SCHEME

    Available options:
    EXE                      The executable to invoke.
    ARGS                     Additional arguments that will be passed to EXE.
    -n,-s,--name,--scheme SCHEME
                            The URI scheme to register a handler for.
    -d,--desc DESCRIPTION    A short description for the URI handler.
    --icon ICON              Path to a file containing an icon to associate with
                            this handler.
    --icon-index ARG         Index of the icon within ICON.
    -h,--help                Show this help text
