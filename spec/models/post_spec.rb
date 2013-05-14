require 'spec_helper'

describe Post do
  let(:title) { "a title" }
  let(:content) { "some content" }
  let(:post) { Post.create(title:title, content:content) }
  it "title should be automatically titleized before save" do
    post.title.should eq("A Title")
  end

  it "post should be unpublished by default" do
    post.is_published.should be false
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

