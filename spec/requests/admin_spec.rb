require 'spec_helper'

describe 'Admin', :js => true do
  context "on admin homepage" do
    let!(:post) { Post.create(:title => "hey", :content => "you") }
    before :each do
      visit admin_posts_path
    end

    it "can see a list of recent posts"  do
      
      page.should have_content(post.title)
      
    end


    it "can edit a post by clicking the edit link next to a post" do
      
      click_link "Edit"
       expect {
         fill_in 'post_title',   with: "Hello world!"
        } 
      page.should have_content("Edit #{post.title.capitalize}")
    end

    it "can delete a post by clicking the delete link next to a post" do
      click_button "Delete"
    end
    
    it "can create a new post and view it" do
       visit new_admin_post_path

       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
         save_page
       }.to change{Post.count}.by(1)

       page.should have_content "Published: true"
       page.should have_content "Post was successfully saved."
     end

  end

  context "editing post" do
    let!(:post) { Post.create(:title => "hey", :content => "you", :is_published => true) }

    it "can mark an existing post as unpublished" do
      visit admin_posts_path
      click_link "Edit"
      page.uncheck('post_is_published')
      click_button "Save"

      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    let!(:post) { Post.create(:title => "whatupp", :content => "son", :is_published => true) }
    before :each do
      visit admin_posts_path
    end

    it "can visit a post show page by clicking the title" do 
      click_link "Whatupp"
      page.should have_content "son"
    end

    it "can see an edit link that takes you to the edit post path" do
      click_link "Edit"
      page.should have_content("Edit #{post.title.capitalize}")
    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do 
      click_link "Whatupp"
      click_link "Admin welcome page"
      page.should have_content("admin")
    end

  end
end
