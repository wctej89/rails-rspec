require 'spec_helper'

describe 'User' do
  context "on homepage" do
    let!(:post) { Post.create(title:"Roar", content:"rarah") }
    it "sees a list of recent posts titles" do
      visit root_path
      page.should have_content "Roar"
    end
    it "can not see bodies of the recent posts" do
      visit root_path
      page.should_not have_content "rarah"
    end
    it "can click on titles of recent posts and should be on the post show page" do
      visit root_path
      click_link('Roar')
      page.should have_content "rarah"      
    end
    it "can not see the edit link" do
      visit root_path
      page.should_not have_link "Edit"
    end
    it "can not see the delete link" do
      visit root_path
      page.should_not have_link "Edit"
    end
  end

  context "post show page" do
    it "sees title and body of the post" do
      pending
      # given a user and post(s)
      # user visits the post show page
      # user should see the post title
      # user should see the post body
    end
    it "can not see the edit link" do
      pending
      # given a user and post(s)
      # user visits the post show page
      # user should not see the post edit link
    end
    it "can not see the published flag" do
      pending
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
