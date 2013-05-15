require 'spec_helper'

describe 'User', :js => true do
  
  context "on homepage" do
  
    let!(:post){ Post.create!(title:"New Post!", content:"a great post") }

    it "sees a list of recent posts titles" do
      visit posts_path
      debugger
      page.should have_content(post.title)
      # given a user and a list of posts
      # user visits the homepage
      # user can see the posts titles
    end
    it "can not see bodies of the recent posts" do
      visit posts_path
      page.should_not have_content("a great post")
      # given a user and a list of posts
      # user visits the homepage
      # user should not see the posts bodies
    end
    it "can click on titles of recent posts and should be on the post show page" do
      visit posts_path
      click_link("New Post!")
      # given a user and a list of posts
      # user visits the homepage
      # when a user can clicks on a post title they should be on the post show page
    end
    it "can not see the edit link" do
      visit posts_path
      page.should_not have_link("Edit")
      # given a user and a list of posts
      # user visits the homepage
      # user should not see any edit links
    end
    it "can not see the delete link" do
      visit posts_path
      page.should_not have_link("Delete")
      # given a user and a list of posts
      # user visits the homepage
      # user should not see any delete links
    end
  end

  context "post show page" do

  let!(:post){ Post.create!(title:"New Post!", content:"a great post", is_published:true)}

    it "sees title and body of the post" do
      visit post_path(post)

      page.should have_content("New Post!")
      page.should have_content("a great post")
      # given a user and post(s)
      # user visits the post show page
      # user should see the post title
      # user should see the post body
    end
    it "can not see the edit link" do
      visit post_path(post)
      page.should_not have_link("Edit")
      # given a user and post(s)
      # user visits the post show page
      # user should not see the post edit link
    end
    it "can not see the published flag" do
      visit post_path(post)
      page.should_not have_content("true")
      # given a user and post(s)
      # user visits the post show page
      # user should not see the published flag content
    end
    it "can not see the Admin homepage link" do
      visit post_path(post)
      page.should_not have_link("Admin welcome page")
      # given a user and post(s)
      # user visits the post show page
      # user should not see the the admin homepage link
    end
  end
end
