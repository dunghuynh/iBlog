require 'spec_helper'

describe CommentsController do

  before :each do
    @user = User.make!
    @article = Article.make! :user => @user, :state => 3
  end

  describe "POST create" do
    it "should not create comment (anonymous)" do
      expect {
        post :create, :article_id => @article.id, :comment => { :user_id => @user.id, :body => "comment" }
      }.to_not change(Comment, :count)
    end

    context "signed in" do
      before :each do
        sign_in @user
      end

      it "creates comment" do
        expect {
          post :create, :article_id => @article.id, :comment => { :body => "comment" }
        }.to change(Comment, :count).by(1)
        response.should redirect_to(article_path(@article))
        flash[:notice].should == "Comment was successfully created."
      end

      it "should not assign comment to other user" do
        a_user = User.make!
        sign_in a_user
        expect {
          post :create, :article_id => @article.id, :comment => { :user_id => @user.id, :body => "comment" }
        }.to change(Comment, :count).by(1)
        assigns(:comment).user.should == a_user
      end

      it "should not assign comment to other article" do
        other_article = Article.make!
        expect {
          post :create, :article_id => @article.id, :comment => { :article_id => other_article.id, :body => "comment" }
        }.to change(Comment, :count).by(1)
        assigns(:comment).article.should == @article
      end

      it "should not create comment not assigned to article" do
        expect {
          post :create, :article_id => 0, :comment => { :user_id => @user.id, :body => "comment" }
        }.to_not change(Comment, :count)
        response.should redirect_to error_404_url
      end

      it "should create comment for published article only" do # state == 2 || 3
        (0..2).each do |unpublished_state|
          expect {
            @article.update_attribute(:state, unpublished_state)
            post :create, :article_id => @article.id, :comment => { :body => "comment" }
          }.to_not change {Comment.count}
        end
        [3,4].each do |published_state|
          expect {
            @article.update_attribute(:state, published_state)
            post :create, :article_id => @article.id, :comment => { :body => "comment" }
          }.to change {Comment.count}.by 1
        end
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      @comment = Comment.make! :article => @article, :user => @user
    end

    it "should not destroy comment (anonymous)" do
      expect {
        delete :destroy, :article_id => @article.id, :id => @comment.id
      }.to_not change(Comment, :count)
    end

    it "destroys comment linked to current user" do
      sign_in @user
      expect {
        delete :destroy, :article_id => @article.id, :id => @comment.id
      }.to change(Comment, :count).by(-1)
    end

    it "should not destroy comment linked to other user" do
      sign_in @user
      other_comment = Comment.make!
      expect {
        delete :destroy, :article_id => @article.id, :id => other_comment.id
      }.to_not change(Comment, :count)
    end
  end
end
