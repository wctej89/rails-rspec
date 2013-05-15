require 'spec_helper'

describe Post do

  let(:post) { Post.new(title: 'hello world', content: "foobar") }

  it "title should be automatically titleized before save" do
    post.save
    post.title.should eq 'Hello World'
  end

  it "post should be unpublished by default" do
    post.is_published.should eq(false)
  end

  it "slug should be automatically generated" do
    post = Post.new
    post.title   = "New post!"
    post.content = "A great story"
    post.slug.should be_nil
    post.save

    post.slug.should eq "new-post"
  end
end
