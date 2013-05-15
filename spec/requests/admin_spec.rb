require 'spec_helper'

describe 'Admin', :js => true do
  context "on admin homepage" do
    before(:all) do
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
      click_link "Edit"
      expect {
        fill_in "post_title",   :with => "Hello world!"
        fill_in "post_content", :with => "Lorem ipsum"
        page.check('post_is_published')
        click_button "Save"
      }.to change()
    end

    it "can delete a post by clicking the delete link next to a post" do
      pending
    end

    it "can create a new post and view it" do
       visit new_admin_post_url
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
      pending # remove this line when you're working on implementing this test

      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    it "can visit a post show page by clicking the title" do
      pending
    end
    it "can see an edit link that takes you to the edit post path" do
      pending
    end
    it "can go to the admin homepage by clicking the Admin welcome page link" do
      pending
    end
  end
end
