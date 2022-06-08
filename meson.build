# project name and programming language
project('com.github.matthewmong.equinox', 'vala', 'c')

#dependencies
gnome = import('gnome')

# Create a new executable, list the files we want to compile, list the dependencies we need, and install
executable(
    meson.project_name(),
    'src/Equinox.vala',
    'src/MainWindow.vala',
    'src/Constants.vala',
    'src/Utils/Locate.vala',
    'src/Utils/Weather.vala',
    dependencies: [
        dependency('gtk+-3.0'),
        dependency('granite'),
        dependency('libsoup-2.4'),
        dependency('glib-2.0'),
        dependency('json-glib-1.0')
    ],
    install: true
)

gnome.compile_schemas(
    build_by_default: true,
    depend_files: join_paths('data', 'com.github.matthewmong.equinox.gschema.xml'),
)

install_data(
    join_paths('data', 'com.github.matthewmong.equinox.gschema.xml'),
    install_dir: join_paths(get_option('datadir'), 'glib-2.0', 'schemas'),
    rename: meson.project_name() + '.gschema.xml',)

# Install our .desktop file so the Applications Menu will see it
install_data(
    join_paths('data', 'com.github.matthewmong.equinox.desktop'),
    install_dir: join_paths(get_option('datadir'), 'applications'),
    rename: meson.project_name() + '.desktop'
)

# Install our .appdata.xml file so AppCenter will see it
install_data(
    join_paths('data', 'com.github.matthewmong.equinox.appdata.xml'),
    install_dir: join_paths(get_option('datadir'), 'metainfo'),
    rename: meson.project_name() + '.appdata.xml'
)

meson.add_install_script('meson/post_install.py')