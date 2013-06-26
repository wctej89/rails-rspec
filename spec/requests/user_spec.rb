require 'spec_helper'

describe 'User' do
  
  let!(:post) { FactoryGirl.create(:post) }

  # , js: true 

  context "on homepage" do
    before :each do
      visit root_path
    end

    it "sees a list of recent posts titles" do
      page.should have_content 'Recent Posts'
    end

    it "can not see bodies of the recent posts" do
      page.should_not have_content post.content
    end

    it "can click on titles of recent posts and should be on the post show page"do
      click_link post.title
      page.should have_content post.content
    end

    it "can not see the edit link" do
      page.should_not have_link "Edit"
    end

    it "can not see the delete link" do
      page.should_not have_link "Delete"
    end
  end

  context "post show page" do
    before :each do
      visit post_path(post)
    end

    it "sees title and body of the post" do
      page.should have_content post.title
      page.should have_content post.content
    end

    it "can not see the edit link" do
      page.should_not have_link "Edit post"
    end

    it "can not see the published flag" do
      page.should_not have_content "Published"
    end

    it "can not see the Admin homepage link" do
      page.should_not have_link "Admin welcome page"
    end
  end
end
