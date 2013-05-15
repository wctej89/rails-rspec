require 'spec_helper'
require 'capybara/rails'

describe 'Admin' do
  context "on admin homepage" do
    it "can see a list of recent posts" do
      page.driver.browser.basic_authorize("geek","jock")
      visit admin_posts_path
      page.should have_content('Welcome to the admin panel!')
      page.should have_content('New Post')
    end

    it "can edit a post by clicking the edit link next to a post" do
      post = Post.create(title: 'Post', content: "More stuff and content")
      visit edit_admin_post_path(post.id)
      click_button "Save"
      page.should have_content(post.title)
    end


    it "can delete a post by clicking the delete link next to a post" do
      page.driver.browser.basic_authorize("geek","jock")
      post = Post.create(title: 'Post', content: "More stuff and content")
      visit admin_posts_path
      first(:button, 'Delete').click
      page.should have_content(post.title)
    end

    it "can create a new post and view it" do
     visit new_admin_post_url

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
      post = Post.create(title: 'Post', content: "More stuff and content")
      visit edit_admin_post_path(post.id)
      page.uncheck('post_is_published')
      click_button "Save"
      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    it "can visit a post show page by clicking the title" do
      page.driver.browser.basic_authorize("geek","jock")
      post = Post.create(title: 'Banana', content: "More stuff and content")
      visit admin_posts_path
      click_link(post.title)
      page.should have_content(post.content)
    end

    it "can see an edit link that takes you to the edit post path" do
      
    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do
    end
  end
end
