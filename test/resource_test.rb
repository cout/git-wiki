require 'spec_setup'

describe 'Wiki::Resource' do
  before { create_repository }
  after { destroy_repository }

  it 'check for path validity' do
    lambda do
      Wiki::Resource.find(@repo, ' spaces ')
    end.should.raise Wiki::MultiError
    Wiki::Resource.find(@repo, 'spaces in the path').should.equal nil
  end

  it 'find root with correct type' do
    Wiki::Resource.find(@repo, '').should.be.an.instance_of Wiki::Tree
    Wiki::Tree.find(@repo, '').should.be.an.instance_of Wiki::Tree
    Wiki::Page.find(@repo, '').should.equal nil

    Wiki::Resource.find(@repo, '/').should.be.an.instance_of Wiki::Tree
    Wiki::Tree.find(@repo, '/').should.be.an.instance_of Wiki::Tree
    Wiki::Page.find(@repo, '/').should.equal nil

    Wiki::Resource.find(@repo, '/root').should.be.an.instance_of Wiki::Tree
    Wiki::Tree.find(@repo, '/root').should.be.an.instance_of Wiki::Tree
    Wiki::Page.find(@repo, '/root').should.equal nil

    Wiki::Resource.find(@repo, 'Home').should.be.an.instance_of Wiki::Page
    Wiki::Tree.find(@repo, 'Home').should.equal nil
    Wiki::Page.find(@repo, 'Home').should.be.an.instance_of Wiki::Page
  end

  it 'find or raise' do
    Wiki::Resource.find!(@repo, '').should.be.an.instance_of Wiki::Tree
    Wiki::Tree.find!(@repo, '').should.be.an.instance_of Wiki::Tree
    lambda do
      Wiki::Page.find!(@repo, '/root')
    end.should.raise Wiki::Resource::NotFound

    Wiki::Resource.find(@repo, 'Home').should.be.an.instance_of Wiki::Page
    Wiki::Page.find(@repo, 'Home').should.be.an.instance_of Wiki::Page
    lambda do
      Wiki::Tree.find!(@repo, '/Home')
    end.should.raise Wiki::Resource::NotFound

    lambda do
      Wiki::Resource.find!(@repo, '/foo')
    end.should.raise Wiki::Resource::NotFound

    lambda do
      Wiki::Page.find!(@repo, '/foo')
    end.should.raise Wiki::Resource::NotFound

    lambda do
      Wiki::Tree.find!(@repo, '/foo')
    end.should.raise Wiki::Resource::NotFound
  end

  it 'should.equal new' do
    Wiki::Page.find(@repo, 'Home').should.not.be.new
    Wiki::Tree.find(@repo, '').should.not.be.new
    Wiki::Page.new(@repo, 'new').should.be.new
    Wiki::Tree.new(@repo, 'new').should.be.new
  end

  it 'have type' do
    Wiki::Page.find(@repo, 'Home').should.be.page
    Wiki::Tree.find(@repo, '').should.be.tree
  end

  it 'have name' do
    Wiki::Resource.new(@repo, '/path/name.ext').name.should.equal 'name.ext'
  end

  it 'have title' do
    Wiki::Resource.new(@repo, '/path/name.ext').title.should.equal 'name'
  end

  it 'have path' do
    Wiki::Resource.new(@repo, '/path/name.ext').path.should.equal 'path/name.ext'
  end

  it 'have safe name' do
    Wiki::Resource.new(@repo, '0 1 2 3 4 5').safe_name.should.equal '0_1_2_3_4_5'
  end
end
