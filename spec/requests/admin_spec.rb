require 'spec_helper'

describe 'Admin', :js => true do
  context "on admin homepage" do
    before(:each) do
      Post.create(:title => 'stuff', :content => 'stuff2')
    end

    def basic_authorize
      page.driver.browser.basic_authorize('geek','jock')
    end

    it "can see a list of recent posts" do
      visit admin_posts_path
      # page.driver.visit("http://geek:jock@localhost:3000/admin/posts")
      # basic_authorize
      page.should have_content('admin')
    end

    it "can edit a post by clicking the edit link next to a post"do
      visit admin_posts_path
      first('tr').click_link "Edit"
      expect {
        fill_in 'post_title',   :with => "Hello world!"
        fill_in 'post_content', :with => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
        page.check('post_is_published')
        click_button "Save"
      }.to change(Post, :count).by(0)
    end

    it "can delete a post by clicking the delete link next to a post" do
      visit admin_posts_path
      first('tr').click_link "Delete"
    end

    it "can create a new post and view it" do
       visit new_admin_post_path
       expect {
         fill_in 'post_title',   :with => "Hello world!"
         fill_in 'post_content', :with => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
       }.to change(Post, :count).by(1)

       page.should have_content "Published: true"
       page.should have_content "Post was successfully saved."
     end
  end

  context "editing post" do
    it "can mark an existing post as unpublished" do
      visit admin_posts_path
      first('tr').click_link "Edit"
      page.uncheck('post_is_published')
      click_button "Save"
      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    before :each do
      visit admin_posts_path
      all('a').select{|e| e.text == "Hello World!"}.first.click
    end

    it "can visit a post show page by clicking the title" do
      page.should have_content('Hello World')
    end
    it "can see an edit link that takes you to the edit post path" do
      click_link 'Edit post'
      page.should have_field('post_title')
    end
    it "can go to the admin homepage by clicking the Admin welcome page link" do
      click_link 'Admin welcome page'
      page.should have_content('admin panel')
    end
  end
end
