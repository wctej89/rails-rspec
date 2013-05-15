require 'spec_helper'

describe 'Admin' do

  let(:post_title) {"Post Title"}
  let(:post_content) {"Post Content"}
  let(:post) {Post.create(title: post_title, content: post_content, is_published: true)}

  context "on admin homepage" do
    it "can see a list of recent posts"  do
      post
      visit admin_posts_path
      # page.driver.browser.basic_authorize('geek', 'jock')
      page.should have_content(post_title)
    end

    it "can edit a post by clicking the edit link next to a post" do
      post
      visit admin_posts_path
      click_link "Edit"
    end

    it "can delete a post by clicking the delete link next to a post"
    it "can create a new post and view it" do
       visit new_admin_post_url

       page.driver.browser.basic_authorize('geek', 'jock')
       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
       }.to change(Post, :count).by(1)

       page.should have_content "Published: true"
       page.should have_content "Post was successfully saved."
     end
  end

  context "editing post" do
    it "can mark an existing post as unpublished" do
      pending
      
      post
      visit edit_admin_post_path(post)
      page.check('post_is_published')
   
      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    it "can visit a post show page by clicking the title"
    it "can see an edit link that takes you to the edit post path"
    it "can go to the admin homepage by clicking the Admin welcome page link"
  end
end
