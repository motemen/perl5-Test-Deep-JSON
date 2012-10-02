use inc::Module::Install;

name 'Test-Deep-JSON';
all_from 'lib/Test/Deep/JSON.pm';

tests 't/*.t';
author_tests 'xt';

requires 'Test::Deep';
requires 'JSON';

test_requires 'Test::More';
test_requires 'Test::Tester';

auto_set_repository;
auto_include_deps;

readme_markdown_from 'lib/Test/Deep/JSON.pm';

if ($Module::Install::AUTHOR) {
    require File::Copy;
    File::Copy::mv('README.mkdn', 'README.md');
}

WriteAll;
