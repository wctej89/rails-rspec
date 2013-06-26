require 'spec_helper'

describe Post do
  
  let(:title) { "this is a title" }
  let(:content) { "This is the content of the post." }
  let(:post)  { Post.create(title: title, content: content) }

  it "title should be automatically titleized before save" do
    expect(post.title).to eq title.titleize
  end

  it "post should be unpublished by default" do
    expect(post.is_published).to eq false
  end

  # a slug is an automaticaly generated url-friendly
  # version of the title
  it "slug should be automatically generated" do
    post = Post.new
    post.title   = "New post"
    post.content = "A great story"
    post.slug.should be_nil
    post.save

    post.slug.should eq "new-post"
  end
end
