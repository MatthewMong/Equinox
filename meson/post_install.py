#!/usr/bin/env python3

import os
import subprocess

prefix = os.environ.get('MESON_INSTALL_PREFIX', '/usr')
datadir = os.path.join(prefix, 'share')

# Packaging tools define DESTDIR and this isn't needed for them
if 'DESTDIR' not in os.environ:

    print('Compiling gsettings schemas...')
    schema_dir = os.path.join(datadir, 'glib-2.0/schemas')
    subprocess.call(['glib-compile-schemas', schema_dir])

    print('Updating desktop database...')
    desktop_database_dir = os.path.join(datadir, 'applications')
    subprocess.call(['update-desktop-database', '-q', desktop_database_dir])
