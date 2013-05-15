require 'spec_helper'

describe 'Admin'  do
      before (:each) do
      name = 'geek'
      password = 'jock'
      page.driver.browser.basic_authorize(name, password)
    end
  let!(:post) { Post.create(title:"Roar", content:"rarah") }
  context "on admin homepage" do

    it "can see a list of recent posts" do
      visit admin_posts_path
      page.should have_content 'Roar'
      page.should have_content 'Edit'
      page.should have_button 'Delete'
    end
    it "can edit a post by clicking the edit link next to a post" do
      visit admin_posts_path
      click_link('Edit')
      page.should have_content 'Edit Roar'
      page.should have_selector 'form'
      fill_in 'post_title', with: "roar changed to something else"
      page.check('post_is_published')
      click_button 'Save'
      page.should have_content "roar changed to something else".titleize
    end

    it "can delete a post by clicking the delete link next to a post" do
      visit admin_posts_path
      click_button('Delete')
      page.should_not have_content "roar changed to something else".titleize
    end

    it "can create a new post and view it" do
     visit new_admin_post_path
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
    let!(:post) { Post.create(title:"Roar", content:"rarah", is_published: true) }

    it "can mark an existing post as unpublished" do
      visit admin_posts_path
      click_link('Edit')
      uncheck('post_is_published')
      click_button 'Save'
      page.should have_content "Published: false"
    end
  end

  context "on post show page" do

    let!(:post) { Post.create(title:"Roar", content:"rarah", is_published: true) }
    it "can visit a post show page by clicking the title" do
      visit admin_posts_path
      click_link('Roar')
      page.should have_content "Roar"
    end

    it "can see an edit link that takes you to the edit post path" do
      visit admin_posts_path
      click_link('Roar')
      page.should have_content "Edit post"            
      click_link('Edit post')
      page.should have_selector "form"
    end
    it "can go to the admin homepage by clicking the Admin welcome page link" do
      visit admin_posts_path
      click_link('Roar')
      click_link('Admin welcome page')
      page.should have_content "Welcome to the admin panel!"
    end
  end
end
