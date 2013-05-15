require 'spec_helper'

describe Post do
  describe "saving a post" do
    let(:post) {
      Post.create!(:title => "new post!", :content => "A great story")}

    it "title should be automatically titleized" do
      post.title.should == "New Post!"
    end

    it "post should be unpublished by default" do
      post.is_published.should eq false
    end

    it "slug should be automatically generated" do
      post.slug.should eq "new-post"
    end
  end
end
