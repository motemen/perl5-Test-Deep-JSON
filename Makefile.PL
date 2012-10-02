use inc::Module::Install;

name 'Test-Deep-JSON';
all_from 'lib/Test/Deep/JSON.pm';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';

auto_set_repository;
auto_include_deps;

readme_from 'lib/Test/Deep/JSON.pm';

WriteAll;
