use inc::Module::Install;

name           'Attempt';
all_from       'lib/Attempt.pm';

# T::B::T before 0.09 breaks with modern perls
build_requires 'Test::More' => 0;
build_requires 'Test::Exception' => 0;

license 'perl';
githubmeta;
author_tests('xt');

WriteAll;
