require 'spec_helper'

describe RatingsController do

  before :each do
    @user = User.make!
    @article = Article.make! :user => @user, :state => 3
  end

  describe "POST create" do
    it "should not create rating (anonymous)" do
      expect {
        post :create, :article_id => @article.id, :rating => { :stars => 4 }
      }.to_not change(Rating, :count)
      response.should redirect_to new_user_session_path
    end
    context "signed in" do
      before :each do
        sign_in @user
      end

      it "creates rating" do
        expect {
          post :create, :article_id => @article.id, :rating => { :stars => 4 }
        }.to change { Rating.count }.from(0).to(1)
        @article.ratings.last.stars.should == 4
        response.should redirect_to article_path(@article)
      end

      it "should not create rating not assigned to article" do
        expect {
          post :create, :article_id => 0, :rating => { :stars => 5 }
        }.to_not change { Rating.count }.by 1
        response.should redirect_to error_404_url
      end

      it "should not create rating not assigned to other user" do
        expect {
          post :create, :article_id => @article.id, :rating => { :user_id => 0, :stars => 4 }
        }.to change { Rating.count }.from(0).to(1)
        @article.ratings.last.user.should == @user
      end

      it "should not create rating to other article" do
        expect {
          post :create, :article_id => @article.id, :rating => { :article_id => 0, :stars => 4 }
        }.to change { Rating.count }.from(0).to(1)
        @article.ratings.last.article.should == @article
      end

      it "should assign rating to published article only" do
        (0..2).each do |unpublished_state|
          expect {
            @article.update_attribute(:state, unpublished_state)
            post :create, :article_id => @article.id, :rating => { :stars => 4 }
          }.to_not change {Rating.count}
        end
        [3,4].each do |published_state|
          expect {
            @article.update_attribute(:state, published_state)
            post :create, :article_id => @article.id, :rating => { :stars => 4 }
          }.to change {Rating.count}.by 1
        end
      end
    end
  end

  describe "PUT update" do
    before :each do
      @rating = Rating.make! :article => @article, :user => @user
    end

    it "should not update rating (anonymous)" do
      expect {
        put :update, :article_id => @article.id, :id => @rating.id, :rating => { :stars => 3 }
      }.to_not change { @rating.reload.stars }
    end

    it "updates rating" do
      sign_in @user
      expect {
        put :update, :article_id => @article.id, :id => @rating.id, :rating => { :stars => 3 }
      }.to change { @rating.reload.stars }
    end

    it "should not update rating linked to other user" do
      other_rating = Rating.make!
      sign_in @user
      expect {
        put :update, :article_id => other_rating.article.id, :id => other_rating.id, :rating => { :stars => 3 }
      }.to_not change { @rating.reload.stars }
    end
  end

  describe "DELETE destroy" do
    before :each do
      @rating = Rating.make! :article => @article, :user => @user
    end

    it "should not destroy rating (anonymous)" do
      expect {
        delete :destroy, :article_id => @article.id, :id => @rating.id
      }.to_not change(Rating, :count)
    end

    it "destroys comment linked to current user" do
      sign_in @user
      expect {
        delete :destroy, :article_id => @article.id, :id => @rating.id
      }.to change(Rating, :count).by(-1)
    end

    it "should not destroy comment linked to other user" do
      sign_in @user
      other_rating = Rating.make!
      expect {
        delete :destroy, :article_id => @article.id, :id => other_rating.id
      }.to_not change(Rating, :count)
    end
  end
end
