project('com.github.aleksandar-stefanovic.urmsimulator', 'vala', 'c', version: '1.3.2')

gnome = import('gnome')
i18n = import('i18n')

add_project_arguments(
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language: 'c'
)

executable(
    meson.project_name(),
    'src/Application.vala',
    'src/Instruction.vala',
    'src/Parser.vala',
    'src/Processor.vala',
    'src/widget/URMSourceView.vala',
    'src/widget/LabeledSwitchBox.vala',
    dependencies: [
        dependency('gee-0.8'),
        dependency('gtk+-3.0'),
        dependency('gtksourceview-3.0')
    ],
    install: true
)

subdir('data')
subdir('po')
