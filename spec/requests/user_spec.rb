require 'spec_helper'

describe 'User' do
  let!(:post) { Post.create(title:"Roar", content:"rarah") }
  context "on homepage" do
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
      page.should_not have_link "Delete"
    end
  end

  context "post show page" do
    it "sees title and body of the post" do
      visit root_path
      click_link('Roar')
      page.should have_content "Roar"
      page.should have_content "rarah"  
    end
    it "can not see the edit link" do
      visit root_path
      click_link('Roar')
      page.should_not have_content "Edit"
    end
    it "can not see the published flag" do
      visit root_path
      click_link('Roar')
      page.should_not have_content "Published"
    end
    it "can not see the Admin homepage link" do
      visit root_path
      click_link('Roar')
      page.should_not have_link "Admin"
    end
  end
end
