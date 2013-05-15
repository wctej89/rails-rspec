require 'spec_helper'

describe 'User' do
  let(:post_title) {"Post Title"}
  let(:post_content) {"Post Content"}
  let(:post) {Post.new(title: post_title, content: post_content, is_published: true)}
  
  context "on homepage" do
    it "sees a list of recent posts titles" do
      post.save
      visit root_url
      page.should have_content "Recent Posts:"
      page.should have_content post_title

      # page.should have_content
      # given a user and a list of posts
      # user visits the homepage
      # user can see the posts titles
    end
    it "can not see bodies of the recent posts" do
      visit root_url 
      page.should_not have_content "Recent Posts:"
      page.should_not have_content post_title

      # given a user and a list of posts
      # user visits the homepage
      # user should not see the posts bodies
    end
    it "can click on titles of recent posts and should be on the post show page" do
      post.save
      visit root_url
      click_link(post_title)
      current_url.should include(post_path(post))

      # given a user and a list of posts
      # user visits the homepage
      # when a user can clicks on a post title they should be on the post show page
    end
    it "can not see the edit link" do
      post.save
      visit root_url
      page.should_not have_link "Edit"

      # given a user and a list of posts
      # user visits the homepage
      # user should not see any edit links
    end
    it "can not see the delete link" do
      post.save
      visit root_url
      page.should_not have_link "Delete"

      # given a user and a list of posts
      # user visits the homepage
      # user should not see any delete links
    end
  end

  context "post show page" do
    it "sees title and body of the post" do
      post.save
      visit post_path(post)
      page.should have_content(post_title)
      page.should have_content(post_content)

      # given a user and post(s)
      # user visits the post show page
      # user should see the post title
      # user should see the post body
    end
    it "can not see the edit link" do
      post.save
      visit post_path(post)
      page.should_not have_link "Edit"

      # given a user and post(s)
      # user visits the post show page
      # user should not see the post edit link
    end
    it "can not see the published flag" do
      post.save
      visit post_path(post)
      page.should_not have_content "Publish?"

      # given a user and post(s)
      # user visits the post show page
      # user should not see the published flag content
    end
    it "can not see the Admin homepage link" do
      pending
      # given a user and post(s)
      # user visits the post show page
      # user should not see the the admin homepage link
    end
  end
end
