require 'spec_helper'

describe 'User' do
  context "on homepage" do
    it "sees a list of recent posts titles" do
      visit root_path
      page.should have_content(Post.first.title)
    end
    it "can not see bodies of the recent posts" do
      visit root_path
      page.should_not have_content(Post.first.content)
    end
    it "can click on titles of recent posts and should be on the post show page" do
      visit root_path
      all('a')[1].click
      page.should have_content(Post.first.content)
    end
    it "can not see the edit link" do
      visit root_path
      page.should_not have_link('Edit')
    end
    it "can not see the delete link" do
      visit root_path
      page.should_not have_link('Delete')
    end
  end

  context "post show page" do
    let(:post){ Post.first }
    it "sees title and body of the post" do
      visit post_path(post)
      page.should have_content(post.title)
      page.should have_content(post.content)
    end
    it "can not see the edit link" do
      visit post_path(post)
      page.should_not have_link('Edit')
    end
    it "can not see the published flag" do
      visit post_path(post)
      page.should_not have_content('Published: ')
    end
    it "can not see the Admin homepage link" do
      visit post_path(post)
      page.should_not have_link('Admin welcome page')
    end
  end
end
