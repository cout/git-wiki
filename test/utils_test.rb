require 'wiki/extensions'
require 'wiki/utils'

describe 'wiki utility methods' do
  it 'blank?' do
    ''.should.be.blank
    {}.should.be.blank
    [].should.be.blank
    nil.should.be.blank
    'foo'.should.not.be.blank
    !{42=>'answer'}.should.not.be.blank
    [42].should.not.be.blank
    42.should.not.be.blank
  end

  it 'pluralize' do
    'test'.pluralize(0, 'tests').should.equal '0 tests'
    'test'.pluralize(1, 'tests').should.equal '1 test'
    'test'.pluralize(3, 'tests').should.equal '3 tests'
  end

  it 'begins_with?' do
    '123456789'.begins_with?('12').should.equal true
    '123456789'.begins_with?('23').should.not.equal true
  end

  it 'ends with?' do
    '123456789'.ends_with?('89').should.equal true
    '123456789'.ends_with?('98').should.not.equal true
  end

  it 'cleanpath' do
    '/'.cleanpath.should.equal ''
    '/a/b/c/../'.cleanpath.should.equal 'a/b'
    '/a/./b/../c/../d/./'.cleanpath.should.equal 'a/d'
    '1///2'.cleanpath.should.equal '1/2'
    'root'.cleanpath.should.equal ''
    '///root/1/../2'.cleanpath.should.equal '2'
  end

  it 'urlpath' do
    '/'.urlpath.should.equal '/root'
    '/a/b/c/../'.urlpath.should.equal '/a/b'
    '/a/./b/../c/../d/./'.urlpath.should.equal '/a/d'
    '1///2'.urlpath.should.equal '/1/2'
    'root'.urlpath.should.equal '/root'
    '///root/1/../2'.urlpath.should.equal '/2'
  end

  it 'truncate' do
    'Annabel Lee It was many and many a year ago'.truncate(11).should.equal 'Annabel Lee...'
    'In a kingdom by the sea'.truncate(39).should.equal 'In a kingdom by the sea'
  end

  it 'slash' do
    (''/'').should.equal ''
    ('//a/b///'/'').should.equal 'a/b'
    ('a'/'x'/'..'/'b'/'c'/'.').should.equal 'a/b/c'
  end

  it 'forbid' do
    lambda do
      Wiki.forbid('Forbidden' => true)
    end.should.raise Wiki::MultiError
    lambda do
      Wiki.forbid('Allowed' => false,
             'Forbidden' => true)
    end.should.raise Wiki::MultiError
  end
end
