class ProfilesController < ApplicationController
   def index
    @user = User.find(1)
    raise Forbidden unless user_safe?

    @skill_categories = @user.skills.preload(:skill_category).map(&:skill_category).uniq
    @articles = @user.articles
  end

  private

  def user_safe?
    @user.user_cautions.joins(:caution_freeze).
      where("caution_freezes.end_time > ?", Time.zone.now).blank?
  end
end
